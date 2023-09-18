// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/internal/page_providers/edit_contacts_page/states/edit_contacts_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/confirm_action_popup/confirm_action_popup.dart';
import 'package:norm/presentation/global/confirm_action_popup/widgets/confirm_action.dart';
import 'package:norm/presentation/global/contact_wrapper/contact_wrapper.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/pages/edit_contacts_page/widgets/add_contact_popup.dart';

class EditContactsPageView extends StatelessWidget {
  const EditContactsPageView({super.key});

  void openContactPopup(BuildContext context, [Contact? editContact]) async {
    final EditContactsState state = context.read<EditContactsState>();
    final Contact? contact = await service<AppRouter>().showBottomSheet(
      context,
      AddContactPopup(contact: editContact),
    );

    if (contact != null) {
      state.addContact(contact);
    }
  }

  void openDeletePopup(BuildContext context, Contact contact) {
    final EditContactsState state = context.read<EditContactsState>();

    service<AppRouter>().showBottomSheet(
      context,
      ConfirmActionPopup(
        title: 'Вы уверены, что хотите удалить контакт?',
        confirmWidget: ConfirmAction(
          title: 'Удалить',
          onTap: () {
            state.deleteContact(contact);
            AutoRouter.of(context).pop();
          },
        ),
        cancelWidget: ConfirmAction(title: 'Отмена', inverted: true),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => openContactPopup(context),
      child: NIcon(NIcons.add),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.contacts,
      actions: [
        _buildAddButton(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
            child: Text(
              'Мотивирующий текст Simply dummy text of the printing and typesetting industry. Lorem Ipsum',
              style: NTypography.golosRegular16.copyWith(color: NColors.gray),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          _buildContacts(context),
        ],
      ),
    );
  }

  Widget _buildEmptyContacts(BuildContext context) {
    return GestureDetector(
      onTap: () => openContactPopup(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 48.r,
            width: 48.r,
            decoration: const BoxDecoration(color: NColors.gray2, shape: BoxShape.circle),
            child: Center(
              child: NIcon(NIcons.add, size: 20.r),
            ),
          ),
          SizedBox(height: 16.h),
          Text(L10n.of(context)!.add, style: NTypography.golosRegular14),
        ],
      ),
    );
  }

  Widget _buildContacts(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditContactsState state = context.watch<EditContactsState>();

        // return const SizedBox.shrink();
        if (state.user == null) return const SizedBox.shrink();

        if (state.user!.contacts.isEmpty) {
          return _buildEmptyContacts(context);
        }

        // return const SizedBox.shrink();

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Contact contact = state.user!.contacts.elementAt(index);

            return ContactWrapper(
              onEdit: () => openContactPopup(context, contact),
              onDelete: () => openDeletePopup(context, contact),
              contact: contact,
            );
          },
          itemCount: state.user!.contacts.length,
          separatorBuilder: (_, __) => Padding(
            padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
            child: Container(height: 1.r, color: NColors.gray3),
          ),
        );
      },
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
