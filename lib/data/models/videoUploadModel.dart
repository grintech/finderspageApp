
class VideoUploadModel {
  String? title;
  String? slug;
  String? userId;
  List<String>? postVideo;
  List<String>? image1;
  String? location;
  String? subCategory;
  String? description;
  int? shares;
  int? commentOption;
  String? likesBtn;
  String? type;
  String? createdBy;
  String? postType;
  int? status;
  int? draft;
  String? created;
  String? modified;
  int? id;

  VideoUploadModel({
    this.title,
    this.slug,
    this.userId,
    this.postVideo,
    this.image1,
    this.location,
    this.subCategory,
    this.description,
    this.shares,
    this.commentOption,
    this.likesBtn,
    this.type,
    this.createdBy,
    this.postType,
    this.status,
    this.draft,
    this.created,
    this.modified,
    this.id,
  });
  VideoUploadModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    userId = json['userId'];
    location = json['location'];
    subCategory = json['subCategory'];
    description = json['description'];
    shares = json['shares'];
    commentOption = json['commentOption'];
    likesBtn = json['likesBtn'];
    type = json['type'];
    createdBy = json['createdBy'];
    postType = json['postType'];
    status = json['status'];
    draft = json['draft'];
    created = json['created'];
    modified = json['modified'];
    id = json['user_id'];
    postVideo = (json['post_video[]'] as List?)?.map((e) => e as String).toList();
    image1 = (json['image1[]'] as List?)?.map((e) => e as String).toList();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        data[key] = value;
      }
    }
    writeNotNull('title', title);
    writeNotNull('slug', slug);
    writeNotNull('user_id', userId);
    writeNotNull('location', location);
    writeNotNull('subCategory', subCategory);
    writeNotNull('description', description);
    writeNotNull('shares', shares);
    writeNotNull('commentOption', commentOption);
    writeNotNull('likesBtn', likesBtn);
    writeNotNull('type', type);
    writeNotNull('createdBy', createdBy);
    writeNotNull('postType', postType);
    writeNotNull('status', status);
    writeNotNull('draft', draft);
    writeNotNull('created', created);
    writeNotNull('modified', modified);
    writeNotNull('post_video', postVideo);
    writeNotNull('image1', image1);
    writeNotNull('user_id', id);
    return data;
  }
}
