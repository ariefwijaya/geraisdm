import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/core/auth/blocs/auth_bloc.dart';
import 'package:geraisdm/core/auth/models/user_model.dart';
import 'package:geraisdm/core/settings/models/environment_model.dart';
import 'package:geraisdm/modules/profile/blocs/profile_avatar_update_bloc/profile_avatar_update_bloc.dart';
import 'package:geraisdm/modules/profile/blocs/profile_bloc/profile_bloc.dart';
import 'package:geraisdm/modules/profile/screens/components/menu_tile_card.dart';
import 'package:geraisdm/utils/helpers/format_helper.dart';
import 'package:geraisdm/widgets/alert_component.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/general_component.dart';
import 'package:geraisdm/widgets/image_viewer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<ProfileBloc>()..add(ProfileFetch()),
          child: Container(),
        ),
        BlocProvider(create: (context) => getIt.get<ProfileAvatarUpdateBloc>())
      ],
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
                ),
                const SizedBox(height: 8),
                Text(
                    "${LocaleKeys.version.tr()} ${getIt.get<EnvironmentModel>().appVersion}")
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
        BlocConsumer<ProfileAvatarUpdateBloc, ProfileAvatarUpdateState>(
          listener: (context, state) {
            if (state is ProfileAvatarUpdateFailed) {
              FlushbarHelper.createError(
                      message: LocaleKeys.avatar_upload_file_failed.tr())
                  .show(context);
            }
          },
          builder: (context, state) {
            String? avatar = data.avatar;
            if (state is ProfileAvatarUpdateSuccess) {
              avatar = state.data.uploadedFileUrl;
            }

            if (state is ProfileAvatarUpdateLoading) {
              return const SkeletonLoaderSquare(
                width: 130,
                height: 130,
                roundedRadius: 12,
              );
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (avatar != null) {
                      context.router
                          .pushWidget(ImageGalleryViewer(imageUrls: [avatar]));
                    }
                  },
                  child: ImagePlaceholder(
                    height: 130,
                    width: 130,
                    borderRadius: BorderRadius.circular(12),
                    imageUrl: avatar,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleButton(
                      elevation: 10,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      onPressed: () {
                        showRoundedModalBottomSheet(
                            context: context,
                            enableCloseButton: false,
                            builder: (subcontext) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: FilledButton.large(
                                            suffixIcon:
                                                const Icon(Icons.camera_alt),
                                            buttonText: LocaleKeys
                                                .avatar_upload_camera
                                                .tr(),
                                            onPressed: () {
                                              context
                                                  .read<
                                                      ProfileAvatarUpdateBloc>()
                                                  .add(
                                                      ProfileAvatarUpdateCameraStarted());

                                              subcontext.popRoute();
                                            })),
                                    const SizedBox(width: 16),
                                    Expanded(
                                        child: FilledButton.large(
                                            suffixIcon: const Icon(Icons.image),
                                            buttonText: LocaleKeys
                                                .avatar_upload_gallery
                                                .tr(),
                                            onPressed: () {
                                              context
                                                  .read<
                                                      ProfileAvatarUpdateBloc>()
                                                  .add(
                                                      ProfileAvatarUpdateGalleryStarted());
                                              subcontext.popRoute();
                                            }))
                                  ],
                                ),
                              );
                            });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Icon(Icons.file_upload_outlined),
                      ),
                    ))
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          data.fullName,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 4),
        Text(data.employeeId),
        const SizedBox(height: 4),
        Text(FormatHelper.enumName(data.accountType).toUpperCase(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
      ],
    );
  }
}
