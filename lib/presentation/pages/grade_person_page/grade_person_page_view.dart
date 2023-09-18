// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

// Project imports:
import 'package:norm/internal/page_providers/grade_person_page/states/grade_person_state.dart';
import 'package:norm/presentation/pages/grade_person_page/widgets/grade_person_page_slider.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/divider/n_horizontal_divider.dart';
import 'package:norm/presentation/global/n_dropdown/n_dropdown.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/pages/grade_person_page/widgets/grade_person_page_base_container.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/grade_header/grade_header.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/page_providers/profile_page/states/profile_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/presentation/global/error_message/error_message.dart';
import 'package:norm/presentation/pages/grade_person_page/widgets/grade_person_page_rate_widget.dart';

enum KnowTime { lastYear, lessThan3Years, moreThan3Years }

enum ClosenessType { littleKnow, wellKnow, veryClose }

class GradePersonPageView extends StatelessWidget {
  const GradePersonPageView({Key? key, required this.user}) : super(key: key);

  AppRouter get router => service<AppRouter>();

  final User user;

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return const NAppBar(
      title: "Оценить",
    );
  }

  Widget _buildPersonalQualities(BuildContext context) {
    GradePersonState state = context.watch<GradePersonState>();
    return GradePersonPageBaseContainer(
      title: L10n.of(context)!.personalQualities, //'Личные качества',
      description: L10n.of(context)!.personalQualitiesDescription,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GradePersonPageSlider(
            value: state.openness,
            onChanged: state.updateOpenness,
            positiveTitle: L10n.of(context)!.openness,
            negativeTitle: L10n.of(context)!.closeness,
          ),
          GradePersonPageSlider(
            value: state.responsive,
            onChanged: state.updateResponsive,
            positiveTitle: L10n.of(context)!.responsive,
            negativeTitle: L10n.of(context)!.coldness,
          ),
          GradePersonPageSlider(
            value: state.conflicts,
            onChanged: state.updateConflicts,
            positiveTitle: L10n.of(context)!.conflict,
            negativeTitle: L10n.of(context)!.conformity,
          ),
          GradePersonPageSlider(
            value: state.selfishness,
            onChanged: state.updateSelfishness,
            positiveTitle: L10n.of(context)!.selfishness,
            negativeTitle: L10n.of(context)!.altruism,
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalQualities(BuildContext context) {
    GradePersonState state = context.watch<GradePersonState>();
    return GradePersonPageBaseContainer(
      title: L10n.of(context)!.professionalQuality,
      description: L10n.of(context)!.professionalQualitiesDescription,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GradePersonPageSlider(
            value: state.reliability,
            onChanged: state.updateReliability,
            positiveTitle: L10n.of(context)!.reliability,
            negativeTitle: L10n.of(context)!.irresponsibility,
          ),
          GradePersonPageSlider(
            value: state.consistency,
            onChanged: state.updateConsistency,
            positiveTitle: L10n.of(context)!.consistency,
            negativeTitle: L10n.of(context)!.inconsistency,
          ),
          GradePersonPageSlider(
            value: state.creativity,
            onChanged: state.updateCreativity,
            positiveTitle: L10n.of(context)!.creativity,
            negativeTitle: L10n.of(context)!.encyclopedic,
          ),
          GradePersonPageSlider(
            value: state.initiative,
            onChanged: state.updateInitiative,
            positiveTitle: L10n.of(context)!.initiative,
            negativeTitle: L10n.of(context)!.diligence,
          ),
        ],
      ),
    );
  }

  ///todo: сделать как появится бэк
  Widget _buildAddQualities(BuildContext context) {
    return GradePersonPageBaseContainer(
        title: L10n.of(context)!.addMore, description: L10n.of(context)!.addMoreDescription, child: Container());
  }

  Widget _buildPlusAndMinus(BuildContext context) {
    GradePersonState state = context.watch<GradePersonState>();
    return GradePersonPageBaseContainer(
      title: L10n.of(context)!.plusesAndMinuses,
      description: L10n.of(context)!.plusesAndMinusesDescription,
      child: Column(
        children: [
          NTextField(
            width: 343.w,
            maxLines: 5,
            hintText: L10n.of(context)!.pluses,
            onChanged: state.setPluses,
          ),
          SizedBox(height: 16.w),
          NTextField(
            width: 343.w,
            maxLines: 5,
            hintText: L10n.of(context)!.minuses,
            onChanged: state.setMinuses,
          ),
        ],
      ),
    );
  }

  Widget _buildKnowPersonally(BuildContext context) {
    GradePersonState state = context.watch<GradePersonState>();
    return GradePersonPageBaseContainer(
      title: L10n.of(context)!.knowPersonally,
      child: Column(
        children: [
          NDropdown(
            value: state.knowPersonally,
            width: double.infinity,
            items: [
              NDropdownItem(title: L10n.of(context)!.no, value: false),
              NDropdownItem(title: L10n.of(context)!.yes, value: true)
            ],
            hint: '',
            onChanged: (value) => context.read<GradePersonState>().setKnowPersonally(value),
          ),
          if (state.knowPersonally) ...[
            SizedBox(
              height: 16.h,
            ),
            NDropdown(
              value: state.knowTime,
              width: double.infinity,
              items: KnowTime.values
                  .map(
                    (e) => NDropdownItem(title: knowTimeTitle(context, e), value: e.index),
                  )
                  .toList(),
              hint: L10n.of(context)!.howLong,
              onChanged: (value) => context.read<GradePersonState>().setKnowTime(value),
            ),
            SizedBox(
              height: 16.h,
            ),
            NDropdown(
              value: state.closeness,
              width: double.infinity,
              items: ClosenessType.values
                  .map(
                    (e) => NDropdownItem(title: closenessTypeTitle(context, e), value: e.index),
                  )
                  .toList(),
              hint: L10n.of(context)!.howClose,
              onChanged: (value) => context.read<GradePersonState>().setCloseness(value),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVouch(BuildContext context) {
    GradePersonState state = context.watch<GradePersonState>();
    return GradePersonPageBaseContainer(
      title: L10n.of(context)!.canVouch,
      description: L10n.of(context)!.canVouchDescription,
      child: NDropdown(
        value: state.garant,
        width: double.infinity,
        items: [
          NDropdownItem(title: L10n.of(context)!.yes, value: true),
          NDropdownItem(title: L10n.of(context)!.no, value: false),
        ],
        onChanged: (value) => context.read<GradePersonState>().setGarant(value),
        hint: L10n.of(context)!.select,
      ),
    );
  }

  Widget _buildReviewButton(BuildContext context) {
    GradePersonState state = context.watch<GradePersonState>();
    return GestureDetector(
      onTap: () => state.changeSendAnonymously(),
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          AnimatedCrossFade(
            firstChild: NIcon(NIcons.checkbox),
            secondChild: NIcon(NIcons.checkbox_on),
            crossFadeState: state.sendAnonymously ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: NConstants.defaultAnimationDuration * 0.5,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            L10n.of(context)!.sendAnonymously,
            style: NTypography.golosRegular16,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendAsSpecialist(BuildContext context) {
    GradePersonState state = context.watch<GradePersonState>();
    return GradePersonPageBaseContainer(
      title: L10n.of(context)!.recommendAsSpecialist,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NDropdown(
            value: state.specId,
            width: double.infinity,
            items: user.specs.map((e) => NDropdownItem(title: e.title, value: e.id)).toList(),
            onChanged: (value) => context.read<GradePersonState>().setSpecId(value),
            hint: L10n.of(context)!.select,
          ),
          if (state.specId != -1) ...[
            SizedBox(
              height: 16.h,
            ),
            NDropdown(
              value: state.specKnowTime,
              width: double.infinity,
              items: KnowTime.values
                  .map(
                    (e) => NDropdownItem(title: knowTimeTitle(context, e), value: e.index),
                  )
                  .toList(),
              onChanged: (value) => context.read<GradePersonState>().setSpecKnowTime(value),
              hint: L10n.of(context)!.howLongUsing,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Оцените',
              style: NTypography.golosRegular14,
            ),
            GradePersonPageRateWidget(onChanged: state.setSpecRate, rate: state.specRate),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Ваш отзыв',
              style: NTypography.rfDewiBold20,
            ),
            SizedBox(
              height: 12.h,
            ),
            _buildReviewButton(context),
            SizedBox(
              height: 18.h,
            ),
            NTextField(
              width: 343.w,
              maxLines: 5,
              hintText: L10n.of(context)!.pluses,
              onChanged: state.setSpecPluses,
            ),
            SizedBox(height: 16.w),
            NTextField(
              width: 343.w,
              maxLines: 5,
              hintText: L10n.of(context)!.minuses,
              onChanged: state.setSpecMinuses,
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    GradePersonState state = context.watch<GradePersonState>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        children: [
          if (state.errors.isNotEmpty) ...[
            _buildErrors(context),
            SizedBox(
              height: 24.h,
            ),
          ],
          NButton(
            onPressed: () async {
              if (await state.sendUserRate(user.id)) {
                router.pop();
              }
            },
            active: state.canRateUser,
            title: 'Добавить',
            width: 343.w,
            isLoading: state.isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildErrors(BuildContext context) {
    return Observer(
      builder: (context) => ErrorMessage(
        message: errorMessagesLocalized(context, context.watch<GradePersonState>().errors),
      ),
      warnWhenNoObservables: false,
    );
  }

  Widget _buildContent(BuildContext context) {
    GradePersonState state = context.watch<GradePersonState>();
    List<Widget> content = [
      GradeHeader(imageUrl: user.avatar250 ?? '', name: user.nickname, onChanged: state.setRate, grade: state.rate),
      _buildPersonalQualities(context),
      _buildProfessionalQualities(context),
      _buildPlusAndMinus(context),
      _buildKnowPersonally(context),
      if (state.knowPersonally) ...[
        _buildVouch(context),
      ],
      if (user.specs.isNotEmpty) ...[
        _buildRecommendAsSpecialist(context),
      ],
      _buildSendButton(context),
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: SafeArea(
        child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => content[index],
            separatorBuilder: (context, index) => NHorizontalDivider(
                  height: index == content.length - 2 ? 0 : 8,
                ),
            itemCount: content.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Observer(builder: (context) => _buildContent(context)),
    );
  }
}
