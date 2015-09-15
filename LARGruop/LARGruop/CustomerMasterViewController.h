//
//  CustomerMasterViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerDetailViewController.h"

@interface CustomerMasterViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) CustomerDetailViewController *detailViewController;

@end
