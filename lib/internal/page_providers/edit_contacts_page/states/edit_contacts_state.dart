// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';

part 'edit_contacts_state.g.dart';

class EditContactsState = _EditContactsStateBase with _$EditContactsState;

abstract class _EditContactsStateBase with Store {
  UsersRepository get _usersRepository => service<UsersRepository>();

  @computed
  User? get user => service<AuthState>().user;

  Future<void> addContact(Contact contact) async {
    user?.addContact(contact);

    final BaseResponse<User?> response = await _usersRepository.updateData(contacts: user?.contacts);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }

  Future<void> deleteContact(Contact contact) async {
    user?.deleteContact(contact);

    final BaseResponse<User?> response = await _usersRepository.updateData(contacts: user?.contacts);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }
}
