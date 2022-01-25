import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/home/blocs/home_bloc/home_bloc.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/general_component.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return _buildSuccess(context,
              name: state.name, avatar: state.avatarUrl);
        }
        if (state is HomeFailure) {
          return _buildFailure(context);
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    return AppBar(
      title: Row(
        children: [
          const SkeletonLoaderCircle(size: 45),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonLoaderSquare(width: double.infinity, height: 18),
                SizedBox(height: 8),
                SkeletonLoaderSquare(width: double.infinity, height: 12)
              ],
            ),
          ),
          const SizedBox(width: 15),
          const SkeletonLoaderCircle(size: 30),
          const SizedBox(width: 6),
          const SkeletonLoaderCircle(size: 30)
        ],
      ),
    );
  }

  Widget _buildFailure(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.home_config_failed_title.tr()),
          const SizedBox(width: 16),
          GhostButton.small(
              infiniteWidth: false,
              buttonText: LocaleKeys.home_config_failed_retry.tr(),
              onPressed: () {
                context.read<HomeBloc>().add(HomeFetchHeader());
              })
        ],
      ),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required String name, String? avatar}) {
    return AppBar(
      title: InkWell(
        onTap: () {
          context.navigateTo(const ProfileRouter());
        },
        child: Row(
          children: [
            ImagePlaceholder(
              shape: BoxShape.circle,
              height: 45,
              width: 45,
              imageUrl: avatar,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.home_halo_title.tr(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
