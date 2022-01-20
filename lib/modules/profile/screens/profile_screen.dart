import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/core/auth/blocs/auth_bloc.dart';
import 'package:geraisdm/core/auth/models/user_model.dart';
import 'package:geraisdm/modules/profile/blocs/profile_bloc/profile_bloc.dart';
import 'package:geraisdm/modules/profile/screens/components/menu_tile_card.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/general_component.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ProfileBloc>()..add(ProfileFetch()),
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccess) {
                  return _buildSuccess(context, data: state.data);
                }

                if (state is ProfileFailure) {
                  return _buildFailure(context);
                }

                return _buildLoading();
              },
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                MenuTileCard(
                  title: LocaleKeys.profile_menu_change_password.tr(),
                  icon: Icons.lock_clock,
                  onTap: () {
                    context.pushRoute(const ProfilePasswordRoute());
                  },
                ),
                MenuTileCard(
                  title: LocaleKeys.profile_menu_biodata.tr(),
                  icon: Icons.water_damage_outlined,
                  onTap: () {
                    context.pushRoute(const ProfileBiodataRoute());
                  },
                ),
                MenuTileCard(
                  title: LocaleKeys.profile_menu_my_complaint.tr(),
                  icon: Icons.note_alt_rounded,
                  onTap: () {
                    context.pushRoute(const ComplaintRoute());
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: GhostButton.large(
                      buttonText: LocaleKeys.profile_menu_logout.tr(),
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutEv());
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Column(
      children: const [
        SkeletonLoaderSquare(
          width: 130,
          height: 130,
          roundedRadius: 12,
        ),
        SizedBox(height: 8),
        SkeletonLoaderSquare(width: 150, height: 16),
        SizedBox(height: 8),
        SkeletonLoaderSquare(width: 170, height: 12),
      ],
    );
  }

  Widget _buildFailure(BuildContext context) {
    return CommonPlaceholder.noIcon(
        title: LocaleKeys.profile_error_title.tr(),
        subtitle: LocaleKeys.profile_error_subtitle.tr(),
        action: FilledButton.large(
            buttonText: LocaleKeys.profile_error_retry.tr(),
            onPressed: () {
              context.read<ProfileBloc>().add(ProfileFetch());
            }));
  }

  Widget _buildSuccess(BuildContext context, {required AuthUserModel data}) {
    return Column(
      children: [
        ImagePlaceholder(
          height: 130,
          width: 130,
          borderRadius: BorderRadius.circular(12),
          imageUrl: data.avatar,
        ),
        const SizedBox(height: 8),
        Text(
          data.fullName,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 4),
        Text(data.employeeId),
        const SizedBox(height: 4),
        Text(data.accountType.name.toUpperCase(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
      ],
    );
  }
}
