// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/brands_repository.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/brand_category/brand_category.dart';
import 'package:norm/domain/models/uploaded_image/uploaded_image.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/image_picker/image_picker.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';

part 'grade_person_state.g.dart';

class GradePersonState = _GradePersonStateBase with _$GradePersonState;

abstract class _GradePersonStateBase with Store {
  UsersRepository get _usersRepository => service<UsersRepository>();

  /// Rate.
  @observable
  int rate = 0;

  /// Sliders value.
  @observable
  double sliderValue = 0;

  @observable
  int openness = 5;

  @observable
  int responsive = 5;

  @observable
  int conflicts = 5;

  @observable
  int selfishness = 5;

  @observable
  int reliability = 5;

  @observable
  int consistency = 5;

  @observable
  int creativity = 5;

  @observable
  int initiative = 5;

  /// Pluses and minuses block.
  @observable
  String pluses = '';

  @observable
  String minuses = '';

  /// Know Personally block.
  @observable
  bool knowPersonally = false;

  @observable
  int? closeness;

  @observable
  int? knowTime;

  @observable
  bool? garant;

  /// Spec. block.
  @observable
  int specId = -1;

  @observable
  int specKnowTime = -1;

  @observable
  int specRate = 0;

  @observable
  String specPluses = '';

  @observable
  String specMinuses = '';

  /// Send Anonymously.
  @observable
  bool sendAnonymously = false;

  /// If request is in progress of not.
  @observable
  bool isLoading = false;

  /// Error message to show.
  @observable
  List<int> errors = [];

  @computed
  bool get canRateUser {
    if (knowPersonally == true && (knowTime == -1 || closeness == -1 || garant != true)) {
      return false;
    }
    if (specId != -1 && specKnowTime == -1) {
      return false;
    }
    return true;
  }

  /// Action to update user rate
  void setRate(int value) => rate = value;

  /// Actions to update sliders value.
  @action
  void updateOpenness(int value) => openness = value;

  @action
  void updateResponsive(int value) => responsive = value;

  @action
  void updateConflicts(int value) => conflicts = value;

  @action
  void updateSelfishness(int value) => selfishness = value;

  @action
  void updateReliability(int value) => reliability = value;

  @action
  void updateConsistency(int value) => consistency = value;

  @action
  void updateCreativity(int value) => creativity = value;

  @action
  void updateInitiative(int value) => initiative = value;

  /// Set info about pluses and minuses.
  void setPluses(String value) => pluses = value;

  void setMinuses(String value) => minuses = value;

  /// Actions to update know personally block value.
  @action
  void setKnowPersonally(bool value) => knowPersonally = value;

  @action
  void setCloseness(int? value) => closeness = value;

  @action
  void setKnowTime(int? value) => knowTime = value;

  @action
  void setGarant(bool value) => garant = value;

  /// Action to set info in recommended block
  @action
  void setSpecId(int value) => specId = value;

  @action
  void setSpecKnowTime(int value) => specKnowTime = value;

  @action
  void setSpecRate(int value) => specRate = value;

  void setSpecPluses(String value) => specPluses = value;

  void setSpecMinuses(String value) => specMinuses = value;

  /// Send request state.
  @action
  void changeSendAnonymously() => sendAnonymously = !sendAnonymously;

  /// Send rate about user to server.
  Future<bool> sendUserRate(int id) async {
    errors = [];
    isLoading = true;

    /// Т.к слайдеры работают в диапозоне от -5 до 5 их данные надо приводить к формату от 0 до 10.
    final BaseResponse response = await _usersRepository.rateUser(
      id,
      rate: rate,
      openness: openness,
      responsive: responsive,
      conflict: conflicts,
      selfishness: selfishness,
      reliability: reliability,
      consistency: consistency,
      creativity: creativity,
      initiative: initiative,
      personallyKnow: knowPersonally,
      good: pluses,
      bad: minuses,
      knowTime: knowTime ?? 0,
      grant: garant ?? false,
      closeness: closeness ?? 0,
    );

    isLoading = false;

    // If response is successful.
    if (response.successful) {
      return true;
    } else {
      errors = response.errorCodes;
      print(response.errorCodes);
    }
    return false;
  }
}
