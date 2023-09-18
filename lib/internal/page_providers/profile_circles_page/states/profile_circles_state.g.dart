// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_circles_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileCirclesState on _ProfileCirclesStateBase, Store {
  late final _$usersAtom =
      Atom(name: '_ProfileCirclesStateBase.users', context: context);

  @override
  ObservableList<User> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<User> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$invitedUsersAtom =
      Atom(name: '_ProfileCirclesStateBase.invitedUsers', context: context);

  @override
  ObservableList<User> get invitedUsers {
    _$invitedUsersAtom.reportRead();
    return super.invitedUsers;
  }

  @override
  set invitedUsers(ObservableList<User> value) {
    _$invitedUsersAtom.reportWrite(value, super.invitedUsers, () {
      super.invitedUsers = value;
    });
  }

  late final _$invitesAtom =
      Atom(name: '_ProfileCirclesStateBase.invites', context: context);

  @override
  ObservableList<Invite> get invites {
    _$invitesAtom.reportRead();
    return super.invites;
  }

  @override
  set invites(ObservableList<Invite> value) {
    _$invitesAtom.reportWrite(value, super.invites, () {
      super.invites = value;
    });
  }

  late final _$isLoadingInvitesCountAtom = Atom(
      name: '_ProfileCirclesStateBase.isLoadingInvitesCount', context: context);

  @override
  bool get isLoadingInvitesCount {
    _$isLoadingInvitesCountAtom.reportRead();
    return super.isLoadingInvitesCount;
  }

  @override
  set isLoadingInvitesCount(bool value) {
    _$isLoadingInvitesCountAtom.reportWrite(value, super.isLoadingInvitesCount,
        () {
      super.isLoadingInvitesCount = value;
    });
  }

  late final _$isLoadingInvitesAtom =
      Atom(name: '_ProfileCirclesStateBase.isLoadingInvites', context: context);

  @override
  bool get isLoadingInvites {
    _$isLoadingInvitesAtom.reportRead();
    return super.isLoadingInvites;
  }

  @override
  set isLoadingInvites(bool value) {
    _$isLoadingInvitesAtom.reportWrite(value, super.isLoadingInvites, () {
      super.isLoadingInvites = value;
    });
  }

  late final _$isLoadingInvitedUsersAtom = Atom(
      name: '_ProfileCirclesStateBase.isLoadingInvitedUsers', context: context);

  @override
  bool get isLoadingInvitedUsers {
    _$isLoadingInvitedUsersAtom.reportRead();
    return super.isLoadingInvitedUsers;
  }

  @override
  set isLoadingInvitedUsers(bool value) {
    _$isLoadingInvitedUsersAtom.reportWrite(value, super.isLoadingInvitedUsers,
        () {
      super.isLoadingInvitedUsers = value;
    });
  }

  late final _$isLoadingUsersAtom =
      Atom(name: '_ProfileCirclesStateBase.isLoadingUsers', context: context);

  @override
  bool get isLoadingUsers {
    _$isLoadingUsersAtom.reportRead();
    return super.isLoadingUsers;
  }

  @override
  set isLoadingUsers(bool value) {
    _$isLoadingUsersAtom.reportWrite(value, super.isLoadingUsers, () {
      super.isLoadingUsers = value;
    });
  }

  @override
  String toString() {
    return '''
users: ${users},
invitedUsers: ${invitedUsers},
invites: ${invites},
isLoadingInvitesCount: ${isLoadingInvitesCount},
isLoadingInvites: ${isLoadingInvites},
isLoadingInvitedUsers: ${isLoadingInvitedUsers},
isLoadingUsers: ${isLoadingUsers}
    ''';
  }
}
