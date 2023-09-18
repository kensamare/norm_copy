// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/items_repository.dart';
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/item/item.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

part 'edit_shop_state.g.dart';

class EditShopState = _EditShopStateBase with _$EditShopState;

abstract class _EditShopStateBase with Store implements Initializable {
  ItemsRepository get _itemsRepository => service<ItemsRepository>();

  @observable
  Speciality? speciality;

  @observable
  List<Item> items = [];

  @computed
  User? get user => service<AuthState>().user;

  @computed
  List<Speciality> get specialities => user?.specs ?? [];

  Future<void> addItem(Item value) async {
    items.insert(0, value);

    final BaseResponse<Item?> response = await _itemsRepository.createItem(
      specialityId: speciality?.type != SpecialityType.myBrand ? speciality?.id : null,
      brandId: speciality?.type == SpecialityType.myBrand ? speciality?.brandId : null,
      title: value.title,
      photos: value.photos,
      locationX: value.locationX,
      locationY: value.locationY,
    );
  }

  Future<void> _loadItems() async {
    // Load portfolio for brand if chosen speciality is of my brand type.
    final BaseResponse<List<Item>> response = await _itemsRepository.fetchItems(
      specialityId: speciality?.type != SpecialityType.myBrand ? speciality?.id : null,
      brandId: speciality?.type == SpecialityType.myBrand ? speciality?.brandId : null,
    );

    if (response.successful) {
      items = response.data!;
    }
  }

  @override
  Future<void> initialize({Speciality? spec, Brand? brand}) async {
    if (spec != null) {
      setSpeciality(spec);
    } else if (brand != null) {
      // Find speciality of provided brand.
      final List<Speciality> specialities = user?.specs ?? [];

      if (specialities.any((e) => e.brandId == brand.id)) {
        setSpeciality(specialities.firstWhere((e) => e.brandId == brand.id));
      }
    }
  }

  void setSpeciality(Speciality value) async {
    speciality = value;

    // Load items for this speciality.
    _loadItems();
  }
}
