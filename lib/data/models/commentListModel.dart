import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CommentListModel{
  int? id;
  int? comId;
  String? userId;
  String? blogId;
  String? comment;
  int? comment_id;
  String? action;
  String? type;
  int? likes;
  String? likedBy;
  int? status;
  String? pin;
  dynamic pinCreatedAt;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? username;
  String? image;


  CommentListModel({
    this.id,
    this.comId,
    this.userId,
    this.blogId,
    this.comment,
    this.comment_id,
    this.action,
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
    comment_id = json['comment_id'];
    action = json['action'];
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
    writeNotNull('user_id', userId);
    writeNotNull('blogId', blogId);
    writeNotNull('comment', comment);
    writeNotNull('action', action);
    writeNotNull('comment_id', comment_id);
    writeNotNull('type', type);
    writeNotNull('likes', likes);
    writeNotNull('liked_by', likedBy);
    writeNotNull('status', status);
    writeNotNull('pin', pin);
    writeNotNull('pinCreatedAt', pinCreatedAt);
    writeNotNull('created_at', createdAt);
    writeNotNull('updated_at', updatedAt);
    writeNotNull('deletedAt', deletedAt);
    writeNotNull('username', username);
    writeNotNull('image', image);
  return data;
  }
}