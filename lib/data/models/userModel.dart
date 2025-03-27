class UserModel{
  int? id;
  String? role;
  dynamic roleCategory;
  int? completed;
  String? firstName;
  String? slug;
  dynamic lastName;
  String? phonenumber;
  String? tagAt;
  String? profession;
  dynamic profileView;
  dynamic sessionId;
  String? dob;
  String? address;
  String? image;
  dynamic s3Image;
  dynamic s3Coverimg;
  String? zodiacImage;
  String? zodiacName;
  String? coverImg;
  String? profilePercent;
  String? bio;
  dynamic country;
  dynamic state;
  dynamic city;
  String? lastLogin;
  String? token;
  dynamic gender;
  String? email;
  dynamic profileEmail;
  String? username;
  dynamic accountType;
  String? password;
  int? status;
  String? verifiedAt;
  String? isVerified;
  dynamic facebookId;
  dynamic googleId;
  dynamic googleEmail;
  String? otp;
  String? isfeaturedUser;
  dynamic featureStartDate;
  dynamic featureEndDate;
  String? isbumpPost;
  dynamic subscribedPlan;
  dynamic bumpPostStartDate;
  dynamic bumpPostEndDate;
  String? zipcode;
  dynamic businessName;
  dynamic businessEmail;
  dynamic businessPhone;
  String? websiteTitle;
  String? businessWebsite;
  dynamic businessAddress;
  dynamic businessImages;
  dynamic businessVideo;
  dynamic businessBtnname;
  dynamic businessBtnurl;
  String? facebook;
  String? twitter;
  String? instagram;
  String? linkedin;
  dynamic whatsapp;
  String? youtube;
  String? tiktok;
  int? firstTimeLogin;
  dynamic deletedAt;
  dynamic createdBy;
  String? created;
  String? modified;
  dynamic allBusiness;
  dynamic wheelchair;
  dynamic blackOwned;
  dynamic latinxOwned;
  dynamic womenOwned;
  dynamic asianOwned;
  dynamic lgbtqOwned;
  dynamic veteranOwned;
  dynamic bikeParking;
  dynamic evCharging;
  dynamic plasticFree;
  dynamic vaccinationRequired;
  dynamic fullyVaccinated;
  dynamic masksRequired;
  dynamic staffWearsMasks;
  dynamic androidPay;
  dynamic applePay;
  dynamic creditCard;
  dynamic cryptocurrency;
  dynamic waitlistReservations;
  dynamic onlineOrdering;
  dynamic dogsAllowed;
  dynamic military;
  dynamic flowerDelivery;
  String? inSiteRegister;
  dynamic socialLoginId;
  int? dND;
  int? activeStatus;
  dynamic avatar;
  String? updatedAt;
  int? darkMode;
  String? messengerColor;
  String? gRecaptchaResponse;
  dynamic paymentType;
  dynamic customerId;
  int? cancelAt;
  dynamic featuredPostCount;
  String? bumpPostCount;
  String? paidPostCount;
  dynamic slideshowLimit;
  dynamic paypalOrderID;
  String? descSubscription;
  dynamic descSubscriptionPlan;
  dynamic descStartDate;
  dynamic descEndDate;
  dynamic paypalSubscriptionID;
  int? review;
  String? freeBump;
  int? freeListing;
  String? userFrom;

  UserModel({this.id,
        this.role,
        this.roleCategory,
        this.completed,
        this.firstName,
        this.slug,
        this.lastName,
        this.phonenumber,
        this.tagAt,
        this.profession,
        this.profileView,
        this.sessionId,
        this.dob,
        this.address,
        this.image,
        this.s3Image,
        this.s3Coverimg,
        this.zodiacImage,
        this.zodiacName,
        this.coverImg,
        this.profilePercent,
        this.bio,
        this.country,
        this.state,
        this.city,
        this.lastLogin,
        this.token,
        this.gender,
        this.email,
        this.profileEmail,
        this.username,
        this.accountType,
        this.status,
        this.password,
        this.verifiedAt,
        this.isVerified,
        this.facebookId,
        this.googleId,
        this.googleEmail,
        this.otp,
        this.isfeaturedUser,
        this.featureStartDate,
        this.featureEndDate,
        this.isbumpPost,
        this.subscribedPlan,
        this.bumpPostStartDate,
        this.bumpPostEndDate,
        this.zipcode,
        this.businessName,
        this.businessEmail,
        this.businessPhone,
        this.websiteTitle,
        this.businessWebsite,
        this.businessAddress,
        this.businessImages,
        this.businessVideo,
        this.businessBtnname,
        this.businessBtnurl,
        this.facebook,
        this.twitter,
        this.instagram,
        this.linkedin,
        this.whatsapp,
        this.youtube,
        this.tiktok,
        this.firstTimeLogin,
        this.deletedAt,
        this.createdBy,
        this.created,
        this.modified,
        this.allBusiness,
        this.wheelchair,
        this.blackOwned,
        this.latinxOwned,
        this.womenOwned,
        this.asianOwned,
        this.lgbtqOwned,
        this.veteranOwned,
        this.bikeParking,
        this.evCharging,
        this.plasticFree,
        this.vaccinationRequired,
        this.fullyVaccinated,
        this.masksRequired,
        this.staffWearsMasks,
        this.androidPay,
        this.applePay,
        this.creditCard,
        this.cryptocurrency,
        this.waitlistReservations,
        this.onlineOrdering,
        this.dogsAllowed,
        this.military,
        this.flowerDelivery,
        this.inSiteRegister,
        this.socialLoginId,
        this.dND,
        this.activeStatus,
        this.avatar,
        this.updatedAt,
        this.darkMode,
        this.messengerColor,
        this.gRecaptchaResponse,
        this.paymentType,
        this.customerId,
        this.cancelAt,
        this.featuredPostCount,
        this.bumpPostCount,
        this.paidPostCount,
        this.slideshowLimit,
        this.paypalOrderID,
        this.descSubscription,
        this.descSubscriptionPlan,
        this.descStartDate,
        this.descEndDate,
        this.paypalSubscriptionID,
        this.review,
        this.freeBump,
        this.freeListing,
        this.userFrom});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    roleCategory = json['role_category'];
    completed = json['completed'];
    firstName = json['first_name'];
    slug = json['slug'];
    lastName = json['last_name'];
    phonenumber = json['phonenumber'];
    tagAt = json['tag_at'];
    profession = json['profession'];
    profileView = json['profile_view'];
    sessionId = json['session_id'];
    dob = json['dob'];
    address = json['address'];
    image = json['image'];
    s3Image = json['s3_image'];
    s3Coverimg = json['s3_coverimg'];
    zodiacImage = json['Zodiac_image'];
    zodiacName = json['zodiac_name'];
    coverImg = json['cover_img'];
    profilePercent = json['profile_percent'];
    bio = json['bio'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    lastLogin = json['last_login'];
    token = json['token'];
    gender = json['gender'];
    email = json['email'];
    profileEmail = json['profile_email'];
    username = json['username'];
    accountType = json['account_type'];
    status = json['status'];
    password = json['password'];
    verifiedAt = json['verified_at'];
    isVerified = json['is_verified'];
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
    googleEmail = json['google_email'];
    otp = json['otp'];
    isfeaturedUser = json['isfeatured_user'];
    featureStartDate = json['feature_start_date'];
    featureEndDate = json['feature_end_date'];
    isbumpPost = json['isbump_post'];
    subscribedPlan = json['subscribedPlan'];
    bumpPostStartDate = json['bumpPost_start_date'];
    bumpPostEndDate = json['bumpPost_end_date'];
    zipcode = json['zipcode'];
    businessName = json['business_name'];
    businessEmail = json['business_email'];
    businessPhone = json['business_phone'];
    websiteTitle = json['website_title'];
    businessWebsite = json['business_website'];
    businessAddress = json['business_address'];
    businessImages = json['business_images'];
    businessVideo = json['business_video'];
    businessBtnname = json['business_btnname'];
    businessBtnurl = json['business_btnurl'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    linkedin = json['linkedin'];
    whatsapp = json['whatsapp'];
    youtube = json['youtube'];
    tiktok = json['Tiktok'];
    firstTimeLogin = json['first_time_login'];
    deletedAt = json['deleted_at'];
    createdBy = json['created_by'];
    created = json['created'];
    modified = json['modified'];
    allBusiness = json['all_business'];
    wheelchair = json['wheelchair'];
    blackOwned = json['black_owned'];
    latinxOwned = json['latinx_owned'];
    womenOwned = json['women_owned'];
    asianOwned = json['asian_owned'];
    lgbtqOwned = json['lgbtq_owned'];
    veteranOwned = json['veteran_owned'];
    bikeParking = json['bike_parking'];
    evCharging = json['ev_charging'];
    plasticFree = json['plastic_free'];
    vaccinationRequired = json['vaccination_required'];
    fullyVaccinated = json['fully_vaccinated'];
    masksRequired = json['masks_required'];
    staffWearsMasks = json['staff_wears_masks'];
    androidPay = json['android_pay'];
    applePay = json['apple_pay'];
    creditCard = json['credit_card'];
    cryptocurrency = json['cryptocurrency'];
    waitlistReservations = json['waitlist_reservations'];
    onlineOrdering = json['online_ordering'];
    dogsAllowed = json['dogs_allowed'];
    military = json['military'];
    flowerDelivery = json['flower_delivery'];
    inSiteRegister = json['in_site_register'];
    socialLoginId = json['social_loginId'];
    dND = json['DND'];
    activeStatus = json['active_status'];
    avatar = json['avatar'];
    updatedAt = json['updated_at'];
    darkMode = json['dark_mode'];
    messengerColor = json['messenger_color'];
    gRecaptchaResponse = json['g-recaptcha-response'];
    paymentType = json['payment_type'];
    customerId = json['customer_id'];
    cancelAt = json['cancel_at'];
    featuredPostCount = json['featured_post_count'];
    bumpPostCount = json['bump_post_count'];
    paidPostCount = json['paid_post_count'];
    slideshowLimit = json['slideshow_limit'];
    paypalOrderID = json['paypal_orderID'];
    descSubscription = json['desc_subscription'];
    descSubscriptionPlan = json['desc_subscription_plan'];
    descStartDate = json['desc_start_date'];
    descEndDate = json['desc_end_date'];
    paypalSubscriptionID = json['paypal_subscriptionID'];
    review = json['review'];
    freeBump = json['free_bump'];
    freeListing = json['free_listing'];
    userFrom = json['user_from'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['role'] = role;
    data['role_category'] = roleCategory;
    data['completed'] = completed;
    data['first_name'] = firstName;
    data['slug'] = slug;
    data['last_name'] = lastName;
    data['phonenumber'] = phonenumber;
    data['tag_at'] = tagAt;
    data['profession'] = profession;
    data['profile_view'] = profileView;
    data['session_id'] = sessionId;
    data['dob'] = dob;
    data['address'] = address;
    data['image'] = image;
    data['s3_image'] = s3Image;
    data['s3_coverimg'] = s3Coverimg;
    data['Zodiac_image'] = zodiacImage;
    data['zodiac_name'] = zodiacName;
    data['cover_img'] = coverImg;
    data['profile_percent'] = profilePercent;
    data['bio'] = bio;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['last_login'] = lastLogin;
    data['token'] = token;
    data['gender'] = gender;
    data['email'] = email;
    data['profile_email'] = profileEmail;
    data['username'] = username;
    data['account_type'] = accountType;
    data['status'] = status;
    data['password'] = password;
    data['verified_at'] = verifiedAt;
    data['is_verified'] = isVerified;
    data['facebook_id'] = facebookId;
    data['google_id'] = googleId;
    data['google_email'] = googleEmail;
    data['otp'] = otp;
    data['isfeatured_user'] = isfeaturedUser;
    data['feature_start_date'] = featureStartDate;
    data['feature_end_date'] = featureEndDate;
    data['isbump_post'] = isbumpPost;
    data['subscribedPlan'] = subscribedPlan;
    data['bumpPost_start_date'] = bumpPostStartDate;
    data['bumpPost_end_date'] = bumpPostEndDate;
    data['zipcode'] = zipcode;
    data['business_name'] = businessName;
    data['business_email'] = businessEmail;
    data['business_phone'] = businessPhone;
    data['website_title'] = websiteTitle;
    data['business_website'] = businessWebsite;
    data['business_address'] = businessAddress;
    data['business_images'] = businessImages;
    data['business_video'] = businessVideo;
    data['business_btnname'] = businessBtnname;
    data['business_btnurl'] = businessBtnurl;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['instagram'] = instagram;
    data['linkedin'] = linkedin;
    data['whatsapp'] = whatsapp;
    data['youtube'] = youtube;
    data['Tiktok'] = tiktok;
    data['first_time_login'] = firstTimeLogin;
    data['deleted_at'] = deletedAt;
    data['created_by'] = createdBy;
    data['created'] = created;
    data['modified'] = modified;
    data['all_business'] = allBusiness;
    data['wheelchair'] = wheelchair;
    data['black_owned'] = blackOwned;
    data['latinx_owned'] = latinxOwned;
    data['women_owned'] = womenOwned;
    data['asian_owned'] = asianOwned;
    data['lgbtq_owned'] = lgbtqOwned;
    data['veteran_owned'] = veteranOwned;
    data['bike_parking'] = bikeParking;
    data['ev_charging'] = evCharging;
    data['plastic_free'] = plasticFree;
    data['vaccination_required'] = vaccinationRequired;
    data['fully_vaccinated'] = fullyVaccinated;
    data['masks_required'] = masksRequired;
    data['staff_wears_masks'] = staffWearsMasks;
    data['android_pay'] = androidPay;
    data['apple_pay'] = applePay;
    data['credit_card'] = creditCard;
    data['cryptocurrency'] = cryptocurrency;
    data['waitlist_reservations'] = waitlistReservations;
    data['online_ordering'] = onlineOrdering;
    data['dogs_allowed'] = dogsAllowed;
    data['military'] = military;
    data['flower_delivery'] = flowerDelivery;
    data['in_site_register'] = inSiteRegister;
    data['social_loginId'] = socialLoginId;
    data['DND'] = dND;
    data['active_status'] = activeStatus;
    data['avatar'] = avatar;
    data['updated_at'] = updatedAt;
    data['dark_mode'] = darkMode;
    data['messenger_color'] = messengerColor;
    data['g-recaptcha-response'] = gRecaptchaResponse;
    data['payment_type'] = paymentType;
    data['customer_id'] = customerId;
    data['cancel_at'] = cancelAt;
    data['featured_post_count'] = featuredPostCount;
    data['bump_post_count'] = bumpPostCount;
    data['paid_post_count'] = paidPostCount;
    data['slideshow_limit'] = slideshowLimit;
    data['paypal_orderID'] = paypalOrderID;
    data['desc_subscription'] = descSubscription;
    data['desc_subscription_plan'] = descSubscriptionPlan;
    data['desc_start_date'] = descStartDate;
    data['desc_end_date'] = descEndDate;
    data['paypal_subscriptionID'] = paypalSubscriptionID;
    data['review'] = review;
    data['free_bump'] = freeBump;
    data['free_listing'] = freeListing;
    data['user_from'] = userFrom;
    return data;
  }
}