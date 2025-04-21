import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class ComReplyModel{
  int? id;
  int? com_id;
  String? user_id;
  String? blog_id;
  String? comment;
  String? comment_id;
  String? blog_user_id;
  String? type;
  String? action;
  String? liked_by;
  String? blog_url;
  int? likes;
  int? status;
  String? username;
  String? image;

  ComReplyModel({
    this.id,
    this.com_id,
    this.user_id,
    this.blog_id,
    this.comment,
    this.comment_id,
    this.blog_url,
    this.blog_user_id,
    this.type,
    this.liked_by,
    this.action,
    this.likes,
    this.status,
    this.username,
    this.image,
  });

  ComReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    com_id = json['com_id'];
    user_id = json['user_id'];
    blog_id = json['blog_id'];
    comment = json['comment'];
    comment_id = json['comment_id'];
    blog_user_id = json['blog_user_id'];
    blog_url = json['blog_url'];
    type = json['type'];
    liked_by = json['liked_by'];
    action = json['action'];
    likes = json['likes'];
    status = json['status'];
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
    writeNotNull("id", id);
    writeNotNull("com_id", com_id);
    writeNotNull("user_id", user_id);
    writeNotNull("blog_id", blog_id);
    writeNotNull("comment", comment);
    writeNotNull("blog_user_id", blog_user_id);
    writeNotNull("blog_url", blog_url);
    writeNotNull("comment_id", comment_id);
    writeNotNull("type", type);
    writeNotNull("action", action);
    writeNotNull("liked_by", liked_by);
    writeNotNull("likes", likes);
    writeNotNull("status", status);
    writeNotNull("username", username);
    writeNotNull("image", image);
    return data;
  }
}