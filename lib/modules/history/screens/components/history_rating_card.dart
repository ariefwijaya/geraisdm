import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/history/blocs/history_rating_bloc/history_rating_bloc.dart';
import 'package:geraisdm/widgets/alert_component.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HistoryRatingCard extends StatefulWidget {
  final int id;
  final double? initialRating;
  const HistoryRatingCard({Key? key, required this.id, this.initialRating})
      : super(key: key);

  @override
  _HistoryRatingCardState createState() => _HistoryRatingCardState();
}

class _HistoryRatingCardState extends State<HistoryRatingCard> {
  double? currentRating;
  late HistoryRatingBloc historyRatingBloc;

  @override
  void initState() {
    historyRatingBloc = getIt.get<HistoryRatingBloc>();
    currentRating = widget.initialRating ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    historyRatingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => historyRatingBloc,
      child: BlocBuilder<HistoryRatingBloc, HistoryRatingState>(
        bloc: historyRatingBloc,
        builder: (context, state) {
          if (state is HistoryRatingSuccess) {
            currentRating = state.value;
          }
          return Center(
            child: GestureDetector(
              child: RatingBarIndicator(
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemSize: 36,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                rating: currentRating!,
              ),
              onTap: state is HistoryRatingLoading ||
                      state is HistoryRatingSuccess
                  ? null
                  : () async {
                      final res = await _showReviewForm(context,
                          id: widget.id, initialRating: currentRating!);

                      if (res != null) {
                        historyRatingBloc
                            .add(HistoryRatingStart(id: widget.id, value: res));
                      }
                    },
            ),
          );
        },
      ),
    );
  }

  Future<double?> _showReviewForm(BuildContext context,
      {required int id, required double initialRating}) {
    double ratingVal = initialRating;
    return showRoundedModalBottomSheet(
      context: context,
      isScrollControlled: true,
      title: LocaleKeys.survey_kepuasan_title.tr(),
      builder: (bottomContext) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  LocaleKeys.survey_kepuasan_subtitle.tr(),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: initialRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratingVal = rating;
                  },
                ),
              ],
            ),
            const Divider(height: 20),
            Container(
              child: FilledButton.large(
                buttonText: LocaleKeys.survey_kepuasan_submit.tr(),
                onPressed: () {
                  Navigator.pop(context, ratingVal);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
