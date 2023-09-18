// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/brands_repository.dart';
import 'package:norm/data/api/repositories/database_repository.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/animal/animal.dart';
import 'package:norm/domain/models/animal_type/animal_type.dart';
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/domain/models/education/education.dart';
import 'package:norm/domain/models/hobby/hobby.dart';
import 'package:norm/domain/models/language/language.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';

part 'edit_extended_information_state.g.dart';

class EditExtendedInformationState = _EditExtendedInformationStateBase with _$EditExtendedInformationState;

abstract class _EditExtendedInformationStateBase with Store {
  DatabaseRepository get _databaseRepository => service<DatabaseRepository>();
  UsersRepository get _usersRepository => service<UsersRepository>();
  BrandRepository get _brandsRepository => service<BrandRepository>();

  @computed
  User? get user => service<AuthState>().user;

  @observable
  ObservableList<Language> languages = ObservableList();

  @observable
  ObservableList<Brand> suggestedBrands = ObservableList();

  @observable
  ObservableList<Hobby> suggestedHobbies = ObservableList();

  @observable
  ObservableList<Animal> suggestedAnimals = ObservableList();

  @observable
  ObservableList<AnimalType> suggestedAnimalTypes = ObservableList();

  Future<void> addLanguage(Language language) async {
    user?.addLanguage(language);

    final BaseResponse<User?> response = await _usersRepository.updateData(languages: user?.languages);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }

  Future<void> deleteLanguage(Language language) async {
    user?.deleteLanguage(language);

    final BaseResponse<User?> response = await _usersRepository.updateData(languages: user?.languages);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }

  Future<void> addEducation(Education education) async {
    user?.addEducation(education);

    final BaseResponse<User?> response = await _usersRepository.updateData(educations: user?.educations);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }

  Future<void> deleteEducation(Education education) async {
    user?.deleteEducation(education);

    final BaseResponse<User?> response = await _usersRepository.updateData(educations: user?.educations);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }

  Future<void> addCareer(Career career) async {
    user?.addCareer(career);

    final BaseResponse<User?> response = await _usersRepository.updateData(career: user?.career);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }

  Future<void> deleteCareer(Career career) async {
    user?.deleteCareer(career);

    final BaseResponse<User?> response = await _usersRepository.updateData(career: user?.career);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }

  Future<void> addAnimal(Animal animal) async {
    user?.addAnimal(animal);

    final BaseResponse<User?> response = await _usersRepository.updateData(animals: user?.animals);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }

  Future<void> deleteAnimal(Animal animal) async {
    user?.deleteAnimal(animal);

    final BaseResponse<User?> response = await _usersRepository.updateData(animals: user?.animals);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }

  Future<void> addHobby(Hobby hobby) async {
    user?.addHobby(hobby);

    final BaseResponse<User?> response = await _usersRepository.updateData(hobbies: user?.hobbies);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
  }

  Future<void> deleteHobby(Hobby hobby) async {
    user?.deleteHobby(hobby);

    final BaseResponse<User?> response = await _usersRepository.updateData(hobbies: user?.hobbies);

    if (response.successful) {
      service<AuthState>().updateUser(response.data!);
    }
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

  Future<void> searchHobbies(String search) async {
    if (search.isEmpty) {
      suggestedHobbies = ObservableList.of([]);
      return;
    }

    final BaseResponse<List<Hobby>?> response = await _databaseRepository.searchHobbies(search: search);

    if (response.successful) {
      suggestedHobbies = ObservableList.of(response.data ?? []);
    }
  }

  Future<void> searchAnimals(String search) async {
    if (search.isEmpty) {
      suggestedAnimals = ObservableList.of([]);
      return;
    }

    final BaseResponse<List<Animal>?> response = await _databaseRepository.searchAnimals(search: search);

    if (response.successful) {
      suggestedAnimals = ObservableList.of(response.data ?? []);
    }
  }

  Future<void> searchAnimalTypes(int animalId, String search) async {
    if (search.isEmpty) {
      suggestedAnimalTypes = ObservableList.of([]);
      return;
    }

    final BaseResponse<List<AnimalType>?> response =
        await _databaseRepository.searchAnimalTypes(animalId: animalId, search: search);

    if (response.successful) {
      suggestedAnimalTypes = ObservableList.of(response.data ?? []);
    }
  }

  Future<void> loadLanguages() async {
    final BaseResponse<List<Language>> response = await _databaseRepository.fetchLanguages();

    if (response.successful) {
      languages = ObservableList.of(response.data ?? []);
    }
  }
}
