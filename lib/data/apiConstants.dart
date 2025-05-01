class ApiConstants{
static const String _baseUrl = "https://www.finderspage.com/api";

static const String profileUrl = "https://www.finderspage.com/public/assets/images/profile";
static const String postImgUrl = "https://www.finderspage.com/public/images_blog_img";
static const String videoUrl = "https://www.finderspage.com/public/images_blog_video";
static const String businessImgUrl = "https://www.finderspage.com/public/business_img";
static const String entertainImgUrl = "https://www.finderspage.com/public/images_entrtainment";

// without login apis
static const String loginApi = "$_baseUrl/login-app";
static const String signupApi = "$_baseUrl/signup-app";
static const String forgotApi = "$_baseUrl/forgot-Password-app";
static const String homeList = "$_baseUrl/category-main";
static const String subCategories = "$_baseUrl/category-sub/";
static const String shopList = "$_baseUrl/Shop/list";
static const String shopDetail = "$_baseUrl/Shop/single";
static const String logOutApi = "$_baseUrl/logout-app";
static const String resendApi = "$_baseUrl/resend-email-verification";

// profile apis
static const String getUser = "$_baseUrl/showProfileApp";
static const String updateUser = "$_baseUrl/updateProfileApp";
static const String changePassword = "$_baseUrl/change-Password-app";

// create post apis
  static const String createPost = "$_baseUrl/createPostApp";
  static const String updatePost = "$_baseUrl/updatePostApp";
  static const String updateVideo = "$_baseUrl/updateVideoApp";
  static const String uploadVideo = "$_baseUrl/uploadVideoApp";
  static const String deletePostApi = "$_baseUrl/deletePostApp";

// posts home list apis
  static const String showAllPosts = "$_baseUrl/showPostApp";
  static const String showAllVideo = "$_baseUrl/showVideoApp";
  static const String likeApi = "$_baseUrl/likes";
  static const String commentListApi = "$_baseUrl/comment-list";
  static const String replyListApi = "$_baseUrl/comment-list-reply";
  static const String commentPostApi = "$_baseUrl/comment-save";
  static const String updateCommentApi = "$_baseUrl/comment-update";
  static const String deleteCommentApi = "$_baseUrl/comment-delete";
  static const String commentLikeApi = "$_baseUrl/comment-like";
  static const String replyPostApi = "$_baseUrl/comment-reply";
  static const String savePostApi = "$_baseUrl/saved-data";
  static const String notificationListApi = "$_baseUrl/get-list-of-notification";
  static const String clearNotificationApi = "$_baseUrl/clear-notification";
}