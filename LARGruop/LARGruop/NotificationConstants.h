//
//  NotificationConstants.h
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

//REQUEST ERROR NOTIFICATIONS

static NSString * const kNotificationNoInternetConnection = @"NoInternetConnectionNotification";
static NSString * const kNotificationUnauthorized = @"UnauthorizedNotification";
static NSString * const kNotificationNotFound = @"NotFoundNotification";
static NSString * const kNotificationInternalServerError = @"InternalServerErrorNotification";
static NSString * const kNotificationUnexpectedError = @"UnexpectedErrorNotification";

//LOGIN NOTIFICATIONS

static NSString * const kNotificationLoginSucceeded = @"LoginSucceededNotification";
static NSString * const kNotificationLoginFailed = @"LoginFailedNotification";
static NSString * const kNotificationLogoutFinished = @"LogoutFinishedNotification";
static NSString * const kNotificationLogoutActionRequested = @"LogoutActionRequestedNotification";
static NSString * const kNotificationInvalidTokenDetected = @"InvalidTokenDetectedNotification";

//SETTINGS NOTIFICATIONS
static NSString * const kNotificationReloadAllData = @"ReloadAllDataNotification";
static NSString * const kNotificationReloadAllDataControllers = @"ReloadAllDataNotificationControllers";


// SEARCH NOTIFICATIONS
static NSString * const kNotificationSearchShouldDisplay = @"SearchShouldDisplayNotification";
static NSString * const kNotificationSearchReturn = @"SearchReturnNotification";

//FILTER NOTIFICATIONS

static NSString * const kNotificationApplyFilters = @"ApplyFiltersNotification";
static NSString * const kNotificationDismissFilterWithoutApply = @"DismissFilterWithoutApplyNotification";
static NSString * const kNotificationFilterProyectsChanged = @"FilterProyectsChangedNotification";
