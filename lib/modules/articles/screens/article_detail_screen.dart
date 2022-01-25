import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/articles/blocs/article_bloc/article_bloc.dart';
import 'package:geraisdm/modules/articles/blocs/article_like_bloc/article_like_bloc.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/widgets/general_component.dart';
import 'package:geraisdm/widgets/image_viewer.dart';

class ArticleDetailScreen extends StatelessWidget {
  final int id;
  final String? title;
  const ArticleDetailScreen(
      {Key? key, @pathParam required this.id, @queryParam this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                getIt.get<ArticleBloc>()..add(ArticleFetchDetail(id: id))),
        BlocProvider(create: (context) => getIt.get<ArticleLikeBloc>())
      ],
      child: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleDetailSuccess) {
            return _buildSuccess(context, data: state.data);
          }

          if (state is ArticleFailure) {
            return _buildError(context);
          }

          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, {required ArticleModel data}) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            leading: const RouteBackButton(),
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.share,
                    size: 30,
                  ),
                  onPressed: () => LauncherHelper.share(
                      data.title + "\n" + (data.linkShare ?? ""),
                      subject: Env.appName))
            ],
            iconTheme:
                IconThemeData(color: Theme.of(context).scaffoldBackgroundColor),
            backgroundColor: Theme.of(context).primaryColor,
            expandedHeight: 180,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () {
                  if (data.image != null) {
                    context.router.pushWidget(
                        ImageGalleryViewer(imageUrls: [data.image!]),
                        fullscreenDialog: true);
                  }
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: "0 ${data.image}",
                      child: ImagePlaceholder(
                        imageUrl: data.image,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Theme.of(context).shadowColor.withOpacity(0.9),
                            Colors.transparent,
                            Theme.of(context).shadowColor.withOpacity(0.5),
                          ])),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      const SizedBox(width: 8),
                      BlocBuilder<ArticleLikeBloc, ArticleLikeState>(
                        builder: (context, state) {
                          bool liked = data.liked;

                          if (state is ArticleLikeSuccess) {
                            liked = state.liked;
                          }

                          return IconButton(
                              onPressed: () {
                                context.read<ArticleLikeBloc>().add(
                                    ArticleLikeStart(id: id, like: !liked));
                              },
                              icon: Icon(
                                Icons.favorite,
                                size: 30,
                                color: liked
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).highlightColor,
                              ));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat("d MMM yyyy, hh:mm").format(data.date),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.person,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              data.author,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      thickness: 2,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                  if (data.content != null)
                    HtmlViewer(htmlString: data.content!)
                  else
                    Center(
                      child: Text(
                        LocaleKeys.article_detail_notfound_title.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const RouteBackButton(),
        title: Text(title ?? LocaleKeys.article_detail_title.tr()),
      ),
      body: CommonPlaceholder.error(
          title: LocaleKeys.article_detail_error_title.tr(),
          subtitle: LocaleKeys.article_detail_error_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.article_detail_error_retry.tr(),
              onPressed: () {
                context.read<ArticleBloc>().add(ArticleFetchDetail(id: id));
              })),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(title ?? LocaleKeys.article_detail_title.tr()),
        ),
        body: const Center(child: CircularProgressIndicator()));
  }
}
