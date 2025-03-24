// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponse<TModel> _$DataResponseFromJson<TModel>(
  Map<String, dynamic> json,
  TModel Function(Object? json) fromJsonTModel,
) => DataResponse<TModel>(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  error: json['error'] as String?,
  data: _$nullableGenericFromJson(json['data'], fromJsonTModel),
);

Map<String, dynamic> _$DataResponseToJson<TModel>(
  DataResponse<TModel> instance,
  Object? Function(TModel value) toJsonTModel,
) => <String, dynamic>{
  if (instance.success case final value?) 'success': value,
  if (instance.status case final value?) 'status': value,
  if (instance.message case final value?) 'message': value,
  if (instance.error case final value?) 'error': value,
  if (_$nullableGenericToJson(instance.data, toJsonTModel) case final value?)
    'data': value,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
