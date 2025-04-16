
import 'dart:io';

class VideoUploadModel {
  String? title;
  String? slug;
  int? userId;
  String? postVideo;
  String? image1;
  String? location;
  String? subCategory;
  String? caption;
  String? categories;
  String? description;
  int? shares;
  int? commentOption;
  String? likesBtn;
  String? donationLink;
  String? type;
  String? createdBy;
  String? postType;
  int? status;
  int? draft;
  String? created;
  String? modified;
  int? id;
  VideoUploadModel? post;
  List<File>? selectedFiles;

  VideoUploadModel({
    this.title,
    this.slug,
    this.userId,
    this.postVideo,
    this.image1,
    this.location,
    this.subCategory,
    this.caption,
    this.categories,
    this.description,
    this.shares,
    this.donationLink,
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
    this.post,
    this.selectedFiles
  });
  VideoUploadModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    userId = json['user_id'] is int ? json['user_id'] : int.tryParse(json['user_id']?.toString() ?? '');
    location = json['location'];
    subCategory = json['subCategory'];
    caption = json['caption'];
    categories = json['categories'];
    description = json['description'];
    shares = json['shares'];
    donationLink = json['donation_link'];
    commentOption = json['comment_option'];
    likesBtn = json['likes_btn'];
    type = json['type'];
    createdBy = json['createdBy'];
    postType = json['postType'];
    status = json['status'];
    draft = json['draft'];
    created = json['created'];
    modified = json['modified'];
    id = json['id'];
    postVideo = json['post_video'];
    image1 = json['image1'];
    post = json['post'] != null ? VideoUploadModel.fromJson(json['post']) : null;
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
    writeNotNull('caption', caption);
    writeNotNull('categories', categories);
    writeNotNull('description', description);
    writeNotNull('shares', shares);
    writeNotNull('commentOption', commentOption);
    writeNotNull('likesBtn', likesBtn);
    writeNotNull('type', type);
    writeNotNull('donation_link', donationLink);
    writeNotNull('createdBy', createdBy);
    writeNotNull('postType', postType);
    writeNotNull('status', status);
    writeNotNull('draft', draft);
    writeNotNull('created', created);
    writeNotNull('modified', modified);
    writeNotNull('post_video', postVideo);
    writeNotNull('image1', image1);
    writeNotNull('id', id);
    writeNotNull('post', post?.toJson());
    return data;
  }
}
