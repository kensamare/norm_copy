// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/uploaded_image/uploaded_image.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/image_picker/image_picker.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';

part 'user_invitation_form_state.g.dart';

class UserInvitationFormState = _UserInvitationFormStateBase with _$UserInvitationFormState;

abstract class _UserInvitationFormStateBase with Store implements Initializable {
  // Repositories.
  UsersRepository get _usersRepository => service<UsersRepository>();

  // States.
  AuthState get _authState => service<AuthState>();

  NImagePicker imagePicker = NImagePicker();

  @observable
  String? name = '';

  @observable
  String? surname = '';

  @observable
  String? avatar = '';

  @observable
  String? email = '';

  @observable
  String username = '';

  @observable
  String password = '';

  @observable
  bool isLoadingImage = false;

  /// Error message to show.
  @observable
  List<int> errors = [];

  @observable
  List<int> emailErrors = [];

  @observable
  List<int> nicknameErrors = [];

  /// If request is in progress of not.
  @observable
  bool isLoading = false;

  /// Telegram code for current user.
  @observable
  String? tgCode;

  @observable
  bool? isNicknameAvailable;

  @observable
  bool isLoadingNicknameAvailability = false;

  @observable
  bool? isEmailAvailable;

  @observable
  bool isLoadingEmailAvailability = false;

  /// If 'next' button is active or not (whether user can go forward filling up form or not).
  @computed
  bool get canGoForwardFirst => !name.isBlank && !surname.isBlank && !avatar.isBlank;

  /// If 'next' button is active or not (whether user can go forward filling up form or not).
  @computed
  bool get canGoForwardSecond =>
      (!email.isBlank && !username.isBlank && !password.isBlank) &&
      ((isEmailAvailable ?? false) && (isNicknameAvailable ?? false));

  Future<void> getNicknameAvailability() async {
    nicknameErrors.clear();
    isLoadingNicknameAvailability = true;

    final BaseResponse<bool?> response = await _usersRepository.getNicknameAvailability(username);

    isLoadingNicknameAvailability = false;

    if (response.successful) {
      // Set nickname availability status.
      isNicknameAvailable = true;
    } else {
      nicknameErrors = response.errorCodes;
    }
  }

  Future<void> getEmailAvailability() async {
    emailErrors.clear();
    isLoadingEmailAvailability = true;

    final BaseResponse<bool?> response = await _usersRepository.getEmailvailability(email!);

    isLoadingEmailAvailability = false;

    if (response.successful) {
      // Set email availability status.
      isEmailAvailable = true;
    } else {
      emailErrors = response.errorCodes;
    }
  }

  Future<bool> updateRegistrationData() async {
    isLoading = true;

    final BaseResponse<User?> response = await _usersRepository.updateRegistrationData(
      firstName: name,
      lastName: surname,
      avatar: avatar,
      email: email,
      username: username,
      password: password,
    );

    isLoading = false;

    // If response is successful.
    if (response.successful) {
      tgCode = response.data!.telegramCode;
      return true;
    } else {
      errors = response.errorCodes;
      print(response.errorCodes);
    }

    return false;
  }

  Future<void> handleImagePickResult(PickImageResult result) async {
    if (result is PickImageResultNone) {
      return;
    }

    if (result is PickImageResultPicked) {
      isLoadingImage = true;

      final UploadedImage? imageUpload = await imagePicker.uploadImage(result.image);

      isLoadingImage = false;

      if (imageUpload != null) {
        avatar = imageUpload.data;
      }
    }

    if (result is PickImageResultDelete) {
      avatar = '';
    }
  }

  @override
  Future<void> initialize() async {
    name = _authState.user?.firstName;
    surname = _authState.user?.lastName;
    avatar = _authState.user?.avatar;
    email = _authState.user?.email;
  }

  void setName(String value) => name = value;

  void setSurname(String value) => surname = value;

  void setEmail(String value) => email = value;

  void setUsername(String value) {
    username = value;

    // Check if this username is available or not.
    getNicknameAvailability();
  }

  void setPassword(String value) => password = value;
}
