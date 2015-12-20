//
//  CustomerInfoViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerInfoViewController.h"
#import "CustomerInterestLevelTableViewCell.h"
#import "Customer.h"

static NSString* const CUSTOMER_INFO_SELECTED_CELL= @"CUSTOMER_INFO_SELECTED_CELL";
static NSString* const CUSTOMER_RATING_SELECTED_CELL = @"CUSTOMER_RATING_SELECTED_CELL";

@interface CustomerInfoViewController ()

@property (nonatomic,strong) NSArray* sections;
@end

@implementation CustomerInfoViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupVars];
}
-(void)setupVars
{
    self.sections = [[NSArray alloc]initWithObjects:@"Nombre",@"Correo",@"Teléfono",@"Nivel de interes",@"Cotizaciones enviadas", nil];
}

-(void)getCustomersFromWebService
{
    
}

#pragma mark -
#pragma mark - Table View Delegate
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sections objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.sections)
        return 0;
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    Customer* selectedCustomer = [Customer MR_findByAttribute:@"uid" withValue:self.selectedCustomerUID].firstObject;
    if(selectedCustomer)
    {
        
        if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Nombre"])
        {
            cell =  [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_SELECTED_CELL forIndexPath:indexPath];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",selectedCustomer.firstName,selectedCustomer.lastName];
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Correo"])
        {
            cell =  [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_SELECTED_CELL forIndexPath:indexPath];
            cell.textLabel.text = selectedCustomer.email;
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Teléfono"])
        {
            cell =  [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_SELECTED_CELL forIndexPath:indexPath];
            cell.textLabel.text = selectedCustomer.phoneNumber;
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Nivel de interes"])
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMER_RATING_SELECTED_CELL forIndexPath:indexPath];
            ((CustomerInterestLevelTableViewCell*)cell).startRating.starImage = [UIImage imageNamed:@"unDot"];
            ((CustomerInterestLevelTableViewCell*)cell).startRating.starHighlightedImage = [UIImage imageNamed:@"dot"];
            ((CustomerInterestLevelTableViewCell*)cell).startRating.rating = selectedCustomer.interestLevel.floatValue;
            ((CustomerInterestLevelTableViewCell*)cell).startRating.maxRating = 3.0;
            ((CustomerInterestLevelTableViewCell*)cell).startRating.delegate = self;
            ((CustomerInterestLevelTableViewCell*)cell).startRating.horizontalMargin = 12;
            ((CustomerInterestLevelTableViewCell*)cell).startRating.editable=NO;
            ((CustomerInterestLevelTableViewCell*)cell).startRating.displayMode=EDStarRatingDisplayFull;
            
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Cotizaciones enviadas"])
        {
            cell =  [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_SELECTED_CELL forIndexPath:indexPath];
            NSArray* customerMarketRates = [NSArray arrayWithArray:[selectedCustomer.rates allObjects]];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)customerMarketRates.count];
        }

    }
    else
    {
        if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Nombre"])
        {
            cell =  [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_SELECTED_CELL forIndexPath:indexPath];
            cell.textLabel.text = @"Nombre Apellido";
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Correo"])
        {
            cell =  [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_SELECTED_CELL forIndexPath:indexPath];
            cell.textLabel.text = @"cliente@correo.com";
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Teléfono"])
        {
            cell =  [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_SELECTED_CELL forIndexPath:indexPath];
            cell.textLabel.text = @"999666999";
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Nivel de interes"])
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMER_RATING_SELECTED_CELL forIndexPath:indexPath];
            ((CustomerInterestLevelTableViewCell*)cell).startRating.starImage = [UIImage imageNamed:@"unDot"];
            ((CustomerInterestLevelTableViewCell*)cell).startRating.starHighlightedImage = [UIImage imageNamed:@"dot"];
            ((CustomerInterestLevelTableViewCell*)cell).startRating.rating = 0;
            ((CustomerInterestLevelTableViewCell*)cell).startRating.maxRating = 3.0;
            ((CustomerInterestLevelTableViewCell*)cell).startRating.delegate = self;
            ((CustomerInterestLevelTableViewCell*)cell).startRating.horizontalMargin = 12;
            ((CustomerInterestLevelTableViewCell*)cell).startRating.editable=NO;
            ((CustomerInterestLevelTableViewCell*)cell).startRating.displayMode=EDStarRatingDisplayFull;

            
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Cotizaciones enviadas"])
        {
            cell =  [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_SELECTED_CELL forIndexPath:indexPath];
            cell.textLabel.text = @"0";
        }
        
    }
    return cell;
}




#pragma mark -
#pragma mark - Actions
#pragma mark -


@end
