import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import '../../repositories/deeplink_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'deeplink_event.dart';
part 'deeplink_state.dart';

@singleton
class DeeplinkBloc extends Bloc<DeeplinkEvent, DeeplinkState> {
  final DeeplinkRepositoryInterface deeplinkRepository;
  late StreamSubscription<PendingDynamicLinkData> onLink;

  @override
  Future<void> close() {
    onLink.cancel();
    return super.close();
  }

  DeeplinkBloc({required this.deeplinkRepository}) : super(DeeplinkInitial()) {
    on<DeeplinkStarted>((event, emit) async {
      try {
        emit(DeeplinkLoading());
        deeplinkRepository.onLinkStream().listen((linkData) {
          add(DeeplinkStartNavigate(path: linkData.link.path));
        }).onError((Object error, StackTrace stacTrace) {
          add(DeeplinkThrowError(error: error, stackTrace: stacTrace));
        });

        final initialLink = await deeplinkRepository.getInitialLink();
        if (initialLink != null) {
          emit(DeeplinkNavigated(path: initialLink));
        } else {
          emit(DeeplinkNoData());
        }
      } catch (e, s) {
        emit(DeeplinkFailure(error: e, stackTrace: s));
      }
    });

    on<DeeplinkStartNavigate>((event, emit) {
      emit(DeeplinkNavigated(path: event.path));
    });

    on<DeeplinkThrowError>((event, emit) {
      emit(DeeplinkFailure(error: event.error, stackTrace: event.stackTrace));
    });
  }
}
