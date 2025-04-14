
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PostsListModel{
  int? id;
  String? title;
  String? slug;
  int? availableNow;
  dynamic availableSince;
  String? location;
  dynamic fees;
  String? bumpPost;
  dynamic featuredImage;
  int? shares;
  String? likesBtn;
  String? userName;
  String? userImage;
  dynamic choices;
  dynamic serviceDate;
  dynamic offerd;
  String? type;
  dynamic specialDiscounts;
  dynamic workingHours;
  dynamic speakLanguage;
  dynamic amenities;
  dynamic paymentPreffer;
  dynamic currencyAccept;
  dynamic serviceTime;
  dynamic serviceStartTime;
  dynamic serviceEndTime;
  dynamic benifits;
  dynamic supplement;
  dynamic payBy;
  String? postType;
  dynamic fixedPay;
  dynamic minPay;
  dynamic maxPay;
  dynamic rate;
  String? image1;
  String? repost;
  String? subscriptionId;
  dynamic jobType;
  String? description;
  int? userId;
  dynamic phone;
  dynamic email;
  dynamic website;
  dynamic address;
  dynamic twitter;
  dynamic qrCode;
  dynamic paymentPhoneNo;
  dynamic upiId;
  dynamic linkedin;
  dynamic youtube;
  dynamic whatsapp;
  int? status;
  String? createdBy;
  dynamic propertyAddress;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic units;
  dynamic bathroom;
  dynamic bedroom;
  dynamic grage;
  dynamic yearBuilt;
  dynamic areaSqFt;
  dynamic salePrice;
  dynamic price;
  String? featuredPost;
  int? normalPost;
  dynamic normalEndDate;
  dynamic postVideo;
  String? postBy;
  dynamic personalDetail;
  dynamic metaTitle;
  dynamic metaKeywords;
  dynamic metaDescription;
  String? subCategory;
  dynamic postChoices;
  String? landSize;
  dynamic deletedAt;
  String? created;
  String? modified;
  String? isFeature;
  dynamic countryOrigin;
  dynamic productHeight;
  dynamic productWidth;
  dynamic productLength;
  dynamic brandName;
  dynamic additionalInfo;
  dynamic productSize;
  dynamic stock;
  dynamic productPrice;
  dynamic productUrl;
  dynamic priceOption;
  dynamic productSalePrice;
  dynamic productColor;
  dynamic heightType;
  dynamic widthType;
  dynamic lengthType;
  dynamic vehicleDrive;
  dynamic vehicleFuel;
  dynamic languageOfPosting;
  dynamic postfor;
  dynamic document;
  dynamic cryptoCurrency;
  dynamic zipcode;
  dynamic eventEndTime;
  dynamic stateName;
  dynamic cityName;
  dynamic productCondition;
  dynamic deliveryOption;
  dynamic pickup;
  dynamic shipping;
  dynamic saleOption;
  dynamic bid;
  dynamic bidRange;
  dynamic buyAtFaceValue;
  dynamic paying;
  dynamic roleName;
  int? commentOption;
  dynamic deadline;
  dynamic producer;
  dynamic director;
  dynamic writer;
  dynamic castingDirector;
  dynamic auditionDates;
  dynamic publishDate;
  dynamic amount;
  String? draft;
  dynamic bumpStart;
  dynamic bumpEnd;
  dynamic typeOfAnimal;
  dynamic petName;
  dynamic breed;
  dynamic petColor;
  dynamic petAge;
  dynamic petGender;
  dynamic petSize;
  dynamic vehicleVin;
  dynamic vehicleModel;
  dynamic vehicleOdometer;
  dynamic odometerBreak;
  dynamic odometerRolledOver;
  dynamic vehicleCondition;
  dynamic vehicleCylinders;
  dynamic vehiclePaintColor;
  dynamic vehicleTitleStatus;
  dynamic vehicleTransmission;
  dynamic vehicleType;
  dynamic vehicleModelYear;
  dynamic deliveryAvailable;
  dynamic moreLinks;
  dynamic coat;
  dynamic adoptionFee;
  dynamic health;
  dynamic houseTrained;
  dynamic paymentLinks;
  List<String>? imageList;
  List<String>? postList;

  PostsListModel({
    this.id,
    this.title,
    this.slug,
    this.availableNow,
    this.availableSince,
    this.location,
    this.fees,
    this.bumpPost,
    this.featuredImage,
    this.shares,
    this.likesBtn,
    this.userName,
    this.userImage,
    this.choices,
    this.serviceDate,
    this.offerd,
    this.type,
    this.specialDiscounts,
    this.workingHours,
    this.speakLanguage,
    this.amenities,
    this.paymentPreffer,
    this.currencyAccept,
    this.serviceTime,
    this.serviceStartTime,
    this.serviceEndTime,
    this.benifits,
    this.supplement,
    this.payBy,
    this.postType,
    this.fixedPay,
    this.minPay,
    this.maxPay,
    this.rate,
    this.image1,
    this.repost,
    this.subscriptionId,
    this.jobType,
    this.description,
    this.userId,
    this.phone,
    this.email,
    this.website,
    this.address,
    this.twitter,
    this.qrCode,
    this.paymentPhoneNo,
    this.upiId,
    this.linkedin,
    this.youtube,
    this.whatsapp,
    this.status,
    this.createdBy,
    this.propertyAddress,
    this.country,
    this.state,
    this.city,
    this.units,
    this.bathroom,
    this.bedroom,
    this.grage,
    this.yearBuilt,
    this.areaSqFt,
    this.salePrice,
    this.price,
    this.featuredPost,
    this.normalPost,
    this.normalEndDate,
    this.postVideo,
    this.postBy,
    this.personalDetail,
    this.metaTitle,
    this.metaKeywords,
    this.metaDescription,
    this.subCategory,
    this.postChoices,
    this.landSize,
    this.deletedAt,
    this.created,
    this.modified,
    this.isFeature,
    this.countryOrigin,
    this.productHeight,
    this.productWidth,
    this.productLength,
    this.brandName,
    this.additionalInfo,
    this.productSize,
    this.stock,
    this.productPrice,
    this.productUrl,
    this.priceOption,
    this.productSalePrice,
    this.productColor,
    this.heightType,
    this.widthType,
    this.lengthType,
    this.vehicleDrive,
    this.vehicleFuel,
    this.languageOfPosting,
    this.postfor,
    this.document,
    this.cryptoCurrency,
    this.zipcode,
    this.eventEndTime,
    this.stateName,
    this.cityName,
    this.productCondition,
    this.deliveryOption,
    this.pickup,
    this.shipping,
    this.saleOption,
    this.bid,
    this.bidRange,
    this.buyAtFaceValue,
    this.paying,
    this.roleName,
    this.commentOption,
    this.deadline,
    this.producer,
    this.director,
    this.writer,
    this.castingDirector,
    this.auditionDates,
    this.publishDate,
    this.amount,
    this.draft,
    this.bumpStart,
    this.bumpEnd,
    this.typeOfAnimal,
    this.petName,
    this.breed,
    this.petColor,
    this.petAge,
    this.petGender,
    this.petSize,
    this.vehicleVin,
    this.vehicleModel,
    this.vehicleOdometer,
    this.odometerBreak,
    this.odometerRolledOver,
    this.vehicleCondition,
    this.vehicleCylinders,
    this.vehiclePaintColor,
    this.vehicleTitleStatus,
    this.vehicleTransmission,
    this.vehicleType,
    this.vehicleModelYear,
    this.deliveryAvailable,
    this.moreLinks,
    this.coat,
    this.adoptionFee,
    this.health,
    this.houseTrained,
    this.paymentLinks,
    this.imageList,
    this.postList
  });


  PostsListModel.fromJson(Map<String, dynamic>json){
    List<String> decodedImages = [];
    if (json['image1'] != null && json['image1'] is String) {
      decodedImages = List<String>.from(jsonDecode(json['image1']));
    }
    List<String> decodedPosts = [];
    if (json['post_video'] != null && json['post_video'] is String) {
      decodedImages = List<String>.from(jsonDecode(json['post_video']));
    }
    imageList = decodedImages;
    postList = decodedPosts;
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    availableNow = json['available_now'];
    availableSince = json['available_since'];
    location = json['location'];
    fees = json['fees'];
    bumpPost = json['bumpPost'];
    featuredImage = json['featured_image'];
    shares = json['shares'];
    likesBtn = json['likes_btn'];
    userName = json['user_name'];
    userImage = json['user_image'];
    choices = json['choices'];
    serviceDate = json['service_date'];
    offerd = json['offerd'];
    type = json['type'];
    specialDiscounts = json['special_discounts'];
    workingHours = json['working_hours'];
    speakLanguage = json['speak_language'];
    amenities = json['amenities'];
    paymentPreffer = json['payment_preffer'];
    currencyAccept = json['currency_accept'];
    serviceTime = json['service_time'];
    serviceStartTime = json['service_start_time'];
    serviceEndTime = json['service_end_time'];
    benifits = json['benifits'];
    supplement = json['supplement'];
    payBy = json['pay_by'];
    postType = json['post_type'];
    fixedPay = json['fixed_pay'];
    minPay = json['min_pay'];
    maxPay = json['max_pay'];
    rate = json['rate'];
    image1 = json['image1'];
    repost = json['repost'];
    subscriptionId = json['subscription_id'];
    jobType = json['job_type'];
    description = json['description'];
    userId = json['user_id'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    address = json['address'];
    twitter = json['twitter'];
    qrCode = json['qr_code'];
    paymentPhoneNo = json['payment_phone_no'];
    upiId = json['upi_id'];
    linkedin = json['linkedin'];
    youtube = json['youtube'];
    whatsapp = json['whatsapp'];
    status = json['status'];
    createdBy = json['created_by'];
    propertyAddress = json['property_address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    units = json['units'];
    bathroom = json['bathroom'];
    bedroom = json['bedroom'];
    grage = json['grage'];
    yearBuilt = json['year_built'];
    areaSqFt = json['area_sq_ft'];
    salePrice = json['sale_price'];
    price = json['price'];
    featuredPost = json['featured_post'];
    normalPost = json['normal_post'];
    normalEndDate = json['normal_end_date'];
    postVideo = json['post_video'];
    postBy = json['post_by'];
    personalDetail = json['personal_detail'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    subCategory = json['sub_category'];
    postChoices = json['post_choices'];
    landSize = json['landSize'];
    deletedAt = json['deleted_at'];
    created = json['created'];
    modified = json['modified'];
    isFeature = json['is_feature'];
    countryOrigin = json['country_origin'];
    productHeight = json['product_height'];
    productWidth = json['product_width'];
    productLength = json['product_length'];
    brandName = json['brand_name'];
    additionalInfo = json['additional_info'];
    productSize = json['product_size'];
    stock = json['stock'];
    productPrice = json['product_price'];
    productUrl = json['product_url'];
    priceOption = json['price_option'];
    productSalePrice = json['product_sale_price'];
    productColor = json['product_color'];
    heightType = json['height_type'];
    widthType = json['width_type'];
    lengthType = json['length_type'];
    vehicleDrive = json['vehicle_drive'];
    vehicleFuel = json['vehicle_fuel'];
    languageOfPosting = json['language_of_posting'];
    postfor = json['postfor'];
    document = json['document'];
    cryptoCurrency = json['crypto_currency'];
    zipcode = json['zipcode'];
    eventEndTime = json['event_end_time'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    productCondition = json['product_condition'];
    deliveryOption = json['delivery_option'];
    pickup = json['pickup'];
    shipping = json['shipping'];
    saleOption = json['saleOption'];
    bid = json['bid'];
    bidRange = json['bid_range'];
    buyAtFaceValue = json['buy_at_face_value'];
    paying = json['paying'];
    roleName = json['role_name'];
    commentOption = json['comment_option'];
    deadline = json['deadline'];
    producer = json['producer'];
    director = json['director'];
    writer = json['writer'];
    castingDirector = json['casting_director'];
    auditionDates = json['audition_dates'];
    publishDate = json['publish_date'];
    amount = json['amount'];
    draft = json['draft'];
    bumpStart = json['bump_start'];
    bumpEnd = json['bump_end'];
    typeOfAnimal = json['type_of_animal'];
    petName = json['pet_name'];
    breed = json['breed'];
    petColor = json['pet_color'];
    petAge = json['pet_age'];
    petGender = json['pet_gender'];
    petSize = json['pet_size'];
    vehicleVin = json['vehicle_vin'];
    vehicleModel = json['vehicle_model'];
    vehicleOdometer = json['vehicle_odometer'];
    odometerBreak = json['odometer_break'];
    odometerRolledOver = json['odometer_rolled_over'];
    vehicleCondition = json['vehicle_condition'];
    vehicleCylinders = json['vehicle_cylinders'];
    vehiclePaintColor = json['vehicle_paint_color'];
    vehicleTitleStatus = json['vehicle_title_status'];
    vehicleTransmission = json['vehicle_transmission'];
    vehicleType = json['vehicle_type'];
    vehicleModelYear = json['vehicle_model_year'];
    deliveryAvailable = json['delivery_available'];
    moreLinks = json['more_links'];
    coat = json['coat'];
    adoptionFee = json['adoption_fee'];
    health = json['health'];
    houseTrained = json['house_trained'];
    paymentLinks = json['payment_links'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    void writeNotNull(String key, dynamic value) {
      if (value != null && value
          .toString()
          .isNotEmpty) {
        data[key] = value;
      }
    }
    writeNotNull('id', id);
    writeNotNull('title', title);
    writeNotNull('slug', slug);
    writeNotNull('location', location);
    writeNotNull('user_id', userId);
    writeNotNull('image1', image1);
    writeNotNull('user_name', userName);
    writeNotNull('user_image', userImage);
    writeNotNull('type', type);
    writeNotNull('description', description);
    writeNotNull('sub_category', subCategory);
    writeNotNull('post_video', postVideo);
    writeNotNull('created_by', createdBy);
    writeNotNull('post_type', postType);
    writeNotNull('draft', draft);
    writeNotNull('created', created);
    writeNotNull('modified', modified);
    writeNotNull('comment_option', commentOption);
    writeNotNull('shares', shares);
    writeNotNull('likes_btn', likesBtn);
    writeNotNull('status', status);
    return data;
  }
}