import 'package:json_annotation/json_annotation.dart';

part 'dataResponse.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: false, explicitToJson: true)
class DataResponse<TModel> {
  bool? success;
  int? status;
  String? message;
  String? error;
  TModel? data;

  DataResponse(
      {this.success, this.status, this.message, this.error, this.data});

  factory DataResponse.fromJson(

      Map<String, dynamic> json,
      TModel Function(Object? json) fromJsonT,) => _$DataResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(TModel value) toJsonT) =>
      _$DataResponseToJson(this, toJsonT);
}
