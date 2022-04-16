import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/search/blocs/search_bloc/search_bloc.dart';
import 'package:geraisdm/modules/search/models/search_model.dart';
import 'package:geraisdm/modules/search/screens/components/search_item_card.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/components/search_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = getIt.get<SearchBloc>()..add(SearchStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchBloc,
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            bottom: PreferredSize(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchBar(
                    onChanged: (value) {
                      _searchBloc.add(SearchRefresh(query: value));
                    },
                  ),
                ),
                preferredSize: const Size(double.infinity, 40)),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            sliver: BlocBuilder<SearchBloc, SearchState>(
              bloc: _searchBloc,
              builder: (context, state) {
                if (state is SearchStartSuccess) {
                  return PagedSliverList.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    pagingController: state.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<SearchModel>(
                      itemBuilder: (context, entry, index) {
                        return SearchItemCard(
                          name: entry.name,
                          locked: entry.locked,
                          description: entry.description,
                          icon: entry.icon,
                          onTap: () {
                            if (entry.actionType == SearchActionType.screen) {
                              getIt.get<AppRouter>().pushNamed(entry.path!,
                                  includePrefixMatches: true);
                            } else if (entry.actionType ==
                                SearchActionType.url) {
                              LauncherHelper.openUrl(entry.path!);
                            }
                          },
                        );
                      },
                    ),
                  );
                }

                return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
              },
            ),
          )
        ],
      )),
    );
  }
}
