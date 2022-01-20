import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/profile/blocs/profile_biodata_bloc/profile_biodata_bloc.dart';
import 'package:geraisdm/modules/profile/models/profile_biodata_model.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/assets.gen.dart';

class ProfileBiodataScreen extends StatelessWidget {
  const ProfileBiodataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<ProfileBiodataBloc>()..add(ProfileBiodataFetch()),
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.profile_menu_biodata.tr()),
        ),
        body: BlocBuilder<ProfileBiodataBloc, ProfileBiodataState>(
          builder: (context, state) {
            if (state is ProfileBiodataSuccess) {
              return _buildSuccess(context, listData: state.listData);
            }
            if (state is ProfileBiodataFailure) {
              return _buildFailure(context);
            }

            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildFailure(BuildContext context) {
    return CommonPlaceholder.customIcon(
        icon: Assets.images.illustration.warningCyt.image(height: 200),
        title: LocaleKeys.biodata_error_title.tr(),
        subtitle: LocaleKeys.biodata_error_subtitle.tr(),
        action: FilledButton.large(
            buttonText: LocaleKeys.biodata_error_retry.tr(),
            onPressed: () {
              context.read<ProfileBiodataBloc>().add(ProfileBiodataFetch());
            }));
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required List<ProfileBiodataModel> listData}) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final data = listData[index];
          return ListTile(
            title: Text(data.name),
            subtitle: Text(data.value),
          );
        },
        itemCount: listData.length);
  }
}
