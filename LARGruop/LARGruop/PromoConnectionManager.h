//
//  PromoConnectionManager.h
//  LARGruop
//
//  Created by Piero on 1/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "BaseConnectionManager.h"

@interface PromoConnectionManager : BaseConnectionManager

+ (void)getAllPromosWithsuccess:(void (^) (NSDictionary *responseDictionary))success failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)cancelALLPromoRequest;
@end
