//
//  ReserveViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import "Flat.h"
#import "CreateQuoteProtocol.h"
#import "Promo.h"

@interface ReserveViewController : BaseViewController <CreateQuoteProtocol>

@property (strong,nonatomic) Flat* selectedFlat;
@property (strong,nonatomic) Promo* randomPromo;


@end
