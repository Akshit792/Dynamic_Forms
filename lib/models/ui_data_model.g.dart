// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UiDataModel _$UiDataModelFromJson(Map<String, dynamic> json) => UiDataModel(
      name: json['name'] as String,
      title: json['title'] as String,
      elements: (json['elements'] as List<dynamic>)
          .map((e) => UiInputFieldDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UiDataModelToJson(UiDataModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'elements': instance.elements,
    };
