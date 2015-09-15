//
//  ErrorConstants.h
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//
typedef enum {
    StatusCodeNoInternetConnection = -1,
    StatusCodeUnexpectedError = -2,
    StatusCodeRequestCancelled = -999,
    StatusCodeUnauthorized = 403,
    StatusCodeNotFound = 404,
    StatusCodeInternalServerError = 500
}ErrorCodes;

static NSString * const ERROR_NOTIFICATION_STATUS_CODE = @"StatusCode";
static NSString * const ERROR_NOTIFICATION_SHOW_ALERT_VIEW = @"ShowAlertView";