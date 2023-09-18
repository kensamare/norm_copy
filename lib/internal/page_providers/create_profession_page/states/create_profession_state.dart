// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/specs_repository.dart';
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';

part 'create_profession_state.g.dart';

class CreateProfessionState = _CreateProfessionStateBase with _$CreateProfessionState;

abstract class _CreateProfessionStateBase with Store {
  SpecsRepository get _specsRepository => service<SpecsRepository>();

  @observable
  Speciality? speciality;

  @observable
  String? specialityTitle;

  @observable
  SpecialityLevel? level;

  @observable
  Career? career;

  @observable
  String? description;

  @observable
  DateTime? from;

  @observable
  ObservableList<Speciality> suggestedSpecs = ObservableList();

  @computed
  bool get canSave {
    if (speciality == null && specialityTitle.isBlank) return false;

    return level != null;
  }

  Future<Speciality?> createSpeciality() async {
    if (!canSave) return null;

    final BaseResponse<Speciality?> response = await _specsRepository.createSpeciality(
      type: career == null ? SpecialityType.profession : SpecialityType.work,
      specialityId: speciality?.id,
      specialityTitle: specialityTitle,
      role: career?.position,
      level: level,
      brandId: career?.brand?.id,
      brandTitle: career?.customTitle,
      description: description,
      from: from,
    );

    if (response.successful) {
      final Speciality speciality = response.data!;
      service<AuthState>().user?.addSpeciality(speciality);

      return speciality;
    }

    return null;
  }

  Future<void> loadSpecialities(String search) async {
    final BaseResponse<List<Speciality>> response = await _specsRepository.fetchSpecialities(search: search);

    if (response.successful) {
      suggestedSpecs = ObservableList.of(response.data!);
    }
  }

  void setSpeciality(Speciality? value) => speciality = value;
  void setSpecialityTitle(String? value) => specialityTitle = value;

  void setDescription(String? value) => description = value;

  void setLevel(SpecialityLevel? value) => level = value;
  void setCareer(Career? value) => career = value;

  void setFrom(DateTime value) => from = value;
}
