//
//  ReserveStepOneViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import "Flat.h"
#import "CreateQuoteProtocol.h"
@interface ReserveStepOneViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) Flat* selectedFlat;

@property (weak,nonatomic) id<CreateQuoteProtocol> delegate;
@end
