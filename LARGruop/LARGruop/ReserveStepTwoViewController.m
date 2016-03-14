//
//  ReserveStepTwoViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "ReserveStepTwoViewController.h"
#import "FlatFeature.h"
#import "UIConstants.h"
#import "PromoViewController.h"
#import "QuoteConfirmationViewController.h"

@interface ReserveStepTwoViewController()
@property (weak, nonatomic) IBOutlet UILabel *clientNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *clientLastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *clientDNILabel;
@property (weak, nonatomic) IBOutlet UILabel *clientEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *clientCellPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *flatNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UITableView *featuresTableView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (nonatomic,strong) NSArray* featuresTitles;
@property (weak, nonatomic) IBOutlet UILabel *promoLabel;
@property (nonatomic) BOOL promoViwed;

@end


@implementation ReserveStepTwoViewController

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
    [self setupNotifications];
    self.promoViwed = false;
    self.infoView.layer.borderWidth = self.headerView.layer.borderWidth = 1;
    self.clientNameLabel.text = self.selectedCustomer.firstName;
    self.clientLastNameLabel.text = self.selectedCustomer.lastName;
    self.clientDNILabel.text = self.selectedCustomer.dni.stringValue;
    self.clientEmailLabel.text = self.selectedCustomer.email;
    self.clientCellPhoneLabel.text = self.selectedCustomer.phoneNumber;
    self.flatNameLabel.text = [NSString stringWithFormat:@"Departamento %@",self.selectedFlat.name];
    self.sizeLabel.text = self.selectedFlat.size;
    self.featuresTitles = [self.selectedFlat.features allObjects];
    self.sendButton.layer.cornerRadius= 10;
    self.promoLabel.text = [NSString stringWithFormat:@"Promoción %@",self.randomPromo.name];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self deallocNotifications];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
}


-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(promoAceptedTapped:)
                                                 name:kNotificationPromoAcepted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(promoCancelTapped:)
                                                 name:kNotificationPromoCancel object:nil];
}

-(void)deallocNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:kNotificationPromoAcepted];
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:kNotificationPromoCancel];
}

#pragma mark -
#pragma mark - Table View Data Sorce & Delegate
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.featuresTitles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:FLAT_FEATURE_QUOTE_CELL forIndexPath:indexPath];
    FlatFeature* feature = [self.featuresTitles objectAtIndex:indexPath.row];
    cell.textLabel.text = feature.featureDescription;
    return cell;
}

- (IBAction)sendTapped:(UIButton *)sender {
    if(self.promoViwed)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        QuoteConfirmationViewController *quoteViewController = [storyboard instantiateViewControllerWithIdentifier:@"QuoteConfirmationViewController"];
        quoteViewController.selectedCustomer = self.selectedCustomer;
        quoteViewController.selectedPromo = self.randomPromo;
        quoteViewController.selectedFlat = self.selectedFlat;
        quoteViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:quoteViewController animated:YES completion:nil];
        
        CGSize temporalPopoverSize = CGSizeMake(300.0f, 300.0f);
        [quoteViewController setPopOverViewSize:temporalPopoverSize];

    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PromoViewController *promoViewController = [storyboard instantiateViewControllerWithIdentifier:@"PromoViewController"];
        promoViewController.selectedCustomer = nil;
        promoViewController.selectedPromo = self.randomPromo;
        promoViewController.selectedFlat = nil;
        promoViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:promoViewController animated:YES completion:nil];
        
        CGSize temporalPopoverSize = CGSizeMake(300.0f, 400.0f);
        [promoViewController setPopOverViewSize:temporalPopoverSize];
    }
}

-(void)promoAceptedTapped:(NSNotification*)notification
{
    [self.promoLabel setHidden:false];
    self.promoViwed = TRUE;
}

-(void)promoCancelTapped:(NSNotification*)notification
{
    [self.promoLabel setHidden:TRUE];
    self.promoViwed = TRUE;
    self.randomPromo = nil;
}
@end
