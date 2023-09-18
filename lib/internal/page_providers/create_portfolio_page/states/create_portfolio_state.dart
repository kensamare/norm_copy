// Package imports:
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/domain/models/picked_location/picked_location.dart';
import 'package:norm/domain/models/portfolio/portfolio.dart';
import 'package:norm/domain/models/uploaded_image/uploaded_image.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/image_picker/image_picker.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';

part 'create_portfolio_state.g.dart';

class CreatePortfolioState = _CreatePortfolioStateBase with _$CreatePortfolioState;

abstract class _CreatePortfolioStateBase with Store {
  final NImagePicker imagePicker = NImagePicker();

  /// Portfolio title.
  @observable
  String? title;

  /// Link to portfolio work.
  @observable
  String? link;

  /// Portfolio description.
  @observable
  String? description;

  @observable
  PickedLocation? position;

  @observable
  List<String> photos = [];

  @observable
  bool isLoadingImages = false;

  @computed
  bool get canAdd => !title.isBlank && photos.isNotEmpty;

  Portfolio? portfolio() {
    if (!canAdd) return null;

    return Portfolio(
      id: -1,
      title: title!,
      photos: photos,
      locationX: position?.latitude,
      locationY: position?.longitude,
    );
  }

  Future<void> handleImagePickResult(PickImageResult result) async {
    if (result is PickImageResultNone) {
      return;
    }

    if (result is PickImageResultPickedMultiple) {
      isLoadingImages = true;

      final Stream<UploadedImage> imageUpload = imagePicker.uploadImages(result.images);
      imageUpload.forEach(
        (e) => photos.add(e.data),
      );

      isLoadingImages = false;
    }

    if (result is PickImageResultDelete) {
      // image = '';
      photos = [];
    }
  }

  void setTitle(String value) => title = value;
  void setLink(String value) => link = value;
  void setDescription(String value) => description = value;
  void setPosition(PickedLocation value) => position = value;
}
