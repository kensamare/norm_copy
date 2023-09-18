// Dart imports:
import 'dart:io';
import 'dart:typed_data';

// Package imports:
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/media_repository.dart';
import 'package:norm/domain/models/uploaded_image/uploaded_image.dart';
import 'package:norm/internal/services/n_logger/n_logger.dart';
import 'package:norm/internal/services/service_locator.dart';

class NImagePicker {
  MediaRepository get _mediaRepository => service<MediaRepository>();

  /// Расрешенные расширения изображений.
  static const List<String> _allowedExtensions = ['jpeg', 'jpg', 'png', 'gif'];

  /// Максимальная ширина изображения в пикселях
  static const double _maxImageWidth = 1500;

  /// Процент сжатия изображения.
  static const int _compressedImageQuality = 25;

  static Future<void> _showDialog(ImageSource source) async {
    // await Get.dialog(
    //   CupertinoAlertDialog(
    //     title: const Text('Доступ к фото'),
    //     content: Text(
    //         'Необходимо предоставить доступ к ${source == ImageSource.camera ? 'Камере' : 'Фото'} в настройках приложения.\nЕсли же вы не хотите менять свой выбор нажмите Отмена!'),
    //     actions: <CupertinoDialogAction>[
    //       CupertinoDialogAction(
    //         child: const Text('Настройки'),
    //         isDestructiveAction: false,
    //         onPressed: () async {
    //           await PhotoManager.openSetting();
    //           Get.back();
    //         },
    //       ),
    //       CupertinoDialogAction(
    //         child: const Text('Отмена'),
    //         isDestructiveAction: true,
    //         onPressed: () {
    //           Get.back();
    //         },
    //       )
    //     ],
    //   ),
    //   barrierDismissible: false,
    // );
  }

  static Future<bool> _handlePermissions(ImageSource source) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      if (Platform.isIOS) {
        return true;
      } else {
        status = await Permission.camera.request();
      }

      // return true;
    } else {
      status = await Permission.storage.request();
      // await [Permission.photos, Permission.storage].request();
    }

    if (status.isDenied || status.isPermanentlyDenied) {
      // await _showDialog(source);
      // if (status.isDenied || status.isPermanentlyDenied) {
      //   return false;
      // } else {
      //   return true;
      // }
      return false;
    } else {
      return true;
    }
  }

  Future<List<File>> pickMultipleImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage();

    /// List of files to return.
    List<File> files = [];

    for (XFile file in images) {
      // Файловый поток изображения.
      final File imageFile = File(file.path);
      final String? extension = _fileExtension(imageFile);

      // Если не удалось определить расширение, тогда возвращаем null.
      if (extension == null) continue;
      files.add(imageFile);
    }

    return files;
  }

  Future<File?> pickImage([ImageSource source = ImageSource.gallery, bool compress = true]) async {
    final bool permissionResult = await _handlePermissions(source);
    // final bool permissionResult = true;
    if (!permissionResult) return null;

    XFile? image;
    try {
      image = await ImagePicker().pickImage(source: source);
    } catch (e, s) {
      NLogger.handleException(e, s);
    }

    // if (Platform.isAndroid) {
    //   _image = await ImagePicker().pickImage(
    //     source: source,
    //     // imageQuality: compress ? _compressedImageQuality : null,
    //     // maxWidth: _maxImageWidth,
    //   );
    // } else {
    //   _image = await ImagePicker().pickImage(
    //     source: source,
    //     // imageQuality: compress ? _compressedImageQuality : null,
    //     // maxWidth: _maxImageWidth,
    //   );
    // }

    // Если файл не выбран, то возвращаем null результат.
    if (image == null) return null;

    // Файловый поток изображения.
    final File imageFile = File(image.path);
    final String? extension = _fileExtension(imageFile);

    // Если не удалось определить расширение, тогда возвращаем null.
    if (extension == null) return null;

    return imageFile;
  }

  Stream<UploadedImage> uploadImages(List<File> files) async* {
    final Iterable<Future<UploadedImage?>> futures = files.map((e) => uploadImage(e));

    for (Future<UploadedImage?> future in futures) {
      final UploadedImage? result = await future;

      if (result != null) {
        yield result;
      }
    }
  }

  Future<UploadedImage?> uploadImage(File file) async {
    final String? fileExtension = _fileExtension(file);
    File? _file = file;

    // Если файл имеется неподдерживаемое разрешение, то досвидания.
    if (!_allowedExtensions.contains(fileExtension)) {
      // Пробуем конвертировать файл в поддерживаемый формат.
      _file = await _convertFileToSupportedExtension(file);
    }

    // Если не удалось конвертировать файл, тогда не загружаем его.
    if (_file == null) return null;

    // Байты изображения.
    Uint8List imageData = _file.readAsBytesSync();

    // Request to upload image.
    final BaseResponse<UploadedImage?> result = await _mediaRepository.uploadImage(imageData, fileExtension);

    if (result.successful) {
      return result.data;
    } else {
      return null;
    }
  }

  static Future<File?> _convertFileToSupportedExtension(File file) async {
    final String? extension = _fileExtension(file);
    if (extension == null) return null;

    // Конвертация формата iOS.
    if (extension == 'heic' || extension == 'heif') {
      final Directory dir = await getTemporaryDirectory();
      return await FlutterImageCompress.compressAndGetFile(file.absolute.path, '${dir.absolute.path}temp.jpg');
    }

    return null;
  }

  // Возвращает расширение файла.
  static String? _fileExtension(File file) {
    if (file.path.isEmpty) return null;

    return file.path.split('/').last.split('.').last;
  }
}
