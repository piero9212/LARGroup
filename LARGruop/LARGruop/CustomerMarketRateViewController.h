//
//  CustomerMarketRateViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"

@interface CustomerMarketRateViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *customerMarketRatesTableView;
@property (nonatomic,strong) Customer* selectedCustomer;

@property (nonatomic) CGSize containerSize;
@end
