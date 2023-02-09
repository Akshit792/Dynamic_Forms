import 'package:json_annotation/json_annotation.dart';

part 'ui_input_field_data_model.g.dart';

@JsonSerializable()
class UiInputFieldDataModel {
  final String? type;
  final String? name;
  final String? title;
  final bool? isRequired;
  final List<dynamic>? choices;
  final String? inputType;
  final String? visibleIf;

  UiInputFieldDataModel({
    this.type,
    this.name,
    this.title,
    this.isRequired,
    this.choices,
    this.inputType,
    this.visibleIf,
  });

  factory UiInputFieldDataModel.fromJson(Map<String, dynamic> json) =>
      _$UiInputFieldDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UiInputFieldDataModelToJson(this);
}
