import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable(includeIfNull: false)
class UserModel {
  String? first_name;
  String? username;
  String? email;
  String? password;
  String? image;
  String? phonenumber;
  String? zipcode;
  String? bio;
  String? cover_img;
  String? user_id;
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
  List<UserModel>? followerDetails;
  List<UserModel>? ads;
  List<UserModel>? post;
  List<UserModel>? business;
  List<UserModel>? job;
  List<UserModel>? real_estate;
  List<UserModel>? community;
  List<UserModel>? shopping;
  List<UserModel>? fundraisers;
  List<UserModel>? service;
  List<UserModel>? entertainment;

  UserModel({
    this.first_name,
    this.username,
    this.email,
    this.password,
    this.image,
    this.phonenumber,
    this.zipcode,
    this.bio,
    this.cover_img,
    this.user_id,
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
    this.followerDetails,
    this.ads,
    this.post,
    this.business,
    this.job,
    this.real_estate,
    this.community,
    this.shopping,
    this.fundraisers,
    this.service,
    this.entertainment,
    this.user,
    this.token
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    first_name: json["first_name"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    image: json["image"],
    phonenumber: json["phonenumber"],
    zipcode: json["zipcode"],
    bio: json["bio"],
    cover_img: json["cover_img"],
    user_id: json["user_id"],
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
    followerDetails: json["followerDetails"] != null ?
    List<UserModel>.from(json["followerDetails"].map((x) => UserModel.fromMap(x))) : [],
    ads: json["ads"] != null ? List<UserModel>.from(json["ads"].map((x) => UserModel.fromMap(x))) : [],
    post: json["post"] != null ? List<UserModel>.from(json["post"].map((x) => UserModel.fromMap(x))) : [],
    business: json["business"] != null
        ? List<UserModel>.from(json["business"].map((x) => UserModel.fromMap(x))) : [],
    job: json["job"] != null ? List<UserModel>.from(json["job"].map((x) => UserModel.fromMap(x))) : [],
    real_estate: json["real_estate"] != null
        ? List<UserModel>.from(json["real_estate"].map((x) => UserModel.fromMap(x))) : [],
    community: json["community"] != null
        ? List<UserModel>.from(json["community"].map((x) => UserModel.fromMap(x))) : [],
    shopping: json["shopping"] != null
        ? List<UserModel>.from(json["shopping"].map((x) => UserModel.fromMap(x))) : [],
    fundraisers: json["fundraisers"] != null
        ? List<UserModel>.from(json["fundraisers"].map((x) => UserModel.fromMap(x))) : [],
    service: json["service"] != null ? List<UserModel>.from(json["service"].map((x) => UserModel.fromMap(x))) : [],
    entertainment: json["entertainment"] != null
        ? List<UserModel>.from(json["entertainment"].map((x) => UserModel.fromMap(x))) : [],
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "first_name": first_name,
    "username": username,
    "email": email,
    "password": password,
    "image": image,
    "phonenumber": phonenumber,
    "zipcode": zipcode,
    "bio": bio,
    "cover_img": cover_img,
    "user_id": user_id,
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
    "followerDetails": followerDetails?.map((e) => e.toMap()).toList(),
    "ads": ads?.map((e) => e.toMap()).toList(),
    "post": post?.map((e) => e.toMap()).toList(),
    "business": business?.map((e) => e.toMap()).toList(),
    "job": job?.map((e) => e.toMap()).toList(),
    "real_estate": real_estate?.map((e) => e.toMap()).toList(),
    "community": community?.map((e) => e.toMap()).toList(),
    "shopping": shopping?.map((e) => e.toMap()).toList(),
    "fundraisers": fundraisers?.map((e) => e.toMap()).toList(),
    "service": service?.map((e) => e.toMap()).toList(),
    "entertainment": entertainment?.map((e) => e.toMap()).toList(),
    "user": user?.toMap(),
    "token": token,
  };

  /// Factory constructor for creating a new instance from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Converts the instance into a JSON map.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
