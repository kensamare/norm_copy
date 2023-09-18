// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

part 'edit_main_information_state.g.dart';

class EditMainInformationState = _EditMainInformationStateBase with _$EditMainInformationState;

abstract class _EditMainInformationStateBase with Store implements Initializable {
  // Repositories.
  UsersRepository get _usersRepository => service<UsersRepository>();

  // States.
  AuthState get _authState => service<AuthState>();

  @observable
  String? name;

  @observable
  String? surname;

  @observable
  String email = '';

  @observable
  String nickname = '';

  @observable
  String? description;

  @observable
  bool? isNicknameAvailable = true;

  @observable
  bool isLoadingNicknameAvailability = false;

  @observable
  bool? isEmailAvailable = true;

  @observable
  bool isLoadingEmailAvailability = false;

  @observable
  List<int> emailErrors = [];

  @observable
  List<int> nicknameErrors = [];

  @observable
  bool isSaving = false;

  @computed
  bool get canSave => (name ?? '').isNotEmpty && (surname ?? '').isNotEmpty && nickname.isNotEmpty && email.isNotEmpty;

  Future<void> getNicknameAvailability() async {
    nicknameErrors.clear();
    isLoadingNicknameAvailability = true;

    final BaseResponse<bool?> response = await _usersRepository.getNicknameAvailability(nickname);

    isLoadingNicknameAvailability = false;

    if (response.successful) {
      // Set nickname availability status.
      isNicknameAvailable = true;
    } else {
      nicknameErrors = response.errorCodes;
    }
  }

  Future<void> save() async {
    if (!canSave) return;
    isSaving = true;

    final BaseResponse<User?> response = await _usersRepository.updateRegistrationData(
      firstName: name,
      lastName: surname,
      username: nickname,
      email: email,
      about: description,
    );

    isSaving = false;

    if (response.successful) {
      final User user = response.data!;
      _authState.updateUser(user);
    }
  }

  Future<void> getEmailAvailability() async {
    emailErrors.clear();
    isLoadingEmailAvailability = true;

    final BaseResponse<bool?> response = await _usersRepository.getEmailvailability(email);

    isLoadingEmailAvailability = false;

    if (response.successful) {
      // Set email availability status.
      isEmailAvailable = true;
    } else {
      emailErrors = response.errorCodes;
    }
  }

  @override
  Future<void> initialize() async {
    name = _authState.user?.firstName;
    surname = _authState.user?.lastName;
    nickname = _authState.user?.nickname ?? '';
    email = _authState.user?.email ?? '';
    description = _authState.user?.about;
  }

  void setName(String value) => name = value;

  void setSurname(String value) => surname = value;

  void setEmail(String value) => email = value;

  void setDescription(String value) => description = value;

  void setNickname(String value) {
    nickname = value;

    // Check if this username is available or not.
    getNicknameAvailability();
  }
}
