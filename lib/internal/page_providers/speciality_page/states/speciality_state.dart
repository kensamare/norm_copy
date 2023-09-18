// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/specs_repository.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

part 'speciality_state.g.dart';

class SpecialityState = _SpecialityStateBase with _$SpecialityState;

abstract class _SpecialityStateBase with Store implements Initializable {
  _SpecialityStateBase({required this.id});

  final int id;

  SpecsRepository get _specsRepository => service<SpecsRepository>();

  @observable
  Speciality? speciality;

  @observable
  bool isLoadingSpeciality = false;

  Future<void> _loadSpeciality() async {
    isLoadingSpeciality = true;

    final BaseResponse<Speciality?> response = await _specsRepository.fetchSpeciality(id: id);

    isLoadingSpeciality = false;

    if (response.successful) {
      speciality = response.data!;
    }
  }

  Future<void> follow() async {
    if (speciality == null) return;

    speciality!.follow();
    final BaseResponse response = await _specsRepository.followSpec(speciality!.id);

    if (response.hasError) {
      speciality!.unfollow();
    }
  }

  Future<void> unfollow() async {
    if (speciality == null) return;

    speciality!.unfollow();
    final BaseResponse response = await _specsRepository.unfollowSpec(speciality!.id);

    if (response.hasError) {
      speciality!.follow();
    }
  }

  @override
  Future<void> initialize() async {
    await _loadSpeciality();
  }

  void updateSpeciality(Speciality value) => speciality = value;
}
