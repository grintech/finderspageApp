class SignupModel{
  String? firstName;
  String? username;
  String? email;
  String? password;
  int? id;
  String? slug;
  int? status;
  dynamic createdBy;
  String? created;
  int? firstTimeLogin;
  String? messengerColor;
  String? modified;
  int? completed;
  String? userFrom;
  SignupModel? user;
  String? token;

  SignupModel(
      {this.firstName,
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
        this.userFrom});

  SignupModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    id = json['id'];
    slug = json['slug'];
    status = json['status'];
    createdBy = json['created_by'];
    created = json['created'];
    firstTimeLogin = json['first_time_login'];
    messengerColor = json['messenger_color'];
    modified = json['modified'];
    completed = json['completed'];
    userFrom = json['user_from'];
    user = json['user'] != null ? SignupModel.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['id'] = id;
    data['slug'] = slug;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created'] = created;
    data['first_time_login'] = firstTimeLogin;
    data['messenger_color'] = messengerColor;
    data['modified'] = modified;
    data['completed'] = completed;
    data['user_from'] = userFrom;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}