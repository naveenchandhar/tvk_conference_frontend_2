// const String BASE_URL = "http://192.168.1.48:8000";
// const String BASE_URL = "http://tvk.inforgetech.com:8000";
// const String BASE_URL = "http://192.168.29.8:5000";
// const String BASE_URL = "http://192.168.29.135:5000";
// const String BASE_URL = "http://192.168.29.112:3000";
 // const String BASE_URL = "http://192.168.29.146:5000";
const String BASE_URL = "http://192.168.29.146:3000";   //44.203.137.126:6000  192.168.29.112:3000
//const String BASE_URL = "https://api.tvkhq.org"; //code given for commit

// const String BASE_URL = "http://192.168.29.130:5000";
// const String BASE_URL = "http://192.168.29.146:5000";
// const String BASE_URL = "http://192.168.29.135:5000";
// const String BASE_URL = "https://api.tvkhq.org"; //code given for commit

const String BASE_API = "$BASE_URL/api";

//SIGNUP
const String FIND_USER_BY_EPIC_NO_URL = "$BASE_API/member";
const String FIND_USER_BY_CORRECT_EPIC_NO_URL = "$BASE_API/user/getUser";
const String SEND_OTP_URL = "$BASE_API/checkUser";
const String SIGN_UP_USER = "$BASE_API/pic/updateImages";
const String SEND_OTP_TO_NEW_USER_URL = "$BASE_API/checkNewUser";
const String SAVE_USER_NEW_PASSWORD_URL = "$BASE_API/user/saveUserNewPassword";
const String RECHECK_AND_FIND_USER_BY_EPIC_NO_URL = "$BASE_API/user/reCheck";
const String CHECK_AND_FIND_USER_BY_EPIC_NO_URL = "$BASE_API/user/check";

//LOGIN
const String USER_LOGIN_URL = "$FIND_USER_BY_EPIC_NO_URL/namePwd";
const String NEWLY_CREATED_USER_URL = "$FIND_USER_BY_EPIC_NO_URL/findNewlyCreatedUser";
//USER
const String USER_LIST_URL = "$FIND_USER_BY_EPIC_NO_URL/getallusers";
const String USER_LIST_BY_USERID_URL = "$FIND_USER_BY_EPIC_NO_URL/getUsersByUserId";
const String USER_FILTERED_URL = "$FIND_USER_BY_EPIC_NO_URL/member/list";

//VOTER
const String VOTER_LIST_URL = "$BASE_API/voter/getAllVoter";
//PARLIMENTARYDROPDOWN
const String PARLIMENTARY_LIST_URL = "$BASE_API/cassembly/getallassemblyCons";
//OCCUPATION
const String OCCUPATION_lIST_URL = "$BASE_API/occupation/occupationFindAll";
const String STATE_FILTERED_lIST_FOR_MODEL_URL = BASE_API + "/state/list";
const String STATE_BY_ID_URL = BASE_API + "/state/";
const String REGION_LIST_URL = BASE_API + "/region/";
const String REGION_SAVE_URL = BASE_API + "/region";
const String REGION_UPDATE_URL = BASE_API + "/region/";
const String GET_REGION_BY_ID_URL = BASE_API + "/region/";
const String REGION_DELETE_URL = BASE_API + "/region/";
const String GET_REGION_LIST_URL = BASE_API + "/region/district";
const String GET_REGION_LIST_URL1 = BASE_API + "/region/district1";


// RELATION
const String RELATION_LIST_URL = "$BASE_API/relation/listAll";

const String STATE_lIST_URL="$BASE_URL/api/state/list";
const String DISTRICT_LIST_FOR_MODEL_URL="$BASE_URL/api/district";
const String DISTRICT_LIST_FOR_TOTAL_MODEL_URL="$BASE_URL/api/district";
const String DISTRICT_LIST_URL= BASE_API + "/district/state";
const String DISTRICT_SAVE_URL="$BASE_API/district";
const String DISTRICT_DELETE_URL="$BASE_API/district";
const String DISTRICT_BY_ID_URL="$BASE_API/district";
const String DISTRICT_FILTERED_LIST_URL="$BASE_API/district";
const String FIND_DISTRICT_BY_ID="$BASE_API/district/district";
const String DISTRICT_UPDATE_URL="$BASE_API/district";


//AssemblyConsituency
const String DISTRICT_Tot_LIST_URL="$BASE_API/district/alldist/totaldistricts";
const String STATE_TOTAL_LIST_URL="$BASE_API/state/statename/totalstate";
const String SAVE_ASSEMBLY_URL="$BASE_API/cassembly/assemblyconssave";
const String ASSEMBLY_DELETE_URL="$BASE_API/cassembly/assemblycondelete";
const String ASSEMBLY_UPDATE_URL="$BASE_API/cassembly/assemblyconsupdate";
const String ASSEMBLY_CONSFILTER="$BASE_API/cassembly/assemblyconsfilter";
const String CONST_ASSEMBLY_LIST_BY_DISTRICTID_URL="$BASE_API/cassembly/sAssemblybyDistrict";
const String ASSEMBLY_BY_ID = "$BASE_API/cassembly";

