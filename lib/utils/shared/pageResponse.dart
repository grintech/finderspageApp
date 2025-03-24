import 'package:json_annotation/json_annotation.dart';

part 'pageResponse.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: false, explicitToJson: true)
class PageResponse<TModel> {

  bool? success;
  int? status;
  int? code;
  String? message;
  String? error;
  List<TModel>? data;

  PageResponse({
    this.success,
    this.status,
    this.code,
    this.message,
    this.error,
    this.data,
  });

  factory PageResponse.fromJson(
      Map<String, dynamic> json,
      TModel Function(Object? json) fromJsonT,
      ) =>
      _$PageResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(TModel value) toJsonT) =>
      _$PageResponseToJson(this, toJsonT);
}
