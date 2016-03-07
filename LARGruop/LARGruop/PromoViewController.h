//
//  PromoViewController.h
//  LARGruop
//
//  Created by Piero on 6/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import "Flat.h"
#import "Promo.h"
#import "Customer.h"

@interface PromoViewController : BaseViewController


@property (readwrite) CGSize popOverViewSize;
@property (strong,nonatomic) Flat* selectedFlat;
@property (strong,nonatomic) Customer* selectedCustomer;
@property (strong,nonatomic) Promo* selectedPromo;
@end
