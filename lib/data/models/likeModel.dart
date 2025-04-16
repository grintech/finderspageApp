import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class LikeModel {
  int? likeId;
  int? totalLikes;
  int? user_id;
  int? blog_id;
  int? cate_id;
  String? action;
  String? type;
  String? url;
  String? reaction;

  Map<String, String>? likedBy;

  LikeModel({
    this.likeId,
    this.totalLikes,
    this.user_id,
    this.blog_id,
    this.cate_id,
    this.action,
    this.type,
    this.url,
    this.reaction,
    this.likedBy,
  });

  LikeModel.fromJson(Map<String, dynamic> json) {
    likeId = json['likeId'];
    user_id = json['user_id'];
    blog_id = json['blog_id'];
    cate_id = json['cate_id'];
    action = json['action'];
    type = json['type'];
    url = json['url'];
    totalLikes = json['total_likes'];
    reaction = json['reaction'];

    likedBy = (json['liked_by'] as Map?)?.map(
          (key, value) => MapEntry(key.toString(), value.toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null && value.toString().isNotEmpty) {
        data[key] = value;
      }
    }

    writeNotNull('likeId', likeId);
    writeNotNull('user_id', user_id);
    writeNotNull('blog_id', blog_id);
    writeNotNull('cate_id', cate_id);
    writeNotNull('action', action);
    writeNotNull('type', type);
    writeNotNull('url', url);
    writeNotNull('reaction', reaction);
    writeNotNull('total_likes', totalLikes);
    writeNotNull('liked_by', likedBy);

    return data;
  }
}
