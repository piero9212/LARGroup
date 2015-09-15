//
//  CustomerInfoViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerInfoViewController.h"

static NSString* const CUSTOMER_INFO_SELECTED_CELL= @"CUSTOMER_INFO_SELECTED_CELL";

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
        if(!self.sections || section != self.sections.count-1)
            return 1;
        else
            return 3;//TODO, RETURN THE NUMBER OF MARKET RATES OF CUSTOMER CLASS ARRAY
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_SELECTED_CELL forIndexPath:indexPath];
    
    if(self.customerSelected)
    {
        if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Nombre"])
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",self.customerSelected.firstName,self.customerSelected.lastName];
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Correo"])
        {
            cell.textLabel.text = self.customerSelected.email;
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Teléfono"])
        {
            cell.textLabel.text = self.customerSelected.phoneNumber;
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Nivel de interes"])
        {
            cell.textLabel.text = self.customerSelected.interestLevel.stringValue;
            
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Cotizaciones enviadas"])
        {
            cell.textLabel.text = @"asd";
        }

    }
    else
    {
        if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Nombre"])
        {
            cell.textLabel.text = @"Nombre Apellido";
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Correo"])
        {
            cell.textLabel.text = @"cliente@correo.com";
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Teléfono"])
        {
            cell.textLabel.text = @"999666999";
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Nivel de interes"])
        {
            cell.textLabel.text = @"0";
            
        }
        else if([[self.sections objectAtIndex:indexPath.section] isEqual:@"Cotizaciones enviadas"])
        {
            cell.textLabel.text = @"Cotizaciones";
        }
        
    }
    return cell;
}




#pragma mark -
#pragma mark - Actions
#pragma mark -


@end
