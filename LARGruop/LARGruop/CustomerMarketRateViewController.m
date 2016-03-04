//
//  CustomerMarketRateViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerMarketRateViewController.h"
#import "CustomerRateDetailViewController.h"
#import "Customer.h"
#import "Quote.h"

static NSString* const CUSTOMER_MARKET_RATES_CELL = @"CUSTOMER_MARKET_RATES_CELL";
static NSString* const MARKET_RATE_DETAIL_SEGUE = @"MARKET_RATE_DETAIL_SEGUE";

@interface  CustomerMarketRateViewController ()
@property (nonatomic,strong) NSArray* marketRates;
@end

@implementation CustomerMarketRateViewController

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
    [self setupVars];
    
    CGRect frame = self.view.frame;
    frame.size.width = self.containerSize.width;
    frame.size.height = self.containerSize.height;
    self.view.frame = frame;
}

-(void)setupVars
{
    Customer* customer = [Customer MR_findByAttribute:@"uid" withValue:self.selectedCustomerUID].firstObject;
    Quote* quote = customer.quote;
    self.marketRates = [[NSArray alloc]initWithObjects:quote, nil];
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
    if(!self.marketRates)
        return 0;
    else
    {
        return self.marketRates.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.customerMarketRatesTableView dequeueReusableCellWithIdentifier:CUSTOMER_MARKET_RATES_CELL forIndexPath:indexPath];
    
    Quote* rate = [self.marketRates objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Cotización 0%@",rate.uid];
    NSString* status;
    switch (rate.interestLevel.integerValue) {
        case 1:
            status = @"No esta interesado";
            break;
        case 2:
            status = @"Negociación";
            break;
        case 3:
            status = @"Va a comprar";
            break;
        default:
            status = @"No esta interesado";
            break;
    }
    cell.detailTextLabel.text = status;
    cell.detailTextLabel.textColor = [UIColor colorForInterestLevel:rate.interestLevel.integerValue];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    Quote* rate = [self.marketRates objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:MARKET_RATE_DETAIL_SEGUE sender:rate];
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[CustomerRateDetailViewController class]])
    {
        CustomerRateDetailViewController* destinatopnVC = segue.destinationViewController;
        destinatopnVC.quote = (Quote*)sender;
    }
}


@end
