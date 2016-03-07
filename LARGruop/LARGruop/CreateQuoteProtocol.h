//
//  CreateQuoteProtocol.h
//  LARGruop
//
//  Created by Piero on 6/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Customer;
@protocol CreateQuoteProtocol <NSObject>

-(void)changeReserveViewControllerWithCustomer:(Customer*)selectedCustomer;

@end
