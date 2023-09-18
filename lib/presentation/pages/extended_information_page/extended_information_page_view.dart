// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/page_providers/extended_information_page/states/extended_information_state.dart';
import 'package:norm/presentation/global/divider/n_horizontal_divider.dart';
import 'package:norm/presentation/pages/extended_information_page/widgets/extended_information_animals.dart';
import 'package:norm/presentation/pages/extended_information_page/widgets/extended_information_career.dart';
import 'package:norm/presentation/pages/extended_information_page/widgets/extended_information_education.dart';
import 'package:norm/presentation/pages/extended_information_page/widgets/extended_information_hobby.dart';
import 'package:norm/presentation/pages/extended_information_page/widgets/extended_information_languages.dart';
import 'package:norm/presentation/pages/extended_information_page/widgets/extended_information_page_app_bar.dart';

class ExtendedInformationPageView extends StatelessWidget {
  const ExtendedInformationPageView({
    super.key,
    required this.fromProfile,
  });

  /// Parent profile route.
  final Profile fromProfile;

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return ExtendedInformationPageAppBar(
      fromProfile: fromProfile,
    );
  }

  Widget _buildLanguages(BuildContext context) {
    final ExtendedInformationState state = context.watch<ExtendedInformationState>();

    return ExtendedInformationLanguages(
      languages: state.user.languages,
    );
  }

  Widget _buildEducation(BuildContext context) {
    final ExtendedInformationState state = context.watch<ExtendedInformationState>();

    return ExtendedInformationEducation(
      education: state.user.educations,
    );
  }

  Widget _buildCareer(BuildContext context) {
    final ExtendedInformationState state = context.watch<ExtendedInformationState>();

    return ExtendedInformationCareer(
      career: state.user.career,
    );
  }

  Widget _buildHobby(BuildContext context) {
    final ExtendedInformationState state = context.watch<ExtendedInformationState>();

    return ExtendedInformationHobby(
      hobbies: state.user.hobbies,
    );
  }

  Widget _buildAnimals(BuildContext context) {
    final ExtendedInformationState state = context.watch<ExtendedInformationState>();

    return ExtendedInformationAnimals(
      animals: state.user.animals,
    );
  }

  Widget _buildContent(BuildContext context) {
    final ExtendedInformationState state = context.watch<ExtendedInformationState>();
    final User user = state.user;

    final List<Widget> widgets = [
      if (user.languages.isNotEmpty) _buildLanguages(context),
      if (user.educations.isNotEmpty) _buildEducation(context),
      if (user.career.isNotEmpty) _buildCareer(context),
      if (user.hobbies.isNotEmpty) _buildHobby(context),
      if (user.animals.isNotEmpty) _buildAnimals(context),
    ];

    return SafeArea(
      child: ListView.separated(
        itemBuilder: (context, index) => widgets[index],
        separatorBuilder: (_, __) => const NHorizontalDivider(),
        itemCount: widgets.length,
      ),
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
