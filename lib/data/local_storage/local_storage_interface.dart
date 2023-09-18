// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:norm/internal/states/interfaces/initializable.dart';

abstract class LocalStorageInterface implements Initializable {
  /// HIVE box name.
  abstract final String boxName;

  /// Box instance getter.
  Box get box;
}
