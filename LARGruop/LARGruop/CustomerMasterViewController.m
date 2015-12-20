//
//  CustomerMasterViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerMasterViewController.h"
#import <CGLAlphabetizer/CGLAlphabetizer.h>
#import "Customer.h"

static NSString* const CUSTOMER_INFO_CELL = @"CUSTOMER_INFO_CELL";
static NSString* const CUSTOMER_DETAIL_SEGUE = @"CUSTOMER_DETAIL_SEGUE";
@interface CustomerMasterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *customerTableView;
@property (nonatomic) NSDictionary *alphabetizedDictionary;
@property NSMutableArray *customers;
@property NSArray *sections;
@end

@implementation CustomerMasterViewController

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
    [self setupNotifications];
    [self setupTable];
}

-(void)setupTable
{
     self.customers = [[NSMutableArray alloc]initWithArray:[Customer MR_findAll]];
    self.alphabetizedDictionary = [CGLAlphabetizer alphabetizedDictionaryFromObjects:_customers usingKeyPath:@"lastName"];
    self.sections = [CGLAlphabetizer indexTitlesFromAlphabetizedDictionary:self.alphabetizedDictionary];
    
    [self.customerTableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setupDeallocNotifications];
}

-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getClientsSucced:) name:kNotificationAllClientsSucced object:nil];
}

-(void)setupDeallocNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationAllClientsSucced object:nil];
}

#pragma mark -
#pragma mark - Table View Delegate
#pragma mark - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sections;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index
{
    return index;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sections objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.customers)
        return 0;
    else
    {
        NSString *sectionIndexTitle = self.sections[section];
        return [self.alphabetizedDictionary[sectionIndexTitle] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_CELL forIndexPath:indexPath];
    
    Customer *customer = [self objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",customer.firstName,customer.lastName];
    return cell;
}

#pragma mark - API & Notifications

-(void)getClientsSucced:(NSNotification*)notification
{
    [self setupTable];
    if(self.customers && self.customers.count>0)
    {
        [self.customerTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:true scrollPosition:UITableViewScrollPositionMiddle];
        [self performSegueWithIdentifier:CUSTOMER_DETAIL_SEGUE sender:self];

    }
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

- (Customer *)objectAtIndexPath:(NSIndexPath *)indexPath {
    NSString *sectionIndexTitle = self.sections[indexPath.section];
    return self.alphabetizedDictionary[sectionIndexTitle][indexPath.row];
}

#pragma mark -
#pragma mark - Navigation
#pragma mark - 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:CUSTOMER_DETAIL_SEGUE]) {
        NSIndexPath *indexPath = [self.customerTableView indexPathForSelectedRow];
        Customer *object = [self objectAtIndexPath:indexPath];
        CustomerDetailViewController *controller = (CustomerDetailViewController *)[[segue destinationViewController] topViewController];
        [controller setSelectedCustomerUID:object.uid];
        [controller reloadTable];
    }
}

@end
