// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_dropdown/n_dropdown.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';

class AddContactPopup extends StatefulWidget {
  const AddContactPopup({
    super.key,
    this.contact,
  });

  final Contact? contact;

  @override
  State<AddContactPopup> createState() => _AddContactPopupState();
}

class _AddContactPopupState extends State<AddContactPopup> {
  /// Contact ID when editing.
  int? id;

  /// Chosen contact type.
  ContactType? type;

  /// Contact value.
  String? value;

  /// Contact title.
  String? title;

  bool get canAdd => type != null && !value.isBlank && !title.isBlank;

  @override
  void initState() {
    if (widget.contact != null) {
      final Contact contact = widget.contact!;

      type = contact.type;
      value = contact.contact;
      title = contact.title;
      id = contact.id;
    }

    super.initState();
  }

  void addContact() {
    if (!canAdd) return;

    final Contact contact = Contact(
      id: id,
      title: title!,
      type: type!,
      contact: value!,
    );
    Navigator.of(context).pop(contact);
  }

  Widget _buildSaveButton(BuildContext context) {
    return NButton(
      onPressed: addContact,
      title: 'Добавить',
      width: double.infinity,
    );
  }

  Widget _buildContactType(BuildContext context) {
    return NDropdown(
      width: double.infinity,
      value: type,
      items: ContactType.values
          .map(
            (e) => NDropdownItem(title: contactType(context, e), value: e),
          )
          .toList(),
      hint: 'Выберите тип контакта',
      onChanged: (value) => setState(() => type = value),
    );
  }

  Widget _buildTitleField(BuildContext context) {
    return NTextField(
      initialValue: title,
      width: double.infinity,
      hintText: 'Название контакта',
      onChanged: (value) => setState(() => title = value),
    );
  }

  Widget _buildValueField(BuildContext context) {
    return NTextField(
      initialValue: value,
      width: double.infinity,
      hintText: 'Укажите контакт',
      onChanged: (value) => setState(() => this.value = value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        child: Column(
          children: [
            _buildContactType(context),
            SizedBox(height: 20.h),
            _buildValueField(context),
            SizedBox(height: 20.h),
            _buildTitleField(context),
            SizedBox(height: 40.h),
            _buildSaveButton(context),
            Consumer<ScreenHeight>(
              builder: (context, value, _) => SizedBox(height: value.isOpen ? (value.keyboardHeight + 24.h) : 40.h),
            ),
          ],
        ),
      ),
    );
  }
}
