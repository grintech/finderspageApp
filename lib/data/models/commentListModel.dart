import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CommentListModel{
  int? id;
  int? comId;
  String? userId;
  String? blogId;
  String? comment;
  String? type;
  int? likes;
  String? likedBy;
  int? status;
  String? pin;
  Null? pinCreatedAt;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? username;
  String? image;


  CommentListModel({
    this.id,
    this.comId,
    this.userId,
    this.blogId,
    this.comment,
    this.type,
    this.likes,
    this.likedBy,
    this.status,
    this.pin,
    this.pinCreatedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.username,
    this.image
  });


  CommentListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comId = json['com_id'];
    userId = json['user_id'];
    blogId = json['blog_id'];
    comment = json['comment'];
    type = json['type'];
    likes = json['likes'];
    likedBy = json['liked_by'];
    status = json['status'];
    pin = json['pin'];
    pinCreatedAt = json['pin_created_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    username = json['username'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    void writeNotNull(String key, dynamic value) {
      if (value != null && value
          .toString()
          .isNotEmpty) {
        data[key] = value;
      }
    }
    writeNotNull('id', id);
    writeNotNull('comId', comId);
    writeNotNull('userId', userId);
    writeNotNull('blogId', blogId);
    writeNotNull('comment', comment);
    writeNotNull('type', type);
    writeNotNull('likes', likes);
    writeNotNull('likedBy', likedBy);
    writeNotNull('status', status);
    writeNotNull('pin', pin);
    writeNotNull('pinCreatedAt', pinCreatedAt);
    writeNotNull('createdAt', createdAt);
    writeNotNull('updatedAt', updatedAt);
    writeNotNull('deletedAt', deletedAt);
    writeNotNull('username', username);
    writeNotNull('image', image);
  return data;
  }
}