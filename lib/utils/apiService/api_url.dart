import 'package:capitalhub_crm/utils/getStore/get_store.dart';

class ApiUrl {
  /// base url
  static const String baseUrl =
      "http://ec2-3-7-68-117.ap-south-1.compute.amazonaws.com:8080/";
  static const String loginUrlEmail = "users/login";
  static const String loginUrlPhone = "users/send_otp";
  static const String signupUrl = "users/createUser";
  static const String verifyOTPUrl = "users/verify_otp";
  static const String resendOTPUrl = "users/resend_otp";
  static const String getUserByNameUrl = "users/getuserbyusername";
  static const String updateFounderUrl = "users/updateFounder";

//startup
  static const String getPublicPostUrl = "api/posts/getPublicPosts?page=";
  static const String likeUnlikePostUrl = "api/posts/likeUnlikePost/";
  static const String commentPostUrl = "api/posts/comment/";
  static const String commentLikeUnlikeUrl = "api/posts/toggleLikeComment/";
  static const String deleteCommentUrl = "api/posts/deleteComment/";
  static const String addPostFeatureUrl = "api/posts/addToFeaturedPost/";
  static const String addPostCompanyUrl = "api/posts/addToCompanyUpdatePost/";
  static const String deletePostUrl = "api/posts/deletePost/";
  static const String collectionGetUrl = "api/posts/getSavedPostCollections/";
  static const String savePostUrl = "api/posts/savePost/";
  static const String unSavePostUrl = "api/posts/unsavePost/";
  static const String pollVote = "api/posts/vote";
  static const String getStartupCornerNews = "news/inshort-news?lang=en&category=startup&offset=";
  static const String getNewsByDateUrl = "news/getNewsByDate";
  static const String getTodaysNewsUrl = "news/getTodaysNews";


  static const String exploreUrl = "users/explore?";
  static const String exploreFilterUrl = "users/exploreFilters?type=";
  static const String vcsUrl = "vc/getVcById";


  static String getNotification = "notificaton/getNotification/";
  static String getNotificationCount = "notificaton/getNotificationCount";
  static const String readNotification = "notificaton/markMessageAsRead/";
  static const String allReadNotification =
      "notificaton/markAllNotificationsAsRead";

  static String getProfileUrl = "users/getUserById/";
  static String getProfilePost = "users/getProfilePosts/";
  static String updateProfile = "users/updateFounder";
  static String deleteFeaturePost = "api/posts/removeFromFeaturedPost/";
  static String deleteCompanyPost = "api/posts/removeCompanyUpdatePost/";
  static String deleteMyPost = "api/posts/deletePost/";

  static const String searchCompany = "startup/searchStartUps/";
  static const String addCompanyUser = "users/addStartUpToUser";
  static String getCompanyDetail = "startup/getStartupByFounderId/";
  static const String deleteCompany = "startup/delete_startup";
  static const String createCompany = "startup/createStartup";

  static const String getReceivedConnection =
      "connections/getPendingConnectionRequests";
  static const String getSentConnection =
      "connections/getSentPendingConnectionRequests";
  static String getAcceptedConnection = "connections/getUserConnections/";
  static const String sendReq = "connections/sendConnectionRequest/";
  static const String acceptReq = "connections/acceptConnectionRequest/";
  static const String rejectReq = "connections/rejectConnectionRequest/";
  static const String removeConnectionReq = "connections/removeConnection/";
  static const String cancelConnectionReq =
      "connections/cancelConnectionRequest/";

  static const String getDocument = "documentation/getDocumentsByUser";
  static const String deleteDocument = "documentation/deleteDocument";
  static const String uploadDocument = "documentation/uploadDocument";

  static const String getSavedPostFolderList =
      "api/posts/getSavedPostCollectionsProfile";
  static const String getSavedPost = "api/posts/getSavedPostsByCollection";
  static const String removeSavedPost = "api/posts/unsavePost";

  static const String addPost = "api/posts/newPost";
  static const String getPostDetail = "api/posts/get_post_by_id";


  static const String oneLinkDetailsGet = "startup/onelinkDetails";
  static const String onelinkIntroMsgPost = "startup/introMessage";
  static const String onelinkCreateSecKey = "users/createSecretkey";
  static const String getCompPostCompany = "users/getProfilePosts/company";
  static const String deleteCompPostCompany =
      "api/posts/removeCompanyUpdatePost/";



  static const String chatMemberList = "chat/getUserChats";
  static const String chatTogglePin = "chat/togglePin/";
  static const String getchats = "message/getMessages/";
  static const String addMessage = "message/addMessage";
  static const String searchMember = "connections/searchConnections?search=";
  static const String createChat = "chat/createChat";
  static const String deleteMessage = "message/deleteMessage/";
  static const String clearChat = "message/clearChat/";
  static const String blockUser = "users/toggleUserBlock";

  static const String groupChatMemberList = "community/getAllCommunitiesByUserId";
  static const String createGroup = "community/createCommunity";

  static String getPublicProfileUrl = "users/getFounderProfilePageData/";
  static String addFounderEmailUrl = "users/addFounderEmailToCurrentUser/";



}
