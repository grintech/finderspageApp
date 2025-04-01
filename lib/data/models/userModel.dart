import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class UserModel {
  String? firstName;
  String? username;
  String? email;
  String? password;
  int? id;
  String? slug;
  int? status;
  String? createdBy;
  String? created;
  int? firstTimeLogin;
  String? messengerColor;
  String? modified;
  int? completed;
  String? userFrom;
  UserModel? user;
  String? token;

  UserModel({
    this.firstName,
    this.username,
    this.email,
    this.password,
    this.id,
    this.slug,
    this.status,
    this.createdBy,
    this.created,
    this.firstTimeLogin,
    this.messengerColor,
    this.modified,
    this.completed,
    this.userFrom,
    this.user,
    this.token
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    firstName: json["first_name"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    id: json["id"],
    slug: json["slug"],
    status: json["status"],
    createdBy: json["created_by"],
    created: json["created"],
    firstTimeLogin: json["first_time_login"],
    messengerColor: json["messenger_color"],
    modified: json["modified"],
    completed: json["completed"],
    userFrom: json["user_from"],
    user: UserModel.fromMap(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "first_name": firstName,
    "username": username,
    "email": email,
    "password": password,
    "id": id,
    "slug": slug,
    "status": status,
    "created_by": createdBy,
    "created": created,
    "first_time_login": firstTimeLogin,
    "messenger_color": messengerColor,
    "modified": modified,
    "completed": completed,
    "user_from": userFrom,
    "user": user?.toMap(),
    "token": token,
  };

  /// Factory constructor for creating a new instance from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Converts the instance into a JSON map.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
