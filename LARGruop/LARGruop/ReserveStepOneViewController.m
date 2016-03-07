//
//  ReserveStepOneViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "ReserveStepOneViewController.h"
#import "Floor.h"
#import "StatusCode.h"
#import "Customer.h"
#import "UIConstants.h"
#import "ClientService.h"

@interface ReserveStepOneViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UISwitch *printSwitch;
@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;
@property (strong, nonatomic) NSArray *items;
@property (strong,nonatomic) Customer* selectedCustomer;
@end

@implementation ReserveStepOneViewController

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
    self.items = [[ClientService sharedService] getAllClients];
    [self.itemsTableView reloadData];
    self.nextButton.layer.cornerRadius= 10;
    self.nextButton.layer.borderWidth  = 1;
    self.nextButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.selectedCustomer = nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
}

#pragma mark -
#pragma mark - IBAction
#pragma mark -

- (IBAction)nextTapped:(UIButton *)sender {
    if(self.selectedCustomer)
    {
        [self.delegate changeReserveViewControllerWithCustomer:self.selectedCustomer];
    }
}

#pragma mark -
#pragma mark - Table View Data Source & Delegate
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMER_QUOTE_IDENTIFIER forIndexPath:indexPath];
    
    Customer* customer = [self.items objectAtIndex:indexPath.row];
    NSString* name = [NSString stringWithFormat:@"%@ %@",customer.firstName,customer.lastName];
    cell.textLabel.text = name;
//    cell.text = [NSString stringWithFormat:@"Piso 0%@",self.selectedFlat.floor.number];
//    UIColor* statusColor = [UIColor colorForDepartmentsStatus:self.selectedFlat.status.integerValue];
//    NSString* statusName;
//    switch (self.selectedFlat.status.integerValue) {
//        case StatusCodeFree:
//            statusName = @"Libre";
//            break;
//        case StatusCodeReserved:
//            statusName = @"Separada";
//            break;
//        case StatusCodeContract:
//            statusName = @"Contrato (Minuta)";
//            break;
//        case StatusCodesWrited:
//            statusName = @"Escriturado";
//            break;
//        case StatusCodeBlocked:
//            statusName = @"Bloqueado";
//            break;
//    }
//    [self.floorStatusLabel setText:statusName];
//    [self.floorStatusLabel setTextColor:statusColor];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Customer* customer = [self.items objectAtIndex:indexPath.row];
    self.selectedCustomer=customer;
}

@end
