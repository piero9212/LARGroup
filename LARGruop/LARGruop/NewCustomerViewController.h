//
//  NewCustomerViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
@class Customer;

@interface NewCustomerViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>

@property (readwrite) CGSize popOverViewSize;
@property (nonatomic,strong) Customer* selectedCustomer;
@end
