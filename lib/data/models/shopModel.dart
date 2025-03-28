
class ShopModel{
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
  dynamic choices;
  dynamic serviceDate;
  dynamic offerd;
  String? type;
  dynamic specialDiscounts;
  String? workingHours;
  String? speakLanguage;
  String? amenities;
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
  String? twitter;
  String? qrCode;
  String? paymentPhoneNo;
  String? upiId;
  String? linkedin;
  String? youtube;
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
  String? normalEndDate;
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
  String? vehicleDrive;
  String? vehicleFuel;
  String? languageOfPosting;
  dynamic postfor;
  dynamic document;
  dynamic cryptoCurrency;
  dynamic zipcode;
  dynamic eventEndTime;
  dynamic stateName;
  dynamic cityName;
  String? productCondition;
  String? deliveryOption;
  dynamic pickup;
  String? shipping;
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
  int? odometerRolledOver;
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

  ShopModel({
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
    this.paymentLinks
});

  ShopModel.fromJson(Map<String, dynamic> json) {
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
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['available_now'] = this.availableNow;
    data['available_since'] = this.availableSince;
    data['location'] = this.location;
    data['fees'] = this.fees;
    data['bumpPost'] = this.bumpPost;
    data['featured_image'] = this.featuredImage;
    data['shares'] = this.shares;
    data['likes_btn'] = this.likesBtn;
    data['choices'] = this.choices;
    data['service_date'] = this.serviceDate;
    data['offerd'] = this.offerd;
    data['type'] = this.type;
    data['special_discounts'] = this.specialDiscounts;
    data['working_hours'] = this.workingHours;
    data['speak_language'] = this.speakLanguage;
    data['amenities'] = this.amenities;
    data['payment_preffer'] = this.paymentPreffer;
    data['currency_accept'] = this.currencyAccept;
    data['service_time'] = this.serviceTime;
    data['service_start_time'] = this.serviceStartTime;
    data['service_end_time'] = this.serviceEndTime;
    data['benifits'] = this.benifits;
    data['supplement'] = this.supplement;
    data['pay_by'] = this.payBy;
    data['post_type'] = this.postType;
    data['fixed_pay'] = this.fixedPay;
    data['min_pay'] = this.minPay;
    data['max_pay'] = this.maxPay;
    data['rate'] = this.rate;
    data['image1'] = this.image1;
    data['repost'] = this.repost;
    data['subscription_id'] = this.subscriptionId;
    data['job_type'] = this.jobType;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['website'] = this.website;
    data['address'] = this.address;
    data['twitter'] = this.twitter;
    data['qr_code'] = this.qrCode;
    data['payment_phone_no'] = this.paymentPhoneNo;
    data['upi_id'] = this.upiId;
    data['linkedin'] = this.linkedin;
    data['youtube'] = this.youtube;
    data['whatsapp'] = this.whatsapp;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['property_address'] = this.propertyAddress;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['units'] = this.units;
    data['bathroom'] = this.bathroom;
    data['bedroom'] = this.bedroom;
    data['grage'] = this.grage;
    data['year_built'] = this.yearBuilt;
    data['area_sq_ft'] = this.areaSqFt;
    data['sale_price'] = this.salePrice;
    data['price'] = this.price;
    data['featured_post'] = this.featuredPost;
    data['normal_post'] = this.normalPost;
    data['normal_end_date'] = this.normalEndDate;
    data['post_video'] = this.postVideo;
    data['post_by'] = this.postBy;
    data['personal_detail'] = this.personalDetail;
    data['meta_title'] = this.metaTitle;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_description'] = this.metaDescription;
    data['sub_category'] = this.subCategory;
    data['post_choices'] = this.postChoices;
    data['landSize'] = this.landSize;
    data['deleted_at'] = this.deletedAt;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['is_feature'] = this.isFeature;
    data['country_origin'] = this.countryOrigin;
    data['product_height'] = this.productHeight;
    data['product_width'] = this.productWidth;
    data['product_length'] = this.productLength;
    data['brand_name'] = this.brandName;
    data['additional_info'] = this.additionalInfo;
    data['product_size'] = this.productSize;
    data['stock'] = this.stock;
    data['product_price'] = this.productPrice;
    data['product_url'] = this.productUrl;
    data['price_option'] = this.priceOption;
    data['product_sale_price'] = this.productSalePrice;
    data['product_color'] = this.productColor;
    data['height_type'] = this.heightType;
    data['width_type'] = this.widthType;
    data['length_type'] = this.lengthType;
    data['vehicle_drive'] = this.vehicleDrive;
    data['vehicle_fuel'] = this.vehicleFuel;
    data['language_of_posting'] = this.languageOfPosting;
    data['postfor'] = this.postfor;
    data['document'] = this.document;
    data['crypto_currency'] = this.cryptoCurrency;
    data['zipcode'] = this.zipcode;
    data['event_end_time'] = this.eventEndTime;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    data['product_condition'] = this.productCondition;
    data['delivery_option'] = this.deliveryOption;
    data['pickup'] = this.pickup;
    data['shipping'] = this.shipping;
    data['saleOption'] = this.saleOption;
    data['bid'] = this.bid;
    data['buy_at_face_value'] = this.buyAtFaceValue;
    data['paying'] = this.paying;
    data['role_name'] = this.roleName;
    data['comment_option'] = this.commentOption;
    data['deadline'] = this.deadline;
    data['producer'] = this.producer;
    data['director'] = this.director;
    data['writer'] = this.writer;
    data['casting_director'] = this.castingDirector;
    data['audition_dates'] = this.auditionDates;
    data['publish_date'] = this.publishDate;
    data['amount'] = this.amount;
    data['draft'] = this.draft;
    data['bump_start'] = this.bumpStart;
    data['bump_end'] = this.bumpEnd;
    data['type_of_animal'] = this.typeOfAnimal;
    data['pet_name'] = this.petName;
    data['breed'] = this.breed;
    data['pet_color'] = this.petColor;
    data['pet_age'] = this.petAge;
    data['pet_gender'] = this.petGender;
    data['pet_size'] = this.petSize;
    data['vehicle_vin'] = this.vehicleVin;
    data['vehicle_model'] = this.vehicleModel;
    data['vehicle_odometer'] = this.vehicleOdometer;
    data['odometer_break'] = this.odometerBreak;
    data['odometer_rolled_over'] = this.odometerRolledOver;
    data['vehicle_condition'] = this.vehicleCondition;
    data['vehicle_cylinders'] = this.vehicleCylinders;
    data['vehicle_paint_color'] = this.vehiclePaintColor;
    data['vehicle_title_status'] = this.vehicleTitleStatus;
    data['vehicle_transmission'] = this.vehicleTransmission;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_model_year'] = this.vehicleModelYear;
    data['delivery_available'] = this.deliveryAvailable;
    data['more_links'] = this.moreLinks;
    data['coat'] = this.coat;
    data['adoption_fee'] = this.adoptionFee;
    data['health'] = this.health;
    data['house_trained'] = this.houseTrained;
    data['payment_links'] = this.paymentLinks;
    return data;
  }
}