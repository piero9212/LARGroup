//
//  ReserveStepTwoViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import "Flat.h"
#import "CreateQuoteProtocol.h"
#import "Customer.h"
#import "Promo.h"

@interface ReserveStepTwoViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) Flat* selectedFlat;
@property (strong,nonatomic) Customer* selectedCustomer;
@property (strong,nonatomic) Promo* randomPromo;
@property (weak,nonatomic) id<CreateQuoteProtocol> delegate;
@end
