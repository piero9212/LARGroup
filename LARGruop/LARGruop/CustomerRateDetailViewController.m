//
//  CustomerRateDetailViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 21/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerRateDetailViewController.h"
#import "Proyect.h"
#import "FlatFeature.h"
#import "Flat.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Promo.h"

static NSString* const CUSTOMER_MARKET_RATE_FEATURE_CELL = @"CUSTOMER_MARKET_RATE_FEATURE_CELL";

@interface CustomerRateDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rateNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *proyectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIView *redShapeView;
@property (weak, nonatomic) IBOutlet UIView *yellowShapeView;
@property (weak, nonatomic) IBOutlet UIView *greenShapeView;
@property (weak, nonatomic) IBOutlet UILabel *promotionLabel;
@property (weak, nonatomic) IBOutlet UITableView *marketRateFeaturesTableView;
@property (strong,nonatomic) NSMutableArray* features;
@property (strong,nonatomic) NSArray* featuresTitles;
@end

@implementation CustomerRateDetailViewController
{
    Flat* flat;
    Promo* promo;
}

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupViews];
    [self setupVars];
}

-(void)setupViews
{
    float radius = self.redShapeView.frame.size.width/2;
    self.redShapeView.layer.cornerRadius = self.yellowShapeView.layer.cornerRadius= self.greenShapeView.layer.cornerRadius=  radius;
    self.redShapeView.layer.borderWidth = self.yellowShapeView.layer.borderWidth = self.greenShapeView.layer.borderWidth = 2.0f;
    self.redShapeView.layer.borderColor = [UIColor LARRedColor].CGColor;
    self.greenShapeView.layer.borderColor = [UIColor LARGreenColor].CGColor;
    self.yellowShapeView.layer.borderColor = [UIColor LARYellowColor].CGColor;
    
    
    flat = [Flat MR_findByAttribute:@"uid" withValue:self.quote.flatID].firstObject;
    
    Proyect* proyect = [Proyect MR_findByAttribute:@"uid" withValue:flat.projectUID].firstObject;
    self.proyectNameLabel.text = [NSString stringWithFormat:@"Proyecto %@",proyect.name];
    self.rateNameLabel.text = [NSString stringWithFormat:@"Cotización 0%@",self.quote.uid];
    self.codeLabel.text = self.quote.uid;
    promo = [Promo MR_findByAttribute:@"uid" withValue:self.quote.promoID].firstObject;
    if(!promo)
        self.promotionLabel.text = @"-----";
    else
        self.promotionLabel.text = promo.name;
    self.redShapeView.backgroundColor = [UIColor colorForInterestLevel:self.quote.interestLevel.integerValue andColorShape:[UIColor redColor]];
    self.yellowShapeView.backgroundColor = [UIColor colorForInterestLevel:self.quote.interestLevel.integerValue andColorShape:[UIColor yellowColor]];
    self.greenShapeView.backgroundColor = [UIColor colorForInterestLevel:self.quote.interestLevel.integerValue andColorShape:[UIColor greenColor]];
}

-(void)setupVars
{
    self.featuresTitles = [flat.features allObjects];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
}

#pragma mark -
#pragma mark - Table View Delegate
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.featuresTitles)
        return 0;
    else
    {
        return self.featuresTitles.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.marketRateFeaturesTableView dequeueReusableCellWithIdentifier:CUSTOMER_MARKET_RATE_FEATURE_CELL forIndexPath:indexPath];
    
    FlatFeature* feature = [self.featuresTitles objectAtIndex:indexPath.row];
    cell.textLabel.text = feature.featureDescription;
    cell.detailTextLabel.text=  @"";
    return cell;
}



#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)cancelChanges:(id)sender {
    [self dismissAnimated];
}

- (IBAction)updateQuote:(UIButton *)sender {
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

-(void)dismissAnimated
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
