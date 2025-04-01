class SignupModel {
  bool? success;
  String? message;
  UserData? data;

  SignupModel({this.success, this.message, this.data});

  SignupModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  SignupUser? user;
  String? token;

  UserData({this.user, this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? SignupUser.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class SignupUser {
  String? firstName;
  String? username;
  String? email;
  String? slug;
  int? id;
  int? status;
  int? firstTimeLogin;
  int? completed;
  int? createdBy;
  String? messengerColor;
  String? userFrom;
  DateTime? created;
  DateTime? modified;

  SignupUser({
    this.firstName,
    this.username,
    this.email,
    this.slug,
    this.id,
    this.status,
    this.firstTimeLogin,
    this.completed,
    this.createdBy,
    this.messengerColor,
    this.userFrom,
    this.created,
    this.modified,
  });

  SignupUser.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    username = json['username'];
    email = json['email'];
    slug = json['slug'];
    id = json['id'];
    status = json['status'];
    firstTimeLogin = json['first_time_login'];
    completed = json['completed'];
    createdBy = json['created_by'];
    messengerColor = json['messenger_color'];
    userFrom = json['user_from'];
    created = json['created'] != null ? DateTime.tryParse(json['created']) : null;
    modified = json['modified'] != null ? DateTime.tryParse(json['modified']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['username'] = username;
    data['email'] = email;
    data['slug'] = slug;
    data['id'] = id;
    data['status'] = status;
    data['first_time_login'] = firstTimeLogin;
    data['completed'] = completed;
    data['created_by'] = createdBy;
    data['messenger_color'] = messengerColor;
    data['user_from'] = userFrom;
    data['created'] = created?.toIso8601String();
    data['modified'] = modified?.toIso8601String();
    return data;
  }
}
