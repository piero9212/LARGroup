//
//  ClientTranslator.h
//  LARGruop
//
//  Created by Piero on 29/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"
@interface ClientTranslator : NSObject

+ (void)clientDictionary:(NSDictionary *)clientDictionary toCustomerEntity:(Customer *)client context:(NSManagedObjectContext *)context;

@end
