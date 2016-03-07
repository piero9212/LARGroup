//
//  QuoteConfirmationViewController.m
//  LARGruop
//
//  Created by Piero on 7/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "QuoteConfirmationViewController.h"
#import "QuotesService.h"

@interface QuoteConfirmationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *quoteNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *quoteDetailLabel;
@end

@implementation QuoteConfirmationViewController

#pragma mark -
#pragma mark - View Life Cicle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, _popOverViewSize.width, _popOverViewSize.height);
    
    self.view.superview.layer.cornerRadius  = 5.0;
    self.view.superview.layer.masksToBounds = YES;
}

- (IBAction)aceptTapped:(UIButton *)sender {
    [self showHUDOnView:self.view];
    [[QuotesService sharedService] apiCreateQuoteWithClientID:self.selectedCustomer.uid departamentID:self.selectedFlat.uid errorAlertView:NO userInfo:nil andCompletionHandler:^(BOOL succeeded) {
        if(succeeded)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:TRUE completion:nil];
                [self hideHUDOnView:self.view];
            });
        }
    }];
    
}

- (IBAction)cancelTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

@end
