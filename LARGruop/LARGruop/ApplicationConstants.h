//
//  ApplicationConstants.h
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//




#define GLAR_CONNECTION_HEADER_DEFAULT_VALUE @"Keep-Alive"

#define GLAR_ACCEPT_ENCODING_HEADER_DEFAULT_VALUE @"gzip"

#define GLAR_USER_AGENT_HEADER_DEFAULT_VALUE @"okhttp/2.3.0"

#pragma mark - CONSTANTS

static NSString * const BaseURLString = @"http://grupolar.mycommunity.com.pe/";


#pragma mark - SENDERS

static NSString * const NOTIFICATION_SENDER = @"NotificationSender";
static NSString * const FILTER_SENDER = @"Filter_Sender";
static NSString * const HOME_SENDER = @"Home_Sender";


#pragma mark - USER INFO

static NSString * const USER_INFO_SHOW_ALERT_VIEW = @"ShowAlertView";


#pragma mark - BUSSINES RULES

static const int MAX_ROOM_FILTER = 5;


#pragma mark - MODES

static NSString * const FILTER_MODE = @"Filter_Mode";

#pragma mark - Utils



#pragma mark - Macros

#define GLARLS(key) NSLocalizedString(key, nil)
#define GLARUI(key) NSLocalizedStringFromTable(key, @"UIElements", nil)
#define GLARLSFROM(key, file) NSLocalizedStringFromTable(key, file, nil)


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)

#define isIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isIphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define isRetina ([[UIScreen mainScreen] scale] >= 2.0)

#define screenWidth ([[UIScreen mainScreen] bounds].size.width)
#define screenHeight ([[UIScreen mainScreen] bounds].size.height)
#define screenMaxLength (MAX(screenWidth, screenHeight))
#define screenMinLength (MIN(screenWidth, screenHeight))

#define isiPhone4OrLess (isIphone && screenMaxLength < 568.0)
#define isiPhone5 (isIphone && screenMaxLength == 568.0)
#define isiPhone6 (isIphone && screenMaxLength == 667.0)
#define isiPhone6Plus (isIphone && screenMaxLength == 736.0)