//PARLIMENTARY CONSTITUENCY
const String PARLIMENTARY_CONSTITUENCY_LIST_URL="$BASE_API/pconstituency";
const String PARLIMENTARY_CONSTITUENCY_SAVE_URL="$BASE_API/pconstituency";
const String PARLIMENTARY_CONSTITUENCY_DELETE_URL="$BASE_API/pconstituency";
const String PARLIMENTARY_CONSTITUENCY_UPDATE_URL="$BASE_API/pconstituency";
//MEMBER
const String MEMBER_LIST_URL = "$BASE_API/member/memberFindAll";
const String FILTERED_MEMBER_URL = "$BASE_API/member/filteredMemberList";
const String MEMBER_ROLE_UPDATE_URL = "$BASE_API/member/memberRoleUpdate";
const String SIGN_UP_USER1 = "$BASE_API/pic/updateImages";

const String ADMIN_MEMBER_LIST_URL = "$BASE_API/member/getAdminListReport";
const String MEMBER_LIST_DATA_URL = "$BASE_API/member/memberfindDataById";
const String MEMBER_BY_ID_URL = "$BASE_API/member/memberfindById/";

//ROLE
const String ROLE_LIST_URL = "$BASE_API/role/roleFindAll";
//STATE
const String STATE_LIST_URL = "$BASE_API/state/listAll";
//District
const String DISTRICT_FINDALL_URL = "$BASE_API/district/districtListFindAll";
const String DISTRICT_FOR_STATE = "$BASE_API/district/districtListByState";


//Local Issue
const String SAVE_NEW_ISSUE = BASE_API + "/localIssue/save";
const String UPDATE_ISSUE = BASE_API + "/localIssue/update";
const String UPDATE_ISSUE1 = BASE_API + "/localIssue/updatewoimg";
const String LIST_ISSUE_URL = BASE_API + "/localIssue/listAll";
const String LOCAL_ISSUE_DELETE_URL = BASE_API + "/localIssue/delete";
const String LIST_DATA_URL = BASE_API + "/localIssue/findOne";


//TWEEDLE
const String TWEEDLE_LIST_URL = BASE_API + "/tweedle/list";
const String SAVE_NEW_TWEEDLE = BASE_API + "/tweedle/tweedleSave";

//TWEEDLE
const String TWEEDLE_LIKE_SAVE_URL = BASE_API + "/tweedle/tweedleLikes/save";
const String TWEEDLE_LIKE_DELETE_URL = BASE_API + "/tweedleLikes/delete";
const String TWEEDLE_LIST_FOR_USER_URL = BASE_API + "/tweedle/getUserTweedlePost";
const String TWEEDLE_DELETE_BY_ID_URL = BASE_API + "/tweedle/deleteTweedleById";

//BIRTHDAY MESSAGE
const String BIRTHDAY_LIST_URL = BASE_API + "/message/list";
const String MESSAGE_UPDATE_URL = BASE_API + "/message/update";

//IDENTITY CARD
const String FETCHING_IDCARD_DATA_URL = BASE_API + "/id/get/idCard";
const String FETCHING_EVENT_IDCARD_DATA_URL = BASE_API + "/id/get/eventidCard";

//fcm table
const String SAVE_USER_FCM_URL = BASE_API + "/fcmtoken/saveFcmToken";
const String DELETE_USER_FCM_URL = BASE_API + "/fcmtoken/deleteFcmToken";
const String USER_FCM_LIST_URL = BASE_API + "/fcmtoken/getUserFcmList";

// pushnotification
const String USER_LIST_FOR_TWEEDLE_NOTIFICATION_URL = BASE_API + "/fcmtoken/getUserForTweedle";

// voluenteer

const String USER_ROLE_ID= BASE_API + "/voluenteer/getroleId";
const String SAVE_VOLENTEER= BASE_API + "/voluenteer/voluenteersave";
const String GET_ALL_VOLENTEER= BASE_API + "/voluenteer/gatvoluenteerall";
const String VOLENTEER_EXISTING_CHECK = BASE_API + "/voluenteer/voluenteerexistingch";
const String FILTER_VOLENTEER = BASE_API + "/voluenteer/voluenteerfilter";
const String ASSEMBLY_VOLENTEER = BASE_API + "/voluenteer/assemblyfilter";
const String PARLIMENTARY_VOLENTEER = BASE_API + "/voluenteer/parlimentaryfilter";

//Assembly wise report
const String FETCH_GENDER_URL = BASE_API + "/ReportXL/genderreport";
const String FETCH_GENDER_LIST = BASE_API + "/ReportXL/getGenderListReport";

//Parliment wise report
const String FETCH_PARLIMENT_GENDER_URL = BASE_API + "/ReportParlimentXL/genderparlimentreport";
// const String FETCH_PARLIMENT_GENDER_LIST = BASE_API + "/ReportParlimentXL/getGenderparlimentListReport";

