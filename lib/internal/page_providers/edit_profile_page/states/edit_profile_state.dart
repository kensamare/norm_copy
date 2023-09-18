// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/uploaded_image/uploaded_image.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/image_picker/image_picker.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';

part 'edit_profile_state.g.dart';

class EditProfileState = _EditProfileStateBase with _$EditProfileState;

abstract class _EditProfileStateBase with Store {
  NImagePicker imagePicker = NImagePicker();

  /// Repository.
  UsersRepository get _usersRepository => service<UsersRepository>();

  @observable
  bool isLoadingImage = false;

  @computed
  User? get user => service<AuthState>().user;

  Future<void> handleImagePickResult(PickImageResult result) async {
    if (result is PickImageResultNone) {
      return;
    }

    if (result is PickImageResultPicked) {
      isLoadingImage = true;

      final UploadedImage? imageUpload = await imagePicker.uploadImage(result.image);

      if (imageUpload != null) {
        final BaseResponse<User?> response = await _usersRepository.updateRegistrationData(avatar: imageUpload.data);

        if (response.successful) {
          service<AuthState>().updateUser(response.data!);
        }
      }

      isLoadingImage = false;
    }
  }
}
