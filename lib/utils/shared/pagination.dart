import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class PaginationModel {
  @JsonKey(name: 'total_records')
  final int? totalRecords;

  @JsonKey(name: 'total_pages')
  final int? totalPages;

  @JsonKey(name: 'current_page')
  final int? currentPage;

  @JsonKey(name: 'per_page')
  final int? perPage;

  PaginationModel({
    this.totalRecords,
    this.totalPages,
    this.currentPage,
    this.perPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}
