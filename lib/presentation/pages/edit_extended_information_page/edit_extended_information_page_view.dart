// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/pages/edit_extended_information_page/widgets/edit_extended_information_section.dart';

class EditExtendedInformationPageView extends StatelessWidget {
  const EditExtendedInformationPageView({super.key});

  AppRouter get router => service<AppRouter>();

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.extendedInformation,
    );
  }

  Widget _buildContent(BuildContext context) {
    final List<Widget> sections = [
      EditExtendedInformationSection(
        title: L10n.of(context)!.languages,
        onTap: () => router.goToEditLanguagesPage(),
      ),
      EditExtendedInformationSection(
        title: L10n.of(context)!.education,
        onTap: () => router.goToEditEducationPage(),
      ),
      EditExtendedInformationSection(
        title: L10n.of(context)!.career,
        onTap: () => router.goToEditCareerPage(),
      ),
      EditExtendedInformationSection(
        title: L10n.of(context)!.hobby,
        onTap: () => router.goToEditHobbyPage(),
      ),
      EditExtendedInformationSection(
        title: L10n.of(context)!.animals,
        onTap: () => router.goToEditAnimalsPage(),
      ),
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemBuilder: (context, index) => sections[index],
      separatorBuilder: (_, __) => Container(
        width: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
        height: 1.r,
        color: NColors.gray2,
      ),
      itemCount: sections.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildContent(context),
    );
  }
}
