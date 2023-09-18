// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) => Animal(
      id: json['id'] as int?,
      animalId: json['id_animal'] as int?,
      description: json['description'] as String? ?? '',
      title: json['title'] as String? ?? '',
      age: json['years'] as int? ?? 1,
      customTitle: json['animal_title'] as String?,
      typeId: json['id_animal_type'] as int?,
      typeTitle: json['animal_type_title'] as String?,
    );

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'id': instance.id,
      'id_animal': instance.animalId,
      'description': instance.description,
      'title': instance.title,
      'animal_title': instance.customTitle,
      'id_animal_type': instance.typeId,
      'animal_type_title': instance.typeTitle,
      'years': instance.age,
    };
