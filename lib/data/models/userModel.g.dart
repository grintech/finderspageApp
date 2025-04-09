// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  first_name: json['first_name'] as String?,
  username: json['username'] as String?,
  email: json['email'] as String?,
  password: json['password'] as String?,
  image: json['image'] as String?,
  phonenumber: json['phonenumber'] as String?,
  zipcode: json['zipcode'] as String?,
  bio: json['bio'] as String?,
  cover_img: json['cover_img'] as String?,
  id: (json['id'] as num?)?.toInt(),
  slug: json['slug'] as String?,
  status: (json['status'] as num?)?.toInt(),
  createdBy: json['createdBy'] as String?,
  created: json['created'] as String?,
  firstTimeLogin: (json['firstTimeLogin'] as num?)?.toInt(),
  messengerColor: json['messengerColor'] as String?,
  modified: json['modified'] as String?,
  completed: (json['completed'] as num?)?.toInt(),
  userFrom: json['userFrom'] as String?,
  followerDetails:
      (json['followerDetails'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  ads:
      (json['ads'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  post:
      (json['post'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  business:
      (json['business'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  job:
      (json['job'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  real_estate:
      (json['real_estate'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  community:
      (json['community'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  shopping:
      (json['shopping'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  fundraisers:
      (json['fundraisers'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  service:
      (json['service'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  entertainment:
      (json['entertainment'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  user:
      json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  token: json['token'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  if (instance.first_name case final value?) 'first_name': value,
  if (instance.username case final value?) 'username': value,
  if (instance.email case final value?) 'email': value,
  if (instance.password case final value?) 'password': value,
  if (instance.image case final value?) 'image': value,
  if (instance.phonenumber case final value?) 'phonenumber': value,
  if (instance.zipcode case final value?) 'zipcode': value,
  if (instance.bio case final value?) 'bio': value,
  if (instance.cover_img case final value?) 'cover_img': value,
  if (instance.id case final value?) 'id': value,
  if (instance.slug case final value?) 'slug': value,
  if (instance.status case final value?) 'status': value,
  if (instance.createdBy case final value?) 'createdBy': value,
  if (instance.created case final value?) 'created': value,
  if (instance.firstTimeLogin case final value?) 'firstTimeLogin': value,
  if (instance.messengerColor case final value?) 'messengerColor': value,
  if (instance.modified case final value?) 'modified': value,
  if (instance.completed case final value?) 'completed': value,
  if (instance.userFrom case final value?) 'userFrom': value,
  if (instance.user case final value?) 'user': value,
  if (instance.token case final value?) 'token': value,
  if (instance.followerDetails case final value?) 'followerDetails': value,
  if (instance.ads case final value?) 'ads': value,
  if (instance.post case final value?) 'post': value,
  if (instance.business case final value?) 'business': value,
  if (instance.job case final value?) 'job': value,
  if (instance.real_estate case final value?) 'real_estate': value,
  if (instance.community case final value?) 'community': value,
  if (instance.shopping case final value?) 'shopping': value,
  if (instance.fundraisers case final value?) 'fundraisers': value,
  if (instance.service case final value?) 'service': value,
  if (instance.entertainment case final value?) 'entertainment': value,
};
