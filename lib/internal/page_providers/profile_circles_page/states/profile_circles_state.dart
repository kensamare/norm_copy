// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/circles_repository.dart';
import 'package:norm/data/api/repositories/invites_repository.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/circle/circle.dart';
import 'package:norm/domain/models/invite/invite.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

part 'profile_circles_state.g.dart';

class ProfileCirclesState = _ProfileCirclesStateBase with _$ProfileCirclesState;

abstract class _ProfileCirclesStateBase with Store implements Initializable {
  _ProfileCirclesStateBase({
    required this.userId,
    this.currentUser = false,
  });

  final int userId;

  final bool currentUser;

  /// Circle.
  Circle? circle;

  CirclesRepository get _circlesRepository => service<CirclesRepository>();
  InvitesRepository get _invitesRepository => service<InvitesRepository>();

  @observable
  ObservableList<User> users = ObservableList();

  @observable
  ObservableList<User> invitedUsers = ObservableList();

  @observable
  ObservableList<Invite> invites = ObservableList();

  @observable
  bool isLoadingInvitesCount = false;

  @observable
  bool isLoadingInvites = false;

  @observable
  bool isLoadingInvitedUsers = false;

  @observable
  bool isLoadingUsers = false;

  void _addUsers(List<User> _users) {
    for (User user in _users) {
      if (!users.any((e) => e.id == user.id)) {
        users.add(user);
      }
    }
  }

  Future<void> generateCode() async {
    isLoadingInvitesCount = true;

    final BaseResponse<Invite?> response = await _invitesRepository.generateInviteCode();

    isLoadingInvitesCount = false;

    if (response.successful) {
      invites.add(response.data!);
      service<AuthState>().user?.decreaseInvites();
    }
  }

  Future<void> revokeInvite(Invite invite) async {
    invites.remove(invite);

    final BaseResponse response = await _invitesRepository.revokeInvite(id: invite.id);

    if (response.hasError) {
      invites.add(invite);
    } else {
      service<AuthState>().user?.increaseInvites();
      invites = ObservableList.of(invites);
    }
  }

  Future<void> loadInvites() async {
    isLoadingInvites = true;

    final BaseResponse<List<Invite>> response = await _invitesRepository.fetchInvites();

    if (response.successful) {
      invites.addAll(response.data!);
    }

    isLoadingInvites = false;
  }

  Future<void> loadInvitedUsers() async {
    isLoadingInvitedUsers = true;

    final BaseResponse<List<User>> response = await _invitesRepository.fetchInvitedUsers();

    if (response.successful) {
      invitedUsers.addAll(response.data!);
    }

    isLoadingInvitedUsers = false;
  }

  Future<void> updateUserInformation() async {
    isLoadingInvitesCount = true;
    await service<UsersRepository>().fetchCurrentUser();

    isLoadingInvitesCount = false;
  }

  Future<void> loadUsers() async {
    isLoadingUsers = true;

    final BaseResponse<List<User>> response =
        await _circlesRepository.fetchCircleUsers(circleId: circle!.id, userId: userId);

    isLoadingUsers = false;

    if (response.successful) {
      _addUsers(response.data!);
    }
  }

  @override
  Future<void> initialize() async {
    clearData();

    // Load circle users only if it isn't invites circle.
    if (circle?.id != Circle.INVITES_ID) {
      await loadUsers();
    } else {
      await Future.wait([
        updateUserInformation(),
        loadInvites(),
        loadInvitedUsers(),
      ]);
    }
  }

  void setCircle(Circle circle) => this.circle = circle;

  void clearData() {
    invites.clear();
    users.clear();
    invitedUsers.clear();
  }
}
