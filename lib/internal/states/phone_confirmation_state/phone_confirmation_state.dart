// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/phone_repository.dart';
import 'package:norm/data/local_storage/app_localization_local_storage/app_localization_local_storage.dart';
import 'package:norm/domain/models/country_code/country_code.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/states/country_codes_state/country_codes_state.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';
import 'package:norm/internal/utils/infrastructure.dart';

part 'phone_confirmation_state.g.dart';

class PhoneConfirmationState extends _PhoneConfirmationStateBase with _$PhoneConfirmationState {
  /// Required code length.
  static const int INPUT_CODE_LENGTH = 6;
}

abstract class _PhoneConfirmationStateBase with Store implements Initializable {
  CountryCodesState get _countryCodesState => service<CountryCodesState>();
  AppLocalizationLocalStorage get _localizationStorage => service<AppLocalizationLocalStorage>();
  PhoneRepository get _phoneRepository => service<PhoneRepository>();

  /// User country code.
  @observable
  CountryCode? countryCode;

  @observable
  String phoneNumber = '';

  @observable
  List<int> errors = [];

  /// Verification code user has inputed.
  @observable
  String verificationCode = '';

  /// If request is in progress.
  @observable
  bool isLoading = false;

  /// Whether user completed code input or not.
  @computed
  bool get filledCode => verificationCode.length == PhoneConfirmationState.INPUT_CODE_LENGTH;

  @computed
  String get phone => '${countryCode?.phoneCode}$phoneNumber';

  void changePhoneNumber(CountryCode code, String number) {
    countryCode = code;
    phoneNumber = number;
  }

  Future<bool> confirmPhone() async {
    errors.clear();
    isLoading = true;

    final BaseResponse response = await _phoneRepository.confirmPhoneWithCode(phone: phone, code: verificationCode);

    isLoading = false;

    // If response is successful.
    if (response.successful) {
      service<AuthState>().user?.setPhone(phone);
      return true;
    } else {
      errors = response.errorCodes;
    }

    return false;
  }

  Future<bool> requestPhoneConfirmation() async {
    errors.clear();
    isLoading = true;

    final BaseResponse response = await _phoneRepository.requestPhoneConfirmation(phone: phone);

    isLoading = false;

    // If response is successful.
    if (response.successful) {
      return true;
    } else {
      errors = response.errorCodes;
    }

    return false;
  }

  Future<void> _handleInitialCountryCode() async {
    // Trying to find SIM country code.
    String isoCountryCode = '';
    // Trying to find Locale country code.
    if (isoCountryCode.isBlank) {
      isoCountryCode = _localizationStorage.localization ?? 'RU';
    }

    if (!isoCountryCode.isBlank) {
      isoCountryCode = isoCountryCode.toLowerCase();

      // If iso country code of sim card is known.
      if (_countryCodesState.countryCodes.any((code) => code.id.toLowerCase() == isoCountryCode)) {
        // Take country code from memory.
        countryCode = _countryCodesState.countryCodes.firstWhere((code) => code.id.toLowerCase() == isoCountryCode);
        return;
      }
    }

    // Set default as russian.
    countryCode = _countryCodesState.countryCodes.firstWhere((e) => e.id == 'RU');
  }

  /// Sets verification code.
  void setCode(String code) {
    verificationCode = code;
  }

  void resetCode() {
    verificationCode = '';
  }

  @override
  Future<void> initialize() async {
    await Future.delayed(NConstants.aSecond);

    // Trying to define user country code of sim.
    await _handleInitialCountryCode().whenComplete(
      () => log('User predefined country code is ${countryCode?.id}'),
    );
  }
}
