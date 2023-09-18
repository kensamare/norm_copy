// Dart imports:
import 'dart:async';

// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/auth_repository.dart';
import 'package:norm/data/api/repositories/specs_repository.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/session/session.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/domain/models/uploaded_image/uploaded_image.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/image_picker/image_picker.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';

part 'registration_request_state.g.dart';

class RegistrationRequestState = _RegistrationRequestStateBase with _$RegistrationRequestState;

abstract class _RegistrationRequestStateBase with Store implements Initializable {
  AuthRepository get _authRepository => service<AuthRepository>();
  SpecsRepository get _specsRepository => service<SpecsRepository>();
  UsersRepository get _usersRepository => service<UsersRepository>();
  AuthState get _authState => service<AuthState>();

  NImagePicker imagePicker = NImagePicker();

  @observable
  String name = '';

  @observable
  String surname = '';

  @observable
  String avatar = '';

  @observable
  String email = '';

  @observable
  String? search;

  @observable
  bool agreedToTerms = false;

  @observable
  bool isLoadingImage = false;

  /// Specs Error message to show.
  @observable
  List<int> specsErrors = [];

  /// User form Error message to show.
  @observable
  List<int> formErrors = [];

  /// If request is in progress of not.
  @observable
  bool isLoading = false;

  @observable
  ObservableList<Speciality> specialities = ObservableList.of([]);

  @observable
  ObservableList<Speciality> pickedSpecialities = ObservableList.of([]);

  @computed
  ObservableList<Speciality> get notPickedSpecialities =>
      ObservableList.of(specialities.where((e) => !pickedSpecialities.any((pE) => e.id == pE.id)).toList());

  /// If 'next' button is active or not (whether user can go forward filling up form or not).
  @computed
  bool get canGoForwardToEmail => !name.isBlank && !surname.isBlank && !avatar.isBlank && agreedToTerms;

  void _addSpecialities(List<Speciality?> specs) {
    for (Speciality? spec in specs) {
      if (spec != null) {
        specialities.add(spec);
      }
    }
  }

  /// Load new specialities.
  Future<void> searchSpecialities(String value) async {
    // Set new search value.
    search = value;

    // Load specialities.
    return await loadSpecialities();
  }

  Future<bool> updateSpecs() async {
    isLoading = true;

    final BaseResponse response = await _usersRepository.updateSpecs(pickedSpecialities.map((e) => e.id).toList());

    isLoading = false;

    // If response is successful.
    if (response.successful) {
      return true;
    } else {
      specsErrors = response.errorCodes;
      print(response.errorCodes);
    }

    return false;
  }

  Future<void> loadSpecialities() async {
    final String? startRequestSearch = search;
    final BaseResponse<List<Speciality>> response = await _specsRepository.fetchSpecialities(search: search);

    // If search at the beginning of request was different from current then this request is not relevant any more.
    if (search != startRequestSearch) return;

    if (response.successful) {
      // Clear specialities before adding new.
      specialities.clear();

      _addSpecialities(response.data!);
    }
  }

  Future<bool> requestSession() async {
    isLoading = true;

    final BaseResponse<Session?> response =
        await _authRepository.sendRequest(firstName: name, lastName: surname, avatar: avatar, email: email);

    isLoading = false;

    // If response is successful.
    if (response.successful) {
      // Save session.
      unawaited(_authState.activateSession(response.data!));

      return true;
    } else {
      formErrors = response.errorCodes;
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
    await loadSpecialities();
  }

  void pickSpeciality(Speciality spec) => pickedSpecialities.add(spec);

  void removeSpeciality(Speciality spec) => pickedSpecialities.remove(spec);

  void setAgreedToTerms(bool value) => agreedToTerms = value;

  void setName(String value) => name = value;

  void setSurname(String value) => surname = value;

  void setEmail(String value) => email = value;
}
