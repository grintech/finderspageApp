// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponse<TModel> _$PageResponseFromJson<TModel>(
  Map<String, dynamic> json,
  TModel Function(Object? json) fromJsonTModel,
) => PageResponse<TModel>(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  code: (json['code'] as num?)?.toInt(),
  message: json['message'] as String?,
  error: json['error'] as String?,
  data: (json['data'] as List<dynamic>?)?.map(fromJsonTModel).toList(),
);

Map<String, dynamic> _$PageResponseToJson<TModel>(
  PageResponse<TModel> instance,
  Object? Function(TModel value) toJsonTModel,
) => <String, dynamic>{
  if (instance.success case final value?) 'success': value,
  if (instance.status case final value?) 'status': value,
  if (instance.code case final value?) 'code': value,
  if (instance.message case final value?) 'message': value,
  if (instance.error case final value?) 'error': value,
  if (instance.data?.map(toJsonTModel).toList() case final value?)
    'data': value,
};
