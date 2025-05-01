import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)

class NotificationModel{
  int? id;
  String? relId;
  int? fromId;
  int? toId;
  String? message;
  String? url;
  String? type;
  String? notificationBy;
  int? read;
  String? cateId;
  String? hidden;
  dynamic deletedAt;
  String? created;
  String? modified;
  String? firstName;
  String? image;

  NotificationModel({
    this.id,
    this.relId,
    this.fromId,
    this.toId,
    this.message,
    this.url,
    this.type,
    this.notificationBy,
    this.read,
    this.cateId,
    this.hidden,
    this.deletedAt,
    this.created,
    this.modified,
    this.firstName,
    this.image
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relId = json['rel_id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    message = json['message'];
    url = json['url'];
    type = json['type'];
    notificationBy = json['notification_by'];
    read = json['read'];
    cateId = json['cate_id'];
    hidden = json['hidden'];
    deletedAt = json['deleted_at'];
    created = json['created'];
    firstName = json['first_name'];
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
    writeNotNull("rel_id", relId);
    writeNotNull("from_id", fromId);
    writeNotNull("to_id", toId);
    writeNotNull("message", message);
    writeNotNull("url", url);
    writeNotNull("type", type);
    writeNotNull("notification_by", notificationBy);
    writeNotNull("read", read);
    writeNotNull("cate_id", cateId);
    writeNotNull("hidden", hidden);
    writeNotNull("deleted_at", deletedAt);
    writeNotNull("created", created);
    writeNotNull("first_name", firstName);
    writeNotNull("image", image);
    return data;
  }
}