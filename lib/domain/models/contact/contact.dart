// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

enum ContactType { phone, url, email, whatsapp, telegram }

@JsonSerializable(explicitToJson: true)
class Contact extends Equatable {
  const Contact({
    this.id,
    this.type = ContactType.phone,
    this.contact = '',
    this.title = '',
    this.icon = '',
  });

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  final int? id;

  @JsonKey(name: 'contact_type', fromJson: _contactTypeFromJson, toJson: _contactTypeToJson)
  final ContactType type;

  ///
  final String contact;

  /// Contact title.
  final String title;

  /// Contact icon.
  final String icon;

  static ContactType _contactTypeFromJson(String json) {
    switch (json) {
      case 'contact_phone':
        return ContactType.phone;
      case 'url':
        return ContactType.url;
      case 'email':
        return ContactType.email;
      case 'wa':
        return ContactType.whatsapp;
      case 'tg':
        return ContactType.telegram;
    }

    return ContactType.phone;
  }

  static String _contactTypeToJson(ContactType type) {
    switch (type) {
      case ContactType.email:
        return 'email';
      case ContactType.url:
        return 'url';
      case ContactType.telegram:
        return 'tg';
      case ContactType.whatsapp:
        return 'wa';
      case ContactType.phone:
      default:
        return 'contact_phone';
    }
  }

  @override
  List<Object?> get props => [id];
}
