// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_input_field_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UiInputFieldDataModel _$UiInputFieldDataModelFromJson(
        Map<String, dynamic> json) =>
    UiInputFieldDataModel(
      type: json['type'] as String?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      isRequired: json['isRequired'] as bool?,
      choices: json['choices'] as List<dynamic>?,
      inputType: json['inputType'] as String?,
      visibleIf: json['visibleIf'] as String?,
    );

Map<String, dynamic> _$UiInputFieldDataModelToJson(
        UiInputFieldDataModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'title': instance.title,
      'isRequired': instance.isRequired,
      'choices': instance.choices,
      'inputType': instance.inputType,
      'visibleIf': instance.visibleIf,
    };
