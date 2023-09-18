// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class ContactsPopup extends StatelessWidget {
  const ContactsPopup({
    super.key,
    required this.contacts,
  });

  final List<Contact> contacts;

  Widget _buildContacts(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _buildContact(
        context,
        contact: contacts.elementAt(index),
      ),
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemCount: contacts.length,
    );
  }

  Widget _buildContact(BuildContext context, {required Contact contact}) {
    return NButton(
      onPressed: () => launchUrl(contact.contact),
      title: contact.title,
      icon: NIcon(
        NIcons.contactPath(contact.type.name),
      ),
      inverted: true,
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Связаться', style: NTypography.rfDewiBold24),
          SizedBox(height: 40.h),
          _buildContacts(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _buildContent(context),
    );
  }
}
