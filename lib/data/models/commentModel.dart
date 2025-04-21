import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CommentModel{
  String? comment;
  String? post_id;
  String? post_user;
  String? user_id;
  String? type;
  String? blog_id;
  String? userImage;
  String? userName;
  String? blog_user_id;

  CommentModel({
    this.comment,
    this.post_id,
    this.post_user,
    this.user_id,
    this.type,
    this.blog_id,
    this.userImage,
    this.userName,
    this.blog_user_id,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    user_id = json['user_id'];
    blog_id = json['blog_id'];
    post_id = json['post_id'];
    post_user = json['post_user'];
    type = json['type'];
    userImage = json['userImage'];
    userName = json['userName'];
    blog_user_id = json['blog_user_id'];
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
    writeNotNull('comment', comment);
    writeNotNull('user_id', user_id);
    writeNotNull('blog_id', blog_id);
    writeNotNull('post_id', post_id);
    writeNotNull('post_user', post_user);
    writeNotNull('type', type);
    writeNotNull('userImage', userImage);
    writeNotNull('userName', userName);
    writeNotNull('blog_user_id', blog_user_id);
    return data;
  }
}