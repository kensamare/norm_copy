// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/specs_repository.dart';
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/domain/models/uploaded_image/uploaded_image.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/image_picker/image_picker.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';

part 'edit_speciality_state.g.dart';

class EditSpecialityState = _EditSpecialityStateBase with _$EditSpecialityState;

abstract class _EditSpecialityStateBase with Store implements Initializable {
  _EditSpecialityStateBase({required this.speciality});

  final NImagePicker imagePicker = NImagePicker();

  /// The speciality we are changing.
  @observable
  Speciality speciality;

  /// Repository.
  SpecsRepository get _specsRepository => service<SpecsRepository>();

  @observable
  Speciality? spec;

  @observable
  bool isLoadingImage = false;

  @observable
  bool isDeleting = false;

  @observable
  String? specialityTitle;

  @observable
  SpecialityLevel? level;

  @observable
  DateTime? from;

  @observable
  Career? career;

  @observable
  String? description;

  @observable
  bool isSaving = false;

  @observable
  ObservableList<Speciality> suggestedSpecs = ObservableList();

  @computed
  bool get canSave {
    if (spec == null && specialityTitle.isBlank) return false;

    return level != null;
  }

  Future<bool> delete() async {
    isDeleting = true;

    final BaseResponse response = await _specsRepository.deleteSpec(id: speciality.id);

    isDeleting = false;

    if (response.successful) {
      return true;
    }

    return false;
  }

  Future<Speciality?> save() async {
    if (!canSave) return null;
    isSaving = true;

    final BaseResponse<Speciality?> response = await _specsRepository.updateData(
      speciality.id,
      specialityId: spec?.id,
      specialityTitle: specialityTitle,
      brandId: career?.brand?.id,
      description: description,
      role: career?.position,
      from: from,
      level: level,
    );

    isSaving = false;

    return response.data;
  }

  Future<void> handleImagePickResult(PickImageResult result) async {
    if (result is PickImageResultNone) {
      return;
    }

    if (result is PickImageResultPicked) {
      isLoadingImage = true;

      final UploadedImage? imageUpload = await imagePicker.uploadImage(result.image);

      if (imageUpload != null) {
        final BaseResponse<Speciality?> response = await _specsRepository.updateData(
          speciality.id,
          avatar: imageUpload.data,
        );

        if (response.successful) {
          updateSpeciality(response.data!);
        }
      }

      isLoadingImage = false;
    }
  }

  Future<void> addContact(Contact contact) async {
    speciality.addContact(contact);

    final BaseResponse<Speciality?> response =
        await _specsRepository.updateData(speciality.id, contacts: speciality.contacts);

    if (response.successful) {
      speciality = response.data!;
    }
  }

  Future<void> deleteContact(Contact contact) async {
    speciality.deleteContact(contact);

    final BaseResponse<Speciality?> response =
        await _specsRepository.updateData(speciality.id, contacts: speciality.contacts);

    if (response.successful) {
      speciality = response.data!;
    }
  }

  Future<void> loadSpecialities(String search) async {
    final BaseResponse<List<Speciality>> response = await _specsRepository.fetchSpecialities(search: search);

    if (response.successful) {
      suggestedSpecs = ObservableList.of(response.data!);
    }
  }

  @override
  Future<void> initialize() async {
    spec = speciality.spec;
    level = speciality.level;
    career = Career(
      brand: speciality.brand,
      position: speciality.role ?? '',
    );
    description = speciality.description;
    from = speciality.from;
  }

  void setSpeciality(Speciality? value) => spec = value;
  void setSpecialityTitle(String? value) => specialityTitle = value;
  void setDescription(String? value) => description = value;

  void setLevel(SpecialityLevel? value) => level = value;
  void setCareer(Career? value) => career = value;

  void setFrom(DateTime? value) => from = value;

  void updateSpeciality(Speciality value) => speciality = value;
}
