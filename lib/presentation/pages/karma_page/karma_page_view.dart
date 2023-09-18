// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/page_providers/karma_page_wrapper/states/karma_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/karma_wrapper/karma_wrapper.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/pages/karma_page/widgets/karma_graph.dart';

class KarmaPageView extends StatelessWidget {
  const KarmaPageView({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: 'Карма',
    );
  }

  Widget _buildKarmaLevel(BuildContext context) {
    final KarmaState state = context.read<KarmaState>();

    final User? user = state.user;
    if (user == null) return const SizedBox.shrink();

    return Row(
      children: [
        NIcon(NIcons.karma_up),
        SizedBox(width: 2.w),
        Text(
          user.karmaLevel.toString(),
          style: NTypography.golosRegular14.copyWith(color: NColors.greenPrimary, height: 1.0),
        ),
      ],
    );
  }

  Widget _buildKarmaValues(BuildContext context) {
    final KarmaState state = context.read<KarmaState>();

    final User? user = state.user;
    if (user == null) return const SizedBox.shrink();

    return KarmaWrapper(
      karmaLevel: user.karmaLevel,
      karmaFine: user.karmaFine,
      karmaFineNeed: user.karmaFineNeed,
      karmaPoints: user.karmaPoints,
      karmaPointsNeed: user.karmaPointsNeed,
    );
  }

  Widget _buildKarmaHistoryButton(BuildContext context) {
    return NButton(
      onPressed: () => service<AppRouter>().goToKarmaHistoryPage(),
      title: 'Посмотреть историю кармы',
      height: 32.h,
      width: double.infinity,
      inverted: true,
    );
  }

  Widget _buildGraphs(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: KarmaGraph(title: 'Качество рекомендаций'),
        ),
        SizedBox(width: 40.w),
        Expanded(
          child: KarmaGraph(title: 'Активность в приложений'),
        ),
      ],
    );
  }

  Widget _buildMultiplier(BuildContext context) {
    final KarmaState state = context.read<KarmaState>();

    final User? user = state.user;
    if (user == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'x ${user.karmaMultiplier} ',
                style: NTypography.golosMedium16,
              ),
              TextSpan(
                text: 'Коэффициент',
                style: NTypography.golosRegular14.copyWith(color: NColors.gray),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Карма имеет коэффициент, на который умножаются получаемые баллы (от 0.5 до 1.25) в зависимости от репутации, качества рекомендаций и заполненности профиля',
          style: NTypography.golosRegular14,
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: PaddedContent(
        child: Column(
          children: [
            _buildKarmaLevel(context),
            SizedBox(height: 8.h),
            Text(
              'Карма - это накопительные баллы пользователя. Пользователь получает баллы за удачные рекомендации и полезные для других пользователей действия в системе',
              style: NTypography.golosRegular14,
            ),
            SizedBox(height: 32.h),
            _buildKarmaValues(context),
            SizedBox(height: 16.h),
            Text(
              'За неудачные рекомендации и вредные действия пользователь получает анти-баллы. Баллы повышают общий кармический уровень, а также дают +1 инвайт с каждым уровнем',
              style: NTypography.golosRegular14,
            ),
            SizedBox(height: 16.h),
            _buildKarmaHistoryButton(context),
            SizedBox(height: 32.h),
            _buildGraphs(context),
            SizedBox(height: 32.h),
            _buildMultiplier(context),
            SizedBox(height: 32.h),
          ],
        ),
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