// const String FETCH_PARLIMENT_GENDER_LIST = BASE_API + "/ReportParlimentXL/getGenderparlimentListReport";

//Survaly  list and save survay taker and save survay question

const String FETCH_SURVAY_LIST_QUESTION = BASE_API + "/surveyCreated/allsurvayquestions";
const String SURVAY_TAKER= BASE_API + "/surveyTaker/save";
const String SURVAY_ANSWER_SAVE= BASE_API + "/surveyTaker/saveSurveyAnswer";

//Survey
const String SURVEY_QUESTION_SAVE_URL = BASE_API+"/surveyCreated/saveSurveyCreated";

//Helpline Service
const String SERVICE_LIST_URL= BASE_API+"/publicServices/publicServicesFindAll";

//Zone
const String ZONE_LIST_URL = BASE_API+"/helplineRouter/hlZoneFindAll";

//Subdivision
const String SUBDIVISION_LIST_URL = BASE_API+"/helplineRouter/hlSubDivisionFindAll";
const String SUBDIVISION_LIST_BY_DISTRICT = BASE_API+"/fireRescue/fireRescueSubDivisionFindAll";

//Police Station
const String STATION_LIST_URL = BASE_API+"/helplineRouter/hlPoliceStationFindAll";
const String STATION_DATA_URL = BASE_API+"/helplineRouter/findhlPoliceStionById";
const String PUDUCHERRY_STATION_LIST_URL = BASE_API+"/helplineRouter/hlPoliceStationFindAllPuducherry";


//Fire Rescue Station
const String FIRE_RESCUE_STATION_LIST_URL = BASE_API+"/fireRescue/fireRescueStationFindAll";
const String FIRE_RESCUE_STATION_DATA_URL = BASE_API+"/fireRescue/findfireRescueStionById";

//News
const String NEWS_LIST_URL = BASE_API + "/news/listAll";
const String NEWS_DATA_URL = BASE_API+"/news/findOne";
const String NEWS_VIEWS_DATA_URL = BASE_API+"/news/update";
const String NEWS_SAVE_URL = BASE_API+"/news/save";


//evets
//<editor-fold desc="//Folder picker">
const String CREATE_EVENT =BASE_API + "/events/create";
//</editor-fold>
const String EVENTS_LIST_URL =BASE_API + "/events/list";
const String EVENT_DELETE_URL = BASE_API + "/events/delete";
const String EVENT_UPDATE_URL = BASE_API + "/events/update";

//IMAGE
const String IMAGE_LIST_URL = BASE_API + "/frontImage/list";


//eventMembers
const String EVENT_MEMBERS_LIST_URL = BASE_API + "/eventMember/eventMemberId";
const String EVENT_MEMBER_DELETE_URL = BASE_API + "/eventMember/delete";
const String SINGLE_EVENT_MEMBER_URL = BASE_API + "/eventMember/individualmember";
const String EVENT_MARKED_MEMBER_URL = BASE_API + "/eventMember/ismarked";
const String EVENT_MEMBER_IMAGE_URL = BASE_API + "/eventMember/imageurl";
const String EVENT_MEMBER_UPDATE_MEMBER = BASE_API + "/eventMember/updateMember";
const String EVENT_MEMBER_LIST_UPDATE_MEMBER = BASE_API + "/eventMember/updateIndiualMember";
const String EVENT_MEMBER_IMAGE_UPDATE_URL = BASE_API + "/eventMember/updateEventImages";

//Conference
const String SAVE_CONFERENCE_URL = "$BASE_API/conference/save";
const String FINDALL_CONFERENCE_URL = "$BASE_API/conference/findAll";

//Scan Conference Member
const String SAVE_SCAN_MEMBER_CONFERENCE_URL = "$BASE_API/conference/Savescan";
const String FIND_ONE_CONFERENCE_URL = "$BASE_API/conference/findOneConference";
const String UPDATE_SCAN_MEMBER_CONFERENCE_URL = "$BASE_API/conference/updateOtherMember";
const String FIREBASE_REFRESH_CONFERENCE_URL = "$BASE_API/conference/firebaseRefresh";
  const String ASSEMBLY_WISECONFERENCE_URL = "$BASE_API/conference/assemblywiseCount";


const String FIND_ONE_CARD_CONFERENCE_URL = "$BASE_API/conference/findOneCardConference";
  const String ASSEMBLY_WISECONFERENCE_CARDSCAN_URL = "$BASE_API/conference/assemblywiseCount_cardscan";
const String SAVE_CARD_SCAN_MEMBER_CONFERENCE_URL = "$BASE_API/conference/Savecardscan";
const String UPDATE_CARD_SCAN_MEMBER_CONFERENCE_URL = "$BASE_API/conference/updateCardScanMember";
const String CONFERENCE_GENERATEIMAGE = "$BASE_API/conference/generateImage";