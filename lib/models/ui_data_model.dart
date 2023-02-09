import 'package:dynamic_ui/models/ui_input_field_data_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'ui_data_model.g.dart';

@JsonSerializable()
class UiDataModel {
  final String name;
  final String title;
  final List<UiInputFieldDataModel> elements;

  UiDataModel({
    required this.name,
    required this.title,
    required this.elements,
  });

  factory UiDataModel.fromJson(Map<String, dynamic> json) =>
      _$UiDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UiDataModelToJson(this);
}
