// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/profile_circles_page/states/profile_circles_state.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/search_field/search_field.dart';
import 'package:norm/presentation/global/user_wrapper/user_wrapper.dart';

class ProfileCirclesUsersPageView extends StatelessWidget {
  const ProfileCirclesUsersPageView({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: context.read<ProfileCirclesState>().circle?.title,
    );
  }

  Widget _buildUsers(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileCirclesState state = context.watch<ProfileCirclesState>();

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (state.isLoadingUsers && index == state.users.length) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            return UserWrapper(
              user: state.users.elementAt(index),
            );
          },
          itemCount: state.users.length + (state.isLoadingUsers ? 1 : 0),
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return PaddedContent(
      child: SearchField(
        onChanged: (_) {},
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.h),
          _buildSearchBar(context),
          SizedBox(height: 16.h),
          _buildUsers(context),
        ],
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
