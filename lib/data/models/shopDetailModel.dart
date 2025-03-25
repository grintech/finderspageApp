class ShopDetailModel {
  Blog? blog;
  List<RelatedProducts>? relatedProducts;
  List<ShopDetailModel>? questions;
  List<ShopDetailModel>? answers;
  List<ShopDetailModel>? reviews;
  List<Likes>? likes;
  bool? saved;
  int? viewsCount;
  String? previousPostSlug;
  String? nextPostSlug;
  OgMeta? ogMeta;

  ShopDetailModel(
      {this.blog,
        this.relatedProducts,
        this.questions,
        this.answers,
        this.reviews,
        this.likes,
        this.saved,
        this.viewsCount,
        this.previousPostSlug,
        this.nextPostSlug,
        this.ogMeta});

  ShopDetailModel.fromJson(Map<String, dynamic> json) {
    blog = json['blog'] != null ? new Blog.fromJson(json['blog']) : null;
    if (json['related_products'] != null) {
      relatedProducts = <RelatedProducts>[];
      json['related_products'].forEach((v) {
        relatedProducts!.add(new RelatedProducts.fromJson(v));
      });
    }
    if (json['questions'] != null) {
      questions = <ShopDetailModel>[];
      json['questions'].forEach((v) {
        questions!.add(new ShopDetailModel.fromJson(v));
      });
    }
    if (json['answers'] != null) {
      answers = <ShopDetailModel>[];
      json['answers'].forEach((v) {
        answers!.add(new ShopDetailModel.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <ShopDetailModel>[];
      json['reviews'].forEach((v) {
        reviews!.add(new ShopDetailModel.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
    saved = json['saved'];
    viewsCount = json['views_count'];
    previousPostSlug = json['previous_post_slug'];
    nextPostSlug = json['next_post_slug'];
    ogMeta =
    json['og_meta'] != null ? new OgMeta.fromJson(json['og_meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (blog != null) {
      data['blog'] = blog!.toJson();
    }
    if (relatedProducts != null) {
      data['related_products'] =
          relatedProducts!.map((v) => v.toJson()).toList();
    }
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    data['saved'] = saved;
    data['views_count'] = viewsCount;
    data['previous_post_slug'] = previousPostSlug;
    data['next_post_slug'] = nextPostSlug;
    if (ogMeta != null) {
      data['og_meta'] = ogMeta!.toJson();
    }
    return data;
  }
}

class Blog {
  int? id;
  String? title;
  String? slug;
  int? availableNow;
  dynamic availableSince;
  String? location;
  dynamic fees;
  String? bumpPost;
  dynamic featuredImage;
  dynamic shares;
  String? likesBtn;
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
  String? phone;
  String? email;
  String? website;
  String? address;
  dynamic twitter;
  dynamic qrCode;
  dynamic paymentPhoneNo;
  dynamic upiId;
  dynamic linkedin;
  dynamic youtube;
  String? whatsapp;
  int? status;
  dynamic createdBy;
  dynamic propertyAddress;
  String? country;
  String? state;
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
  String? personalDetail;
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
  String? brandName;
  dynamic additionalInfo;
  String? productSize;
  dynamic stock;
  String? productPrice;
  String? productUrl;
  dynamic priceOption;
  String? productSalePrice;
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
  String? productCondition;
  dynamic deliveryOption;
  dynamic pickup;
  dynamic shipping;
  String? saleOption;
  dynamic bid;
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
  String? typeOfAnimal;
  String? petName;
  String? breed;
  String? petColor;
  int? petAge;
  String? petGender;
  int? petSize;
  String? vehicleVin;
  String? vehicleModel;
  int? vehicleOdometer;
  dynamic odometerBreak;
  dynamic odometerRolledOver;
  String? vehicleCondition;
  String? vehicleCylinders;
  String? vehiclePaintColor;
  String? vehicleTitleStatus;
  String? vehicleTransmission;
  String? vehicleType;
  int? vehicleModelYear;
  dynamic deliveryAvailable;
  dynamic moreLinks;
  String? coat;
  int? adoptionFee;
  String? health;
  String? houseTrained;
  dynamic paymentLinks;

  Blog(
      {this.id,
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
        this.paymentLinks});

  Blog.fromJson(Map<String, dynamic> json) {
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
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['available_now'] = availableNow;
    data['available_since'] = availableSince;
    data['location'] = location;
    data['fees'] = fees;
    data['bumpPost'] = bumpPost;
    data['featured_image'] = featuredImage;
    data['shares'] = shares;
    data['likes_btn'] = likesBtn;
    data['choices'] = choices;
    data['service_date'] = serviceDate;
    data['offerd'] = offerd;
    data['type'] = type;
    data['special_discounts'] = specialDiscounts;
    data['working_hours'] = workingHours;
    data['speak_language'] = speakLanguage;
    data['amenities'] = amenities;
    data['payment_preffer'] = paymentPreffer;
    data['currency_accept'] = currencyAccept;
    data['service_time'] = serviceTime;
    data['service_start_time'] = serviceStartTime;
    data['service_end_time'] = serviceEndTime;
    data['benifits'] = benifits;
    data['supplement'] = supplement;
    data['pay_by'] = payBy;
    data['post_type'] = postType;
    data['fixed_pay'] = fixedPay;
    data['min_pay'] = minPay;
    data['max_pay'] = maxPay;
    data['rate'] = rate;
    data['image1'] = image1;
    data['repost'] = repost;
    data['subscription_id'] = subscriptionId;
    data['job_type'] = jobType;
    data['description'] = description;
    data['user_id'] = userId;
    data['phone'] = phone;
    data['email'] = email;
    data['website'] = website;
    data['address'] = address;
    data['twitter'] = twitter;
    data['qr_code'] = qrCode;
    data['payment_phone_no'] = paymentPhoneNo;
    data['upi_id'] = upiId;
    data['linkedin'] = linkedin;
    data['youtube'] = youtube;
    data['whatsapp'] = whatsapp;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['property_address'] = propertyAddress;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['units'] = units;
    data['bathroom'] = bathroom;
    data['bedroom'] = bedroom;
    data['grage'] = grage;
    data['year_built'] = yearBuilt;
    data['area_sq_ft'] = areaSqFt;
    data['sale_price'] = salePrice;
    data['price'] = price;
    data['featured_post'] = featuredPost;
    data['normal_post'] = normalPost;
    data['normal_end_date'] = normalEndDate;
    data['post_video'] = postVideo;
    data['post_by'] = postBy;
    data['personal_detail'] = personalDetail;
    data['meta_title'] = metaTitle;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['sub_category'] = subCategory;
    data['post_choices'] = postChoices;
    data['landSize'] = landSize;
    data['deleted_at'] = deletedAt;
    data['created'] = created;
    data['modified'] = modified;
    data['is_feature'] = isFeature;
    data['country_origin'] = countryOrigin;
    data['product_height'] = productHeight;
    data['product_width'] = productWidth;
    data['product_length'] = productLength;
    data['brand_name'] = brandName;
    data['additional_info'] = additionalInfo;
    data['product_size'] = productSize;
    data['stock'] = stock;
    data['product_price'] = productPrice;
    data['product_url'] = productUrl;
    data['price_option'] = priceOption;
    data['product_sale_price'] = productSalePrice;
    data['product_color'] = productColor;
    data['height_type'] = heightType;
    data['width_type'] = widthType;
    data['length_type'] = lengthType;
    data['vehicle_drive'] = vehicleDrive;
    data['vehicle_fuel'] = vehicleFuel;
    data['language_of_posting'] = languageOfPosting;
    data['postfor'] = postfor;
    data['document'] = document;
    data['crypto_currency'] = cryptoCurrency;
    data['zipcode'] = zipcode;
    data['event_end_time'] = eventEndTime;
    data['state_name'] = stateName;
    data['city_name'] = cityName;
    data['product_condition'] = productCondition;
    data['delivery_option'] = deliveryOption;
    data['pickup'] = pickup;
    data['shipping'] = shipping;
    data['saleOption'] = saleOption;
    data['bid'] = bid;
    data['buy_at_face_value'] = buyAtFaceValue;
    data['paying'] = paying;
    data['role_name'] = roleName;
    data['comment_option'] = commentOption;
    data['deadline'] = deadline;
    data['producer'] = producer;
    data['director'] = director;
    data['writer'] = writer;
    data['casting_director'] = castingDirector;
    data['audition_dates'] = auditionDates;
    data['publish_date'] = publishDate;
    data['amount'] = amount;
    data['draft'] = draft;
    data['bump_start'] = bumpStart;
    data['bump_end'] = bumpEnd;
    data['type_of_animal'] = typeOfAnimal;
    data['pet_name'] = petName;
    data['breed'] = breed;
    data['pet_color'] = petColor;
    data['pet_age'] = petAge;
    data['pet_gender'] = petGender;
    data['pet_size'] = petSize;
    data['vehicle_vin'] = vehicleVin;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_odometer'] = vehicleOdometer;
    data['odometer_break'] = odometerBreak;
    data['odometer_rolled_over'] = odometerRolledOver;
    data['vehicle_condition'] = vehicleCondition;
    data['vehicle_cylinders'] = vehicleCylinders;
    data['vehicle_paint_color'] = vehiclePaintColor;
    data['vehicle_title_status'] = vehicleTitleStatus;
    data['vehicle_transmission'] = vehicleTransmission;
    data['vehicle_type'] = vehicleType;
    data['vehicle_model_year'] = vehicleModelYear;
    data['delivery_available'] = deliveryAvailable;
    data['more_links'] = moreLinks;
    data['coat'] = coat;
    data['adoption_fee'] = adoptionFee;
    data['health'] = health;
    data['house_trained'] = houseTrained;
    data['payment_links'] = paymentLinks;
    return data;
  }
}

class RelatedProducts {
  int? id;
  String? title;
  String? slug;
  String? image1;

  RelatedProducts({this.id, this.title, this.slug, this.image1});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    image1 = json['image1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['image1'] = image1;
    return data;
  }
}

class Likes {
  int? id;
  String? blogId;
  String? blogUserId;
  String? type;
  int? cateId;
  String? likes;
  String? likedBy;
  String? createdAt;
  String? updatedAt;

  Likes(
      {this.id,
        this.blogId,
        this.blogUserId,
        this.type,
        this.cateId,
        this.likes,
        this.likedBy,
        this.createdAt,
        this.updatedAt});

  Likes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blogId = json['blog_id'];
    blogUserId = json['blog_user_id'];
    type = json['type'];
    cateId = json['cate_id'];
    likes = json['likes'];
    likedBy = json['liked_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['blog_id'] = blogId;
    data['blog_user_id'] = blogUserId;
    data['type'] = type;
    data['cate_id'] = cateId;
    data['likes'] = likes;
    data['liked_by'] = likedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class OgMeta {
  String? title;
  String? description;
  String? image;

  OgMeta({this.title, this.description, this.image});

  OgMeta.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}