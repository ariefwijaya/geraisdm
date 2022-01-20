import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/articles/blocs/article_list_bloc/article_list_bloc.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/modules/articles/screens/components/article_card.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticleListBloc>(
      create: (context) =>
          getIt.get<ArticleListBloc>()..add(ArticleListStarted()),
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.article_title.tr()),
        ),
        body: BlocBuilder<ArticleListBloc, ArticleListState>(
          builder: (context, state) {
            if (state is ArticleListStartSuccess) {
              return RefreshIndicator(
                onRefresh: () => Future.sync(() =>
                    context.read<ArticleListBloc>().add(ArticleRefresh())),
                child: PagedListView<int, ArticleModel>.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  pagingController: state.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ArticleModel>(
                    itemBuilder: (context, entry, index) {
                      return ArticleCard(
                          title: entry.title,
                          imageUrl: entry.image,
                          date: DateFormat("d MMMM yyyy, hh:mm")
                              .format(entry.date),
                          onTap: () {
                            context.router.push(ArticleDetailRoute(
                                id: entry.id, title: entry.title));
                          });
                    },
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
