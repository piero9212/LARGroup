//
//  NewCustomerViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"

@interface NewCustomerViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>

@property (readwrite) CGSize popOverViewSize;
@end
