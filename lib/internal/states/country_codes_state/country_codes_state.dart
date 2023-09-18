// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/domain/models/country_code/country_code.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

part 'country_codes_state.g.dart';

class CountryCodesState = _CountryCodesStateBase with _$CountryCodesState;

abstract class _CountryCodesStateBase with Store implements Initializable {
  static const String _COUNTRY_CODES_ASSET_PATH = 'assets/country_codes/json_data.json';

  List<CountryCode> countryCodes = [];

  @override
  Future<void> initialize() async {
    final String data = await rootBundle.loadString(_COUNTRY_CODES_ASSET_PATH);

    final List<dynamic> jsonData = jsonDecode(data);
    countryCodes = jsonData.map((e) => CountryCode.fromJson(e as Map<String, dynamic>)).toList();

    log('Loaded ${countryCodes.length} country codes!', name: 'COUNTRY_CODES');
  }
}
