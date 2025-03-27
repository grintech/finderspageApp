import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class MainHomeModel{
  int? id;
  dynamic parentId;
  String? title;
  String? slug;
  String? image;
  int? status;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  int? createdBy;
  dynamic deletedAt;
  String? created;
  String? modified;

  MainHomeModel({
    this.id,
    this.parentId,
    this.title,
    this.slug,
    this.image,
    this.status,
    this.metaTitle,
    this.metaKeywords,
    this.metaDescription,
    this.createdBy,
    this.deletedAt,
    this.created,
    this.modified,
  });

  MainHomeModel.fromJson(Map<String, dynamic>json){
    id =json["id"];
    parentId =json["parentId"];
    title =json["title"];
    slug =json["slug"];
    image =json["image"];
    status =json["status"];
    metaTitle =json["metaTitle"];
    metaKeywords =json["metaKeywords"];
    metaDescription =json["metaDescription"];
    createdBy =json["createdBy"];
    deletedAt =json["deletedAt"];
    created =json["created"];
    modified =json["modified"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null && value.toString().isNotEmpty) {
        data[key] = value;
      }
    }
    writeNotNull('id', id);
    writeNotNull('parentId', parentId);
    writeNotNull('title', title);
    writeNotNull('slug', slug);
    writeNotNull('image', image);
    writeNotNull('status', status);
    writeNotNull('metaTitle', metaTitle);
    writeNotNull('metaKeywords', metaKeywords);
    writeNotNull('metaDescription', metaDescription);
    writeNotNull('createdBy', createdBy);
    writeNotNull('deletedAt', deletedAt);
    writeNotNull('created', created);
    writeNotNull('modified', modified);
    return data;
  }
}