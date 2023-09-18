// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/animal/animal.dart';
import 'package:norm/domain/models/animal_type/animal_type.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_dropdown/n_dropdown.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';

class AddAnimalsPopup extends StatefulWidget {
  const AddAnimalsPopup({
    super.key,
    this.animal,
    this.onNeedAnimalSearch,
    this.onNeedAnimalTypeSearch,
    this.suggestedAnimalTypes = const [],
    this.suggestedAnimals = const [],
  });

  final Animal? animal;

  /// Need animal search callback.
  final Function(String)? onNeedAnimalSearch;

  /// Suggested animals.
  final List<Animal> suggestedAnimals;

  /// Need animal types search callback.
  final Function(int, String)? onNeedAnimalTypeSearch;

  /// Suggested animal types.
  final List<AnimalType> suggestedAnimalTypes;

  @override
  State<AddAnimalsPopup> createState() => _AddAnimalsPopupState();
}

class _AddAnimalsPopupState extends State<AddAnimalsPopup> {
  int? id;

  /// Chosen animal.
  Animal? _animal;

  /// Chosen animal id.
  int? animalId;

  /// Custom animal title.
  String? animalTitle;

  /// Chosen animal type.
  AnimalType? animalType;

  /// Custom animal type title.
  String? animalTypeTitle;

  ///
  int? years;

  /// Description about this animal.
  String description = '';

  /// Can add this language.
  bool get canAdd {
    if (_animal == null && animalTitle.isBlank) return false;
    // if (animalType == null && animalTypeTitle.isBlank) return false;

    return years != null;
  }

  @override
  void initState() {
    if (widget.animal != null) {
      final Animal animal = widget.animal!;

      id = animal.id;
      _animal = animal;
      animalId = _animal?.animalId;
      animalTitle = animal.title;
      if (animal.typeTitle != null) animalType = AnimalType(title: animal.typeTitle ?? '', id: animal.typeId);
      animalTypeTitle = animal.typeTitle;

      years = animal.age;

      description = animal.description;
    }

    super.initState();
  }

  void addAnimal() {
    if (!canAdd) return;

    /// Chosen animal model.
    final Animal animal = Animal(
      id: id,
      animalId: animalId,
      customTitle: animalTitle,
      typeId: animalType?.id,
      typeTitle: animalTypeTitle,
      description: description,
      age: years ?? 1,
    );

    AutoRouter.of(context).pop(animal);
  }

  Widget _buildSaveButton(BuildContext context) {
    return NButton(
      onPressed: addAnimal,
      title: 'Добавить',
      width: double.infinity,
      active: canAdd,
    );
  }

  Widget _buildAnimalField(BuildContext context) {
    return NDropdown(
      onManualChanged: (value) {
        setState(() {
          animalTitle = value;
          _animal = null;
        });

        widget.onNeedAnimalSearch?.call(value);
      },
      onChanged: (value) {
        setState(() {
          animalTitle = null;
          _animal = value;
          animalId = _animal?.id;
        });
      },
      width: double.infinity,
      hint: 'Животное',
      value: _animal,
      items: widget.suggestedAnimals
          .map(
            (e) => NDropdownItem(title: e.title, value: e),
          )
          .toList(),
      allowManualValues: true,
    );
  }

  Widget _buildAnimalTypeField(BuildContext context) {
    return NDropdown(
      onManualChanged: (value) {
        setState(() {
          animalTypeTitle = value;
          animalType = null;
        });

        widget.onNeedAnimalTypeSearch?.call(_animal?.id ?? 0, value);
      },
      onChanged: (value) {
        setState(() {
          animalTypeTitle = null;
          animalType = value;
        });
      },
      width: double.infinity,
      hint: 'Порода',
      value: animalType,
      items: widget.suggestedAnimalTypes
          .map(
            (e) => NDropdownItem(title: e.title, value: e),
          )
          .toList(),
      allowManualValues: true,
      active: _animal != null || !animalTitle.isBlank,
    );
  }

  Widget _buildYearsField(BuildContext context) {
    return NTextField(
      initialValue: years == null ? null : years!.toString(),
      onChanged: (value) => setState(
        () => years = int.tryParse(value),
      ),
      width: double.infinity,
      keyboardType: TextInputType.number,
      hintText: 'Возраст',
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    return NTextField(
      initialValue: description,
      onChanged: (value) => setState(() => description = value),
      width: double.infinity,
      maxLines: 4,
      hintText: 'Комментарий',
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        child: Column(
          children: [
            _buildAnimalField(context),
            SizedBox(height: 20.h),
            _buildAnimalTypeField(context),
            SizedBox(height: 20.h),
            _buildYearsField(context),
            SizedBox(height: 20.h),
            _buildDescriptionField(context),
            SizedBox(height: 40.h),
            _buildSaveButton(context),
            Consumer<ScreenHeight>(
              builder: (context, value, _) => SizedBox(height: value.isOpen ? (value.keyboardHeight + 24.h) : 40.h),
            ),
          ],
        ),
      ),
    );
  }
}
