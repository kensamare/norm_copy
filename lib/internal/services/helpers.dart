// Dart imports:
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/domain/models/language/language.dart';
import 'package:norm/presentation/pages/grade_person_page/grade_person_page_view.dart';
import 'package:norm/domain/models/speciality/speciality.dart';

String datePattern = 'yyyy-MM-dd';

String errorMessagesLocalized(BuildContext context, List<int> errors) {
  return errors
      .map(
        (e) => errorMessage(context, e),
      )
      .toList()
      .join(' ');
}

/// Launches url in external application.
Future<void> launchUrl(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}

String errorMessage(BuildContext context, int error) {
  switch (error) {
    case 1:
      return L10n.of(context)!.error1;
    case 2:
      return L10n.of(context)!.error2;
    case 3:
      return L10n.of(context)!.error3;
    case 4:
      return L10n.of(context)!.error4;
    case 5:
      return L10n.of(context)!.error5;
    case 100:
      return L10n.of(context)!.error100;
    case 101:
      return L10n.of(context)!.error101;
    case 102:
      return L10n.of(context)!.error102;
    case 103:
      return L10n.of(context)!.error103;
    case 104:
      return L10n.of(context)!.error104;
    case 105:
      return L10n.of(context)!.error105;
    case 106:
      return L10n.of(context)!.error106;
    case 107:
      return L10n.of(context)!.error107;
    case 108:
      return L10n.of(context)!.error108;
    case 902:
      return L10n.of(context)!.error902;
    case 999:
      return L10n.of(context)!.error999;
    case 1004:
      return L10n.of(context)!.error1004;
    case 1005:
      return L10n.of(context)!.error1005;
    default:
      return L10n.of(context)!.defaultError;
  }
}

String languageLevel(BuildContext context, LanguageLevel level) {
  switch (level) {
    case LanguageLevel.A1:
      return L10n.of(context)!.a1;
    case LanguageLevel.A2:
      return L10n.of(context)!.a2;
    case LanguageLevel.B1:
      return L10n.of(context)!.b1;
    case LanguageLevel.B2:
      return L10n.of(context)!.b2;
    case LanguageLevel.C1:
      return L10n.of(context)!.c1;
    case LanguageLevel.C2:
      return L10n.of(context)!.c2;
  }
}

String specialityLevel(BuildContext context, SpecialityLevel level) {
  switch (level) {
    case SpecialityLevel.beginner:
      return L10n.of(context)!.beginner;
    case SpecialityLevel.middle:
      return L10n.of(context)!.middle;
    case SpecialityLevel.master:
      return L10n.of(context)!.master;
  }
}

String contactType(BuildContext context, ContactType type) {
  switch (type) {
    case ContactType.email:
      return L10n.of(context)!.email;
    case ContactType.url:
      return L10n.of(context)!.url;
    case ContactType.whatsapp:
      return L10n.of(context)!.whatsApp;
    case ContactType.telegram:
      return L10n.of(context)!.telegram;
    case ContactType.phone:
    default:
      return L10n.of(context)!.phoneNumber;
  }
}

String knowTimeTitle(BuildContext context, KnowTime type) {
  switch (type) {
    case KnowTime.lastYear:
      return L10n.of(context)!.lastYear;
    case KnowTime.lessThan3Years:
      return L10n.of(context)!.lessThan3Years;
    case KnowTime.moreThan3Years:
      return L10n.of(context)!.moreThan3Years;
  }
}

String closenessTypeTitle(BuildContext context, ClosenessType type) {
  switch (type) {
    case ClosenessType.littleKnow:
      return L10n.of(context)!.littleKnow;
    case ClosenessType.wellKnow:
      return L10n.of(context)!.wellKnow;
    case ClosenessType.veryClose:
      return L10n.of(context)!.veryClose;
  }
}

/// Конвертер int в bool.
bool intToBool(int result) => result == 1;

/// Конвертер bool в int.
int boolToInt(bool result) => result ? 1 : 0;

void copyToClipboard(String text) {
  Clipboard.setData(
    ClipboardData(text: text),
  );

  Fluttertoast.showToast(msg: 'Copied to clipboard');
}

String? anyStringToNull(String? str) => null;

void setControllerValue(TextEditingController controller, String value) {
  controller.value = TextEditingValue(
    text: value,
    selection: TextSelection.collapsed(offset: value.length),
  );
}

/// Checks whether string is emptry or null or not.
///
/// Returns true if string is emptry or null.
extension IsBlankExtension on String? {
  bool get isBlank {
    return (this ?? '').isEmpty;
  }
}

DateTime? dateFromSeconds(dynamic value) {
  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value * 1000);
  }

  return null;
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}
