//
//  CustomerInfoViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"

@interface CustomerInfoViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) Customer* customerSelected;
@property (weak, nonatomic) IBOutlet UITableView *customerInfoTableView;

@end
