// Dart imports:
import 'dart:io';

// Package imports:
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/internal/services/image_picker/image_picker.dart';

part 'pick_image_state.g.dart';

class PickImageState = _PickImageStateBase with _$PickImageState;

abstract class _PickImageStateBase with Store {
  NImagePicker imagePicker = NImagePicker();

  Future<PickImageResult> pickImage([ImageSource source = ImageSource.gallery, bool multiple = false]) async {
    if (!multiple) {
      final File? image = await imagePicker.pickImage(source);

      // Return picked image.
      if (image != null) {
        return PickImageResultPicked(image: image);
      }
    } else {
      final List<File> imageList = await imagePicker.pickMultipleImages();

      if (imageList.isNotEmpty) {
        return PickImageResultPickedMultiple(images: imageList);
      }
    }

    return PickImageResultNone();
  }

  Future<PickImageResult> deleteImage() async => PickImageResultDelete();
}

abstract class PickImageResult {}

class PickImageResultPicked extends PickImageResult {
  PickImageResultPicked({required this.image}) : super();

  final File image;
}

class PickImageResultPickedMultiple extends PickImageResult {
  PickImageResultPickedMultiple({required this.images}) : super();

  final List<File> images;
}

class PickImageResultDelete extends PickImageResult {}

class PickImageResultNone extends PickImageResult {}

abstract class CropResult {}

class CropResultNone extends CropResult {}

class CropResultCropped extends CropResult {
  CropResultCropped({required this.image}) : super();

  final File image;
}
