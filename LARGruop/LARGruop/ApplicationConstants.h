//
//  ApplicationConstants.h
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)



#pragma mark - SENDERS

static NSString * const NOTIFICATION_SENDER = @"NotificationSender";
static NSString * const FILTER_SENDER = @"Filter_Sender";
static NSString * const HOME_SENDER = @"Home_Sender";







#pragma mark - BUSSINES RULES

static const int MAX_ROOM_FILTER = 5;


#pragma mark - MODES

static NSString * const FILTER_MODE = @"Filter_Mode";




