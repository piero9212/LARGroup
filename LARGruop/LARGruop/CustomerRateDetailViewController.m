//
//  CustomerRateDetailViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 21/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerRateDetailViewController.h"

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
    [self setupViews];
    [self setupVars];
}

-(void)setupViews
{
    float radius = self.redShapeView.frame.size.width/2;
    self.redShapeView.layer.cornerRadius = self.yellowShapeView.layer.cornerRadius= self.greenShapeView.layer.cornerRadius=  radius;
    self.redShapeView.layer.borderWidth = self.yellowShapeView.layer.borderWidth = self.greenShapeView.layer.borderWidth = 1.0f;
    self.redShapeView.layer.borderColor = [UIColor redColor].CGColor;
    self.greenShapeView.layer.borderColor = [UIColor greenColor].CGColor;
    self.yellowShapeView.layer.borderColor = [UIColor yellowColor].CGColor;
    self.proyectNameLabel.text = [NSString stringWithFormat:@"Proyecto %@",self.rate.proyect.name];
    self.rateNameLabel.text = self.rate.name;
    self.codeLabel.text = self.rate.marketRateID;
    self.promotionLabel.text = self.rate.promo;
    switch (self.rate.interestLevel.integerValue) {
        case 1:
            self.redShapeView.backgroundColor = [UIColor redColor];
            self.yellowShapeView.backgroundColor = [UIColor clearColor];
            self.greenShapeView.backgroundColor = [UIColor clearColor];
            break;
        case 2:
            self.yellowShapeView.backgroundColor = [UIColor yellowColor];
            self.redShapeView.backgroundColor = [UIColor clearColor];
            self.greenShapeView.backgroundColor = [UIColor clearColor];
            break;
        case 3:
            self.greenShapeView.backgroundColor = [UIColor greenColor];
            self.redShapeView.backgroundColor = [UIColor clearColor];
            self.yellowShapeView.backgroundColor = [UIColor clearColor];
            break;
        default:
            break;
    }
}

-(void)setupVars
{
    self.featuresTitles = [[NSArray alloc]initWithObjects:@"Planta",@"Área total",@"Dormitorios",@"Baños",@"Cocina",@"Sala",@"Comedor",@"Closets",@"Lavanderia", nil];
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
    
    NSString* feature = [self.featuresTitles objectAtIndex:indexPath.row];
    cell.textLabel.text = feature;
    cell.detailTextLabel.text = @"Probando el tamano de los textos";
    
    return cell;
}



#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)cancelChanges:(id)sender {
    [self dismissAnimated];
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

-(void)dismissAnimated
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
