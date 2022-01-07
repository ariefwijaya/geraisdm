import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/core/deeplink/blocs/deeplink_bloc/deeplink_bloc.dart';
import 'package:auto_route/auto_route.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeeplinkBloc, DeeplinkState>(
      listener: (context, state) {
        if (state is DeeplinkNavigated) {
          context.navigateNamedTo(state.path, includePrefixMatches: true);
        }
      },
    );
  }
}
