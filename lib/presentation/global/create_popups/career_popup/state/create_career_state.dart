// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/brands_repository.dart';
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

part 'create_career_state.g.dart';

class CreateCareerState = _CreateCareerStateBase with _$CreateCareerState;

abstract class _CreateCareerStateBase with Store implements Initializable {
  BrandRepository get _brandsRepository => service<BrandRepository>();

  /// Career description.
  @observable
  String? description;

  /// User position in company.
  @observable
  String? position;

  @observable
  Brand? brand;

  @observable
  String? brandTitle;

  @observable
  DateTimeRange? range;

  @observable
  ObservableList<Brand> suggestedBrands = ObservableList();

  Career? career() {
    if (!canPopWithResult) return null;

    return Career(
      brand: brand,
      customTitle: brandTitle,
      position: position!,
      description: description ?? '',
      from: range?.start,
      to: range?.end,
    );
  }

  @computed
  bool get canPopWithResult {
    if (brand == null && brandTitle.isBlank) return false;

    return !position.isBlank;
  }

  Future<void> searchBrands(String search) async {
    if (search.isEmpty) {
      suggestedBrands = ObservableList.of([]);
      return;
    }

    final BaseResponse<List<Brand>?> response = await _brandsRepository.fetchBrands(search: search);

    if (response.successful) {
      suggestedBrands = ObservableList.of(response.data ?? []);
    }
  }

  @override
  Future<void> initialize([Career? career]) async {
    if (career == null) return;

    range = DateTimeRange(
      start: career.from ?? DateTime.now(),
      end: career.to ?? DateTime.now(),
    );

    position = career.position;
    description = career.description;
    brand = career.brand;
    brandTitle = career.customTitle;
  }

  void setDescription(String value) => description = value;
  void setPosition(String value) => position = value;

  void setBrand(Brand? value) => brand = value;
  void setBrandTitle(String? value) => brandTitle = value;

  void setRange(DateTimeRange? value) => range = value;
}
