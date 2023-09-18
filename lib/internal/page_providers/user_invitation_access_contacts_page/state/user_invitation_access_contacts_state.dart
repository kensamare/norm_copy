// Package imports:
import 'package:contacts_service/contacts_service.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/internal/services/n_logger/n_logger.dart';
import 'package:norm/internal/services/service_locator.dart';

part 'user_invitation_access_contacts_state.g.dart';

class UserInvitationAccessContactsState = _UserInvitationAccessContactsStateBase
    with _$UserInvitationAccessContactsState;

abstract class _UserInvitationAccessContactsStateBase with Store {
  UsersRepository get _usersRepository => service<UsersRepository>();

  @observable
  bool isLoading = false;

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<bool> provideContacts() async {
    if (await _getContactPermission().isGranted) {
      isLoading = true;

      try {
        final List<Contact> contacts = await ContactsService.getContacts(photoHighResolution: false);

        /// Send contacts to backend.
        await _usersRepository.provideContacts(contacts);
      } catch (e, s) {
        NLogger.handleException(e, s);
      }

      isLoading = false;

      return true;
    }

    return false;
  }
}
