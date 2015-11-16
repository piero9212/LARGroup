//
//  ErrorCodes.h
//  LARGruop
//
//  Created by Piero on 11/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

typedef enum {
    StatusCodeNoInternetConnection = -1,
    StatusCodeUnexpectedError = -2,
    StatusCodeRequestCancelled = -999,
    StatusCodeUnauthorized = 403,
    StatusCodeNotFound = 404,
    StatusCodeInternalServerError = 500
}ErrorCodes;