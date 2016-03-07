//
//  QuoteConfirmationViewController.h
//  LARGruop
//
//  Created by Piero on 7/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import "Flat.h"
#import "Customer.h"
#import "Promo.h"

@interface QuoteConfirmationViewController : BaseViewController

@property (readwrite) CGSize popOverViewSize;
@property (strong,nonatomic) Flat* selectedFlat;
@property (strong,nonatomic) Customer* selectedCustomer;
@property (strong,nonatomic) Promo* selectedPromo;

@end
