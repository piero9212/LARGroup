//
//  CustomerDetailViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"

@interface CustomerDetailViewController : BaseViewController

@property (strong, nonatomic) NSString* selectedCustomerUID;
-(void)reloadTable;
@end
