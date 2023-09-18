// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/brands_repository.dart';
import 'package:norm/data/api/repositories/specs_repository.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/brand_category/brand_category.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/domain/models/uploaded_image/uploaded_image.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/image_picker/image_picker.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';

part 'create_brand_state.g.dart';

class CreateBrandState = _CreateBrandStateBase with _$CreateBrandState;

abstract class _CreateBrandStateBase with Store {
  BrandRepository get _brandsRepository => service<BrandRepository>();
  SpecsRepository get _specsRepository => service<SpecsRepository>();
  UsersRepository get _usersRepository => service<UsersRepository>();

  final NImagePicker imagePicker = NImagePicker();

  @observable
  String? image;

  @observable
  String? nickname;

  @observable
  bool isLoadingImage = false;

  /// New brand title.
  @observable
  String? title;

  /// Brand category.
  @observable
  BrandCategory? category;

  /// Brand category title.
  @observable
  String? categoryTitle;

  /// Brand.
  @observable
  int? year;

  @observable
  List<int> nicknameErrors = [];

  @observable
  bool isLoadingNicknameAvailability = false;

  @observable
  bool? isNicknameAvailable;

  @observable
  ObservableList<BrandCategory> suggestedBrandCategories = ObservableList();

  @computed
  bool get canAdd => !title.isBlank && (isNicknameAvailable ?? false) && (!categoryTitle.isBlank || category != null);

  Future<Speciality?> createBrand() async {
    if (!canAdd) return null;

    final BaseResponse<Brand?> response = await _brandsRepository.create(
      title: title!,
      nickname: nickname!,
      avatar: image,
      category: category,
      categoryTitle: categoryTitle,
    );

    /// If brand creation result is successful then we need to perform new request.
    if (response.successful) {
      final BaseResponse<Speciality?> specialityResponse = await _specsRepository.createSpeciality(
        type: SpecialityType.myBrand,
        brandId: response.data?.id,
        description: 'Founder',
      );

      if (specialityResponse.successful) {
        final Speciality speciality = specialityResponse.data!;
        service<AuthState>().user?.addSpeciality(speciality);

        return speciality;
      }
    }

    return null;
  }

  Future<void> getNicknameAvailability() async {
    nicknameErrors.clear();
    isLoadingNicknameAvailability = true;

    final BaseResponse<bool?> response = await _usersRepository.getNicknameAvailability(nickname ?? '');

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

      isLoadingImage = false;

      if (imageUpload != null) {
        image = imageUpload.data;
      }
    }

    if (result is PickImageResultDelete) {
      image = '';
    }
  }

  void setUsername(String value) {
    nickname = value;

    // Check if this username is available or not.
    getNicknameAvailability();
  }

  void setTitle(String? value) => title = value;
  void setCategoryTitle(String? value) => categoryTitle = value;
  void setCategory(BrandCategory? value) => category = value;

  void setYear(int value) => year = value;
}
