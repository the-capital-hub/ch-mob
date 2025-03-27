class ApiUrl {
  /// base url
  static const String baseUrl =
      "http://ec2-3-7-68-117.ap-south-1.compute.amazonaws.com:8080/";
  static const String loginUrlEmail = "users/login";
  static const String loginUrlPhone = "users/send_otp";
//   static const String signupUrl = "users/createUser";
  static const String signupUrl = "users/userSignupByOtp";
  static const String verifyOTPUrl = "users/verify_otp";
  static const String verifyOtpForSignup = "users/verifyOtpForSignup";
  static const String checkUsernameAvailability =
      "users/checkUsernameAvailability";
  static const String saveRequiredData = "users/saveRequiredData";
  static const String resendOTPUrl = "users/resend_otp";
  static const String getUserByNameUrl = "users/getuserbyusername";
  static const String updateFounderUrl = "users/updateFounder";
  static const String googleLogin = "users/googleLogin";

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
  static const String getStartupCornerNews =
      "news/inshort-news?lang=en&category=startup&offset=";
  static const String getNewsByDateUrl = "news/getNewsByDate";
  static const String getTodaysNewsUrl = "news/getTodaysNews";

  static const String exploreUrl = "users/explore?";
  static const String exploreFilterUrl = "users/exploreFilters?type=";
  static const String toggleIntrestInvUrl = "investor/toggleInterestInInvestor";
  static const String onelinkSentUrl = "startup/sendOneLinkRequest";
  static const String vcsUrl = "vc/getVcById";

  static const String livedealsUrl = "live_deals/get_live_deals";
  static const String toggelDealsUrl =
      "live_deals/toggle_investor_to_live_deal";

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
  static const String createFolderName = "documentation/uploadDocument";
  static const String getFolderByUser = "documentation/getFolderByUser";

  static const String getSavedPostFolderList =
      "api/posts/getSavedPostCollectionsProfile";
  static const String getSavedPost = "api/posts/getSavedPostsByCollection";
  static const String removeSavedPost = "api/posts/unsavePost";

  static const String addPost = "api/posts/newPost";
  static const String getPostDetail = "api/posts/get_post_by_id";

  static const String oneLinkDetailsGet = "startup/onelinkDetails";
  static const String oneLinkDetailsEdit = "investor/editInvestorOneLink";
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

  static const String groupChatMemberList =
      "community/getAllCommunitiesByUserId";
  static const String createGroup = "community/createCommunity";

  static String getPublicProfileUrl = "users/getFounderProfilePageData/";
  static String addFounderEmailUrl = "users/addFounderEmailToCurrentUser/";

  static const String getAvailability = "meetings/getAvailability";
  static const String updateAvailability = "meetings/updateAvailability";
  static const String createEvent = "meetings/createEvent";
  static const String updateEvent = "meetings/updateEvent/";
  static const String getEvents = 'meetings/getEvents';
  static const String disableEvent = "meetings/disableEvent/";
  static const String scheduleEvent = "meetings/ScheduleMeeting/";
  static const String getALLScheduledMeetings =
      'meetings/getALLScheduledMeetings/';
  static String cancelScheduledMeeting = "meetings/cancelScheduledMeeting/";
  static String getWebinars = "webinars/getWebinars";
  static String createWebinar = "webinars/createWebinar";
  static String updateWebinar = "webinars/updateWebinar/";
  static String disableWebinar = "webinars/disableWebinar/";
  static String registerWebinar = "webinars/bookWebinar/";
  static String getPriorityDMForUser = "priorityDM/getPriority-DMForUser";
  static String getPriorityDMForFounder = "priorityDM/getPriority-DMForFounder";

  static const String createCommunity = "Communities/createCommunity";
  static const String getCommunityById = "Communities/getCommunityById/";
  static const String getAllCommunities = "Communities/getAllCommunities";
  static const String getMyCommunities =
      "Communities/getAllCommunitiesByUserId";
  static const String getMemberEmails =
      "Communities/getMemberEmails/";
  static const String leaveCommunity = "Communities/leaveCommunity/";
  static const String deleteCommunity = "Communities/deleteCommunity/";
  static const String joinCommunity = "Communities/addMembersToCommunity/";
  static const String updateCommunity = "Communities/updateCommunity/";
  static const String addProductToCommunity =
      "Communities/addProductToCommunity/";
  static const String updateCommunityProduct = "Communities/updateProduct/";
  static const String createCommunityPriorityDM =
      "Communities/createPriorityDM/";
  static const String updateCommunityPriorityDM =
      "Communities/updatePriorityDM/";
  static const String deleteCommunityPriorityDM =
      "Communities/deletePriorityDM/";
  static const String askQuestionCommunityPriorityDM =
      "Communities/bookPriorityDM/";
      static const String answerCommunityPriorityDM =
      "Communities/answerPriorityDM/";
  static const String createCommunityMeeting = "Communities/createMeeting/";
  static const String updateCommunityMeeting = "Communities/updateMeeting/";
  static const String deleteCommunityMeeting = "Communities/deleteMeeting/";
  static const String bookCommunityMeeting = "Communities/bookMeeting/";
  static const String getCommunityProductsAndMembers =
      "Communities/getCommunityProductsAndMembers/";
  static const String getAboutCommunity = "Communities/getCommunityById/";
  static const String buyProduct = "Communities/buyProduct/";
  static const String deleteCommunityProduct = "Communities/deleteProduct/";
  static const String removeCommunityMember = "Communities/removeMember/";
  static const String getWebinarsByCommunityId =
      "webinars/getWebinarsByCommunityId/";
  static const String getCommunityPriorityDMs =
      "communities/services/priorityDMs/";
      static const String getCommunityPriorityDMYourQuestions =
      "communities/priorityDM/userQuestions/";
  static const String getCommunityWebinars = "communities/services/webinars/";
  static const String deleteCommunityWebinar = "webinars/deleteWebinar/";
  static const String getCommunityMeetings = "communities/services/meetings/";
  static const String sendJoinRequest = "Communities/sendJoinRequest";
  static const String getCommunityPosts = "api/posts/getCommunityPosts/";
  static const String likeUnlikeCommunityPost =
      "api/posts/likeUnlikeCommunityPost/";
  static const String commentCommunityPost = "api/posts/commentCommunityPost/";
  static const String deleteCommentCommunityPost =
      "api/posts/deleteCommentCommunityPost/";
  static const String toggleLikeCommentCommunityPost =
      "api/posts/toggleLikeCommentCommunityPost/";
  static const String reportPost = "users/report";
  static const String deleteCommunityPost = "api/posts/deleteCommunityPost/";
  static const String getSavedCommunityPostCollections =
      "api/posts/getSavedCommunityPostCollections/";
  static const String saveCommunityPost = "api/posts/saveCommunityPost/";
  static const String unsaveCommunityPost = "api/posts/unsaveCommunityPost";
  static const String voteCommunityPost = "api/posts/voteCommunityPost";

  static const String getAllResources = "resource/getAll";
  static const String getResourceById = "resource/getById/";

  static const String searchCompanyInv = "investor/searchInvestors/";
  static const String addCompanyUserInv = "users/addUserAsInvestor";
  static String getCompanyDetailInv = "investor/getInvestorById/";
  static const String deleteCompanyInv = "investor/deleteInvestor";
  static const String createCompanyInv = "investor/createInvestor";

  static const String getInvStartupInfo =
      "investor/getInvestorStartupInformation";
  static const String addMyInvestment =
      "investor/startup-invested"; //same for add edit del
  static const String delMyInterest = "investor/interest";
  static const String addPastInvestment =
      "investor/past-investment"; //same for add edit del

  static const String getCampaignUrl =
      "campaign/lists/getFilteredInvestorsList";
  static const String createCampaignUrl =
      "campaign/lists/createUpdateFilteredInvestorsList";
  static const String getAllCampaignDetailUrl =
      "campaign/lists/getFilteredInvestorsListCampaignPage";
  static const String getInvListById =
      "campaign/lists/getFilteredInvestorsListById/";
  static const String removeInvFromList =
      "campaign/lists/removeInvestorFromList/";
  static const String deleteList =
      "campaign/lists/deleteFilteredInvestorsList/";
  static const String createTemplate = "campaign/templates/createTemplate";
  static const String updateTemplate = "campaign/templates/updateTemplate/";
  static const String viewTemplate = "campaign/templates/getTemplates";
  static const String deleteTemplate = "campaign/templates/deleteTemplate/";
  static const String getOutreachCampaign = "campaign/getCampaigns";
  static const String getViewCampaign = "campaign/getCampaign/";
  static const String duplicateCampaign = "campaign/duplicateCampaign/";
  static const String runCampaign = "campaign/runCampaign/";
  static const String scheduleCampaign =
      "campaign/scheduleCampaign/"; //cancel campaign also
  static const String deleteCampaign = "campaign/deleteCampaign/";
  static const String preCreatedDate = "campaign/getPreCreatedData";
  static const String createCampaign = "campaign/createCampaign";
}
