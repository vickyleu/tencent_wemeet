typedef NS_ENUM (NSInteger, WRPropRingingPage) {
	kWRPropRingingPageMapRingingState = 731115,
	kWRPropRingingPageMapUiData = 100091,
	kWRPropRingingPageMapInviter = 387069, // app_id, app_uid, avatar_token, nickname
};

static NSString *const kWRPropRingingPageRingingStateFieldsBooleanRinging = @"RingingPageRingingStateFields_kBooleanRinging";
static NSString *const kWRPropRingingPageRingingStateFieldsStringUri = @"RingingPageRingingStateFields_kStringUri";

static NSString *const kWRPropRingingPageUiDataFieldsStringEyebrowHeadline = @"RingingPageUiDataFields_kStringEyebrowHeadline";
static NSString *const kWRPropRingingPageUiDataFieldsStringHeadline = @"RingingPageUiDataFields_kStringHeadline";

typedef NS_ENUM (NSInteger, WRActionRingingPage) {
	kWRActionRingingPageMapAccept = 328598,
	kWRActionRingingPageMapDecline = 267481,
};

