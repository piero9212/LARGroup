//
//  CustomerMasterViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerMasterViewController.h"

static NSString* const CUSTOMER_INFO_CELL = @"CUSTOMER_INFO_CELL";
static NSString* const CUSTOMER_DETAIL_SEGUE = @"CUSTOMER_DETAIL_SEGUE";
@interface CustomerMasterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *customerTableView;
@property NSMutableArray *customers;
@end

@implementation CustomerMasterViewController

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

#pragma mark -
#pragma mark - Table View Delegate
#pragma mark - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.customers)
        return 0;
    else
        return self.customers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMER_INFO_CELL forIndexPath:indexPath];
    
    NSString *object = self.customers[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.customers removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
#pragma mark -
#pragma mark - Navigation
#pragma mark - 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:CUSTOMER_DETAIL_SEGUE]) {
        NSIndexPath *indexPath = [self.customerTableView indexPathForSelectedRow];
        NSDate *object = self.customers[indexPath.row];
        CustomerDetailViewController *controller = (CustomerDetailViewController *)[[segue destinationViewController] topViewController];
       // [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

@end
