// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/circle/circle.dart';
import 'package:norm/internal/page_providers/profile_circles_page/states/profile_circles_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class ProfileCirclesPageView extends StatelessWidget {
  const ProfileCirclesPageView({super.key});

  List<Circle> _circles(BuildContext context) {
    final ProfileCirclesState state = context.read<ProfileCirclesState>();

    return [
      if (state.currentUser)
        const Circle(
          id: Circle.INVITES_ID,
          title: 'Мои инвайты',
          subtitle: 'Круг людей, за которых ты поручился',
        ),
      const Circle(
        id: 'circle_1',
        title: '1 круг',
        subtitle: 'Люди, за которых поручился',
      ),
      const Circle(
        id: 'circle_2',
        title: '2 круг',
        subtitle: 'Люди, за которых поручился\n1 круг и твои рекомендации',
      ),
      const Circle(
        id: 'circle_3',
        title: '3 круг',
        subtitle: 'Рекомендации 2 круга\nи ваши общие знакомые',
      ),
      const Circle(
        id: 'circle_ai',
        title: 'AI круг',
        subtitle: 'Пользовaтeли, которые схожи с вами',
      ),
      const Circle(
        id: 'follow',
        title: 'Подписки',
        subtitle: 'Люди, на которых я подписана',
      ),
      const Circle(
        id: 'followers',
        title: 'Подписчики',
        subtitle: 'Люди, которые подписаны на меня',
      ),
      if (state.currentUser)
        const Circle(
          id: 'phonebook',
          title: 'Адресная книга',
          subtitle: 'Мои сохраненные контакты\nиз списка контактов',
        ),
    ];
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.circles,
    );
  }

  Widget _buildCircle(BuildContext context, {required Circle circle}) {
    return InkWell(
      onTap: () => service<AppRouter>().goToProfileCirclesUsersPage(circle),
      child: Ink(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: NConstants.sidePadding.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    circle.title,
                    style: NTypography.golosRegular16,
                  ),
                  NIcon(
                    NIcons.arrow_right_2,
                    size: 18.r,
                    color: NColors.graySecondaryText,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                circle.subtitle,
                style: NTypography.golosRegular16.copyWith(color: NColors.gray),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final List<Circle> circles = _circles(context);

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return _buildCircle(
          context,
          circle: circles.elementAt(index),
        );
      },
      separatorBuilder: (_, __) => Container(
        height: 0.5.r,
        width: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
        color: NColors.gray2,
      ),
      itemCount: circles.length,
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
