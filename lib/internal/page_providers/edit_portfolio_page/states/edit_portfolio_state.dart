// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/portfolio_repository.dart';
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/portfolio/portfolio.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

part 'edit_portfolio_state.g.dart';

class EditPortfolioState = _EditPortfolioStateBase with _$EditPortfolioState;

abstract class _EditPortfolioStateBase with Store implements Initializable {
  PortfolioRepository get _portfolioRepository => service<PortfolioRepository>();

  @observable
  Speciality? speciality;

  @observable
  List<Portfolio> portfolio = [];

  @computed
  User? get user => service<AuthState>().user;

  @computed
  List<Speciality> get specialities => user?.specs ?? [];

  Future<void> addPortfolio(Portfolio value) async {
    portfolio.insert(0, value);

    final BaseResponse<Portfolio?> response = await _portfolioRepository.createPortfolio(
      specialityId: speciality?.type != SpecialityType.myBrand ? speciality?.id : null,
      brandId: speciality?.type == SpecialityType.myBrand ? speciality?.brandId : null,
      title: value.title,
      photos: value.photos,
      locationX: value.locationX,
      locationY: value.locationY,
    );
  }

  Future<void> _loadPortfolio() async {
    // Load portfolio for brand if chosen speciality is of my brand type.
    final BaseResponse<List<Portfolio>> response = await _portfolioRepository.fetchPortfolio(
      specialityId: speciality?.type != SpecialityType.myBrand ? speciality?.id : null,
      brandId: speciality?.type == SpecialityType.myBrand ? speciality?.brandId : null,
    );

    if (response.successful) {
      portfolio = response.data!;
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

    // Load portfolio for this speciality.
    _loadPortfolio();
  }
}
