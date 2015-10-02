//
//  CustomerInfoViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import <EDStarRating/EDStarRating.h>

@interface CustomerInfoViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,EDStarRatingProtocol>

@property (nonatomic,strong) NSString* selectedCustomerUID;
@property (weak, nonatomic) IBOutlet UITableView *customerInfoTableView;

@end
