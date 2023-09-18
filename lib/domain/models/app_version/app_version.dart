/// Stands for handling current app version.
class AppVersion {
  const AppVersion(this._rawVersion);

  factory AppVersion.fromParts({int major = 1, int feature = 0, int patch = 0}) {
    final List<int> parts = [major, feature, patch];

    return AppVersion(parts.join('.'));
  }

  static const List<int> _defaultAppVersionParts = [1, 0, 0];

  /// Raw string of app version.
  ///
  ///
  /// Version consists of three parts.
  /// First is major part, seconds is feature part and last is patch part.
  ///
  /// e.g. for version **1.2.3** - *1* is major part, *2* is feature and *3* is patch.
  final String _rawVersion;

  /// Raw version presented as string.
  String get raw => _rawVersion;

  /// Parts of app version.
  List<int> get _parts {
    final List<String> stringParts = _rawVersion.split('.');
    if (stringParts.length != 3) return _defaultAppVersionParts;

    return stringParts.map((e) => int.tryParse(e) ?? 0).toList();
  }

  /// Major part of the version.
  ///
  ///
  /// e.g **1** in *1.2.3*.
  int get major => _parts[0];

  /// Feature part of the version.
  ///
  ///
  /// e.g **2** in *1.2.3*.
  int get feature => _parts[1];

  /// Patch part of the version.
  ///
  ///
  /// e.g **3** in *1.2.3*.
  int get patch => _parts[2];

  /// Compares current version and `version`. Returns true if current version is higher.
  bool isHigher(AppVersion version) {
    if (major < version.major) {
      return false;
    } else if (major == version.major) {
      if (feature < version.feature) {
        return false;
      } else if (feature == version.feature) {
        if (patch > version.patch) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  /// Returns AppVersion that is one major high then current version.
  AppVersion incrementMajor() {
    return AppVersion.fromParts(major: major + 1, feature: feature, patch: patch);
  }

  /// Returns AppVersion that is one feature high then current version.
  AppVersion incrementFeature() {
    return AppVersion.fromParts(major: major, feature: feature + 1, patch: patch);
  }

  /// Returns AppVersion that is one patch high then current version.
  AppVersion incrementPatch() {
    return AppVersion.fromParts(major: major, feature: feature, patch: patch + 1);
  }
}
