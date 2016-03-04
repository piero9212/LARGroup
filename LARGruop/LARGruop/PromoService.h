//
//  PromoService.h
//  LARGruop
//
//  Created by Piero on 29/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "GenericService.h"

@interface PromoService : GenericService

+ (PromoService *)sharedService;
- (void)cancelAllPromoRequest;
+ (void)setFilterProyects:(NSMutableArray *)filterPromos;

- (NSArray *)getAllPromos;
- (void)apiGetPromosWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion;
@end
