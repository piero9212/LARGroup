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

//PROYECTS NOTIFICATIONS

static NSString * const kNotificationAllProyectsFailed = @"AllProyectsFailedNotification";

//CLIENTS NOTIFICATIONS

static NSString * const kNotificationAllClientsFailed = @"AllClientsFailedNotification";
static NSString * const kNotificationAllClientsSucced = @"AllClientsSuccedNotification";
static NSString * const kNotificationNewClientFailed = @"NewClientFailedNotification";
static NSString * const kNotificationNewClientSucced = @"NewClientSuccedNotification";
static NSString * const kNotificationEditClientSucced = @"EditClientSuccedNotification";
static NSString * const kNotificationEditClientFailed = @"EditClientFailedNotification";

//PROMO NOTIFICATIONS
static NSString * const kNotificationPromoAcepted = @"PromoAceptedNotification";
static NSString * const kNotificationPromoCancel = @"PromoCancelNotification";

//FILTER NOTIFICATIONS

static NSString * const kNotificationApplyFilters = @"ApplyFiltersNotification";
static NSString * const kNotificationDismissFilterWithoutApply = @"DismissFilterWithoutApplyNotification";
static NSString * const kNotificationFilterProyectsChanged = @"FilterProyectsChangedNotification";
