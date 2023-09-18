// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/brands_repository.dart';
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

part 'brand_state.g.dart';

class BrandState = _BrandStateBase with _$BrandState;

abstract class _BrandStateBase with Store implements Initializable {
  _BrandStateBase({
    required this.id,
  });

  /// ID of brand.
  final int id;

  /// Brand model of this profile.
  @observable
  Brand? brand;

  /// If app is loading information about brand or not.
  @observable
  bool isLoadingBrand = false;

  /// Brands repository.
  BrandRepository get _brandRepository => service<BrandRepository>();

  Future<void> follow() async {
    if (brand == null) return;

    brand!.follow();
    final BaseResponse response = await _brandRepository.followBrand(brand!.id);

    if (response.hasError) {
      brand!.unfollow();
    }
  }

  Future<void> unfollow() async {
    if (brand == null) return;

    brand!.unfollow();
    final BaseResponse response = await _brandRepository.unfollowBrand(brand!.id);

    if (response.hasError) {
      brand!.follow();
    }
  }

  Future<void> _loadBrand() async {
    isLoadingBrand = true;

    // Load brand information.
    final BaseResponse<Brand?> response = await _brandRepository.fetchBrand(id: id);

    if (response.successful) {
      brand = response.data!;
    }

    isLoadingBrand = false;
  }

  @override
  Future<void> initialize() async {
    await _loadBrand();
  }

  void updateBrand(Brand value) => brand = value;
}
