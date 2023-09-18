// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/brands_repository.dart';
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/brand_category/brand_category.dart';
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/domain/models/uploaded_image/uploaded_image.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/image_picker/image_picker.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';

part 'edit_brand_state.g.dart';

class EditBrandState = _EditBrandStateBase with _$EditBrandState;

abstract class _EditBrandStateBase with Store implements Initializable {
  _EditBrandStateBase({required this.brand});

  final NImagePicker imagePicker = NImagePicker();

  /// The brand we are changing.
  @observable
  Brand brand;

  /// Repository.
  BrandRepository get _brandsRepository => service<BrandRepository>();

  @observable
  List<int> nicknameErrors = [];

  @observable
  bool isLoadingNicknameAvailability = false;

  @observable
  bool? isNicknameAvailable;

  @observable
  bool isLoadingImage = false;

  @observable
  String nickname = '';

  @observable
  String? description;

  @observable
  String? title;

  /// Brand category.
  @observable
  BrandCategory? category;

  /// Brand category title.
  @observable
  String? categoryTitle;

  @observable
  String? url;

  @observable
  ObservableList<BrandCategory> suggestedBrandCategories = ObservableList();

  @observable
  bool isSaving = false;

  @observable
  bool isDeleting = false;

  @computed
  bool get canSave => !title.isBlank && nickname.isNotEmpty && (category != null || !categoryTitle.isBlank);

  Future<Brand?> save() async {
    if (!canSave) return null;
    isSaving = true;

    final BaseResponse<Brand?> response = await _brandsRepository.updateData(
      brand.id,
      nickname: nickname,
      url: url,
      title: title,
      about: description,
    );

    isSaving = false;

    if (response.successful) {
      return response.data;
    }

    return null;
  }

  Future<bool> delete() async {
    isDeleting = true;

    final BaseResponse response = await _brandsRepository.deleteBrand(id: brand.id);

    isDeleting = false;

    if (response.successful) {
      return true;
    }

    return false;
  }

  Future<void> getNicknameAvailability() async {
    nicknameErrors.clear();
    isLoadingNicknameAvailability = true;

    final BaseResponse<bool?> response = await _brandsRepository.getNicknameAvailability(nickname);

    isLoadingNicknameAvailability = false;

    if (response.successful) {
      // Set nickname availability status.
      isNicknameAvailable = true;
    } else {
      nicknameErrors = response.errorCodes;
    }
  }

  Future<void> searchBrandCategories() async {
    if (categoryTitle.isBlank) {
      suggestedBrandCategories = ObservableList.of([]);
      return;
    }

    final BaseResponse<List<BrandCategory>?> response =
        await _brandsRepository.fetchBrandCategories(search: categoryTitle);

    if (response.successful) {
      suggestedBrandCategories = ObservableList.of(response.data ?? []);
    }
  }

  Future<void> handleImagePickResult(PickImageResult result) async {
    if (result is PickImageResultNone) {
      return;
    }

    if (result is PickImageResultPicked) {
      isLoadingImage = true;

      final UploadedImage? imageUpload = await imagePicker.uploadImage(result.image);

      if (imageUpload != null) {
        final BaseResponse<Brand?> response = await _brandsRepository.updateData(
          brand.id,
          avatar: imageUpload.data,
        );

        if (response.successful) {
          brand.setAvatar(response.data!.avatar!, response.data!.avatar250);
        }
      }

      isLoadingImage = false;
    }
  }

  Future<void> addContact(Contact contact) async {
    brand.addContact(contact);

    final BaseResponse<Brand?> response = await _brandsRepository.updateData(brand.id, contacts: brand.contacts);

    if (response.successful) {
      brand = response.data!;
    }
  }

  Future<void> deleteContact(Contact contact) async {
    brand.deleteContact(contact);

    final BaseResponse<Brand?> response = await _brandsRepository.updateData(brand.id, contacts: brand.contacts);

    if (response.successful) {
      brand = response.data!;
    }
  }

  @override
  Future<void> initialize() async {
    nickname = brand.nickname;
    title = brand.title;
    description = brand.about;

    category = BrandCategory(title: brand.category);
  }

  void updateBrand(Brand value) => brand = value;

  void setDescription(String value) => description = value;
  void setTitle(String value) => title = value;
  void setNickname(String value) {
    nickname = value;

    getNicknameAvailability();
  }

  void setUrl(String value) => url = value;

  void setCategoryTitle(String? value) => categoryTitle = value;
  void setCategory(BrandCategory? value) => category = value;
}
