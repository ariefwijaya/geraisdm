import 'package:flutter/material.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HistorySurveyScreen extends StatelessWidget {
  final int id;
  const HistorySurveyScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.survey_kepuasan_title.tr()),
      ),
      body: Column(
        children: [Text(LocaleKeys.survey_kepuasan_subtitle.tr())],
      ),
    );
  }
}
