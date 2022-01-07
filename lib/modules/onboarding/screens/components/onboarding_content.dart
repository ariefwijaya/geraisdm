import 'package:flutter/material.dart';
import '../../../../config/routes/routes.gr.dart';
import '../../../../widgets/common_placeholder.dart';
import '../../../../widgets/button_component.dart';
import '../../models/onboarding_model.dart';
import '../../../../constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_route/auto_route.dart';

import 'onboarding_indicator.dart';

class OnboardingContent extends StatefulWidget {
  final bool enabledSkip;
  final List<OnboardingModel> contents;
  const OnboardingContent(
      {Key? key, required this.enabledSkip, required this.contents})
      : super(key: key);

  @override
  _OnboardingContentState createState() => _OnboardingContentState();
}

class _OnboardingContentState extends State<OnboardingContent> {
  final PageController controller = PageController();
  int _current = 0;

  /// Onboarding Step
  late final List<OnboardingModel> contents;

  @override
  void initState() {
    super.initState();
    contents = widget.contents;
  }

  bool get isLastStep =>
      contents.isNotEmpty && (contents.length - 1 == _current);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          padding:
              const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 15),
          child: Row(
            children: [
              Expanded(
                child: OnboardIndicator(
                    length: contents.length, currentIndex: _current),
              ),
              Container(
                child: isLastStep
                    ? FilledButton.large(
                        infiniteWidth: false,
                        buttonText: LocaleKeys.onboarding_start.tr(),
                        onPressed: () => context.router.push(LoginRoute()))
                    : FloatingButton(
                        onPressed: () => controller.animateToPage(_current + 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                        iconData: Icons.chevron_right),
              )
            ],
          )),
      body: Stack(
        children: [
          PageView(
              controller: controller,
              onPageChanged: (pageIndex) {
                setState(() {
                  _current = pageIndex;
                });
              },
              children: contents
                  .map<Widget>((e) => _OnboardingContent(
                      data: e,
                      totalContent: contents.length,
                      currentIndex: _current))
                  .toList()),
          if (!isLastStep)
            Positioned(
              top: kToolbarHeight,
              right: 24,
              child: NudeButton.small(
                  buttonText: LocaleKeys.onboarding_skip.tr(),
                  onPressed: () {
                    controller.animateToPage(contents.length - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  infiniteWidth: false),
            )
        ],
      ),
    );
  }
}

class _OnboardingContent extends StatelessWidget {
  final OnboardingModel data;
  final int totalContent;
  final int currentIndex;
  const _OnboardingContent(
      {Key? key,
      required this.data,
      required this.totalContent,
      required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: kToolbarHeight + 15),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: ImagePlaceholder(
            imageUrl: data.imagePath,
            imageFit: BoxFit.contain,
            height: 300,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.titleKey.tr(),
                  style: Theme.of(context).textTheme.headline2),
              const SizedBox(height: 20),
              if (data.descriptionKey != null) Text(data.descriptionKey!.tr())
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
