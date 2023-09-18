// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

part 'profile_state.g.dart';

class ProfileState = _ProfileStateBase with _$ProfileState;

abstract class _ProfileStateBase with Store implements Initializable {
  _ProfileStateBase({
    required this.username,
  });

  /// Username of profile.
  final String username;

  /// Whether this profile stands for current user or not.
  bool get currentUser => username == User.CURRENT_USER_NAME || username == _authState.user?.nickname;

  /// User model of this profile.
  @observable
  User? _user;

  /// If app is loading information about user or not.
  @observable
  bool isLoadingUser = false;

  @computed
  User? get user => currentUser ? _authState.user : _user;

  AuthState get _authState => service<AuthState>();

  /// Users repository.
  UsersRepository get _usersRepository => service<UsersRepository>();

  Future<void> refresh() async => _loadUser();

  Future<void> follow() async {
    if (user == null) return;

    user!.follow();
    final BaseResponse response = await _usersRepository.followUser(user!.id);

    if (response.hasError) {
      user!.unfollow();
    }
  }

  Future<void> unfollow() async {
    if (user == null) return;

    user!.unfollow();
    final BaseResponse response = await _usersRepository.unfollowUser(user!.id);

    if (response.hasError) {
      user!.follow();
    }
  }

  Future<void> block() async {
    if (user == null) return;

    user!.block();
    final BaseResponse response = await _usersRepository.blockUser(user!.id);

    if (response.hasError) {
      user!.unblock();
    }
  }

  Future<void> unblock() async {
    if (user == null) return;

    user!.unblock();
    final BaseResponse response = await _usersRepository.unblockUser(user!.id);

    if (response.hasError) {
      user!.block();
    }
  }

  Future<void> _loadUser() async {
    isLoadingUser = true;

    // Load user information according to whether it is current user or not.
    final BaseResponse<User?> response =
        await (currentUser ? _usersRepository.fetchCurrentUser() : _usersRepository.fetchUser(username: username));

    if (response.successful) {
      _user = response.data!;
    }

    isLoadingUser = false;
  }

  @override
  Future<void> initialize() async {
    await _loadUser();
  }
}
