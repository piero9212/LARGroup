//
//  ProyectDetailDepartamentsViewController.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailDepartamentsViewController.h"
#import "FlatGroupCollectionViewCell.h"
#import "Proyect.h"
#import "Flat.h"
#import "Floor.h"
#import "FlatLegendTableViewCell.h"
#import "StatusCode.h"
#import "FlatPlantsViewController.h"
#import "FlatReserveContainerViewController.h"
#import "CustomNavigationViewController.h"

static NSString* const DEPARTAMENT_SQUARE_LEGEND_CELL = @"DEPARTAMENT_SQUARE_LEGEND_CELL";
static NSString* const DEPARTAMENT_LINES_CELL = @"DEPARTAMENT_LINES_CELL";

@interface ProyectDetailDepartamentsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *legendTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *departmentCollectionView;
@property (strong,nonatomic) NSArray* proyectFloors;
@property (strong,nonatomic) NSArray* proyectDepartments;
@property (strong,nonatomic) NSArray* leyendItems;
@property (weak, nonatomic) IBOutlet UILabel *proyectNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *proyectActionButton;
@property (weak, nonatomic) IBOutlet UIButton *plantButton;
@property (strong, nonatomic) CustomNavigationViewController* customNavigationController;
@property (nonatomic,strong) NSNumber* maxFloors;
@property (nonatomic,strong) NSNumber* maxFlatsPerFloor;
@end

@implementation ProyectDetailDepartamentsViewController

#pragma mark -
#pragma mark - View Life Cicle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupVars];
    [self setupViews];
}

-(void)setupViews{
    CGRect frame = self.view.frame;
    frame.size.width = self.containerSize.width;
    frame.size.height = self.containerSize.height;
    self.view.frame = frame;
}

-(void)setupVars
{
    Proyect* selectedProyect = [Proyect MR_findFirstByAttribute:@"uid" withValue:self.selectedProyectID];
    self.plantButton.layer.borderWidth = 3.0;
    self.plantButton.layer.borderColor = [UIColor orangeLARColor].CGColor;
    self.plantButton.layer.cornerRadius = 20;
    self.plantButton.layer.masksToBounds = true;
    [self.proyectNameLabel setText:[NSString stringWithFormat:@"Proyecto %@",selectedProyect.name]];
    self.maxFloors = selectedProyect.floorsCount;
    NSLog(@"%ld",self.maxFloors.integerValue);
    NSArray* floors = [selectedProyect.floors allObjects];
    NSMutableArray* flats = [[NSMutableArray alloc]init];
    self.maxFlatsPerFloor = nil;
    for (Floor* proyectFloor in floors) {
        NSArray* flatsPerFloor = [proyectFloor.flats allObjects];
        if(!self.maxFlatsPerFloor)
        {
            self.maxFlatsPerFloor = [NSNumber numberWithInteger:flatsPerFloor.count];
        }
        else
        {
            if(flatsPerFloor.count>self.maxFlatsPerFloor.intValue)
                self.maxFlatsPerFloor = [NSNumber numberWithInteger:flatsPerFloor.count];
        }
        [flats addObjectsFromArray:flatsPerFloor];
    }
    self.proyectDepartments = flats;
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    self.proyectDepartments=[self.proyectDepartments sortedArrayUsingDescriptors:@[sort]];
    [self.departmentCollectionView reloadData];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
}

#pragma mark -
#pragma mark - Collection View Delegate
#pragma mark -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.maxFloors.integerValue+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:@"FlatGroupCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:DEPARTAMENT_LINES_CELL];
    FlatGroupCollectionViewCell* cell = [self.departmentCollectionView dequeueReusableCellWithReuseIdentifier:DEPARTAMENT_LINES_CELL forIndexPath:indexPath];
    
    NSPredicate *floorPredicate =
    [NSPredicate predicateWithFormat:@"SELF.floor.number == %d",indexPath.item+1];
    NSArray *flats =
    [self.proyectDepartments filteredArrayUsingPredicate:floorPredicate];
    BOOL isSolidColor;
    if(indexPath.item == self.maxFloors.integerValue)
    {
        isSolidColor=false;
    }
    else
    {
        isSolidColor=true;
    }
    NSString* floorNumber = [NSString stringWithFormat:@"%ld",indexPath.item+1];
    [cell setupBottomHeaderCellsWithFloorNumber:floorNumber allItemsSolidColor:isSolidColor andFlatsArray:flats andMaxFlatsPerFloor:self.maxFlatsPerFloor.integerValue];
    cell.flatDelegate=self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 30;
    return CGSizeMake(self.departmentCollectionView.frame.size.width, height );
}

#pragma mark -
#pragma mark - Table View Delegate
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerNib:[UINib nibWithNibName:@"FlatLegendTableViewCell" bundle:nil] forCellReuseIdentifier:DEPARTAMENT_SQUARE_LEGEND_CELL];
    FlatLegendTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:DEPARTAMENT_SQUARE_LEGEND_CELL];
    NSString* legendName =@"";
    NSInteger legendStatus = indexPath.row;
    switch (indexPath.row) {
        case StatusCodeFree:
            legendName = @"Libre";
            break;
        case StatusCodeReserved:
            legendName = @"Separada";
            break;
        case StatusCodeContract:
            legendName = @"Contrato (Minuta)";
            break;
        case StatusCodesWrited:
            legendName = @"Escriturado";
            break;
        case StatusCodeBlocked:
            legendName = @"Bloqueado";
            break;
    }
    cell.backgroundColor = [UIColor clearColor];
    [cell setupCellWithLegendStatus:legendStatus andLegendName:legendName];
    return cell;
}

#pragma mark -
#pragma mark - Flat Detail Protocol
#pragma mark -

- (void)presentFlatModalDetailWithFlat:(Flat*)flat
{
    [self performSegueToFlatDetailWithFlat:flat];
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)goToPlantsTapped:(UIButton *)sender {
    [self.proyectDelegate changeChildViewController];
}


-(void)performSegueToFlatDetailWithFlat:(Flat*)flat
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.customNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"CustomNavigationViewController"];
    FlatReserveContainerViewController *flatContainerViewController = (FlatReserveContainerViewController *)self.customNavigationController.topViewController;
    flatContainerViewController.delegate = self;
    flatContainerViewController.selectedFlat = flat;
    [self.customNavigationController setCustomViewSize:CGSizeMake(450.0f, 450.0f)];
    self.customNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    self.customNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:self.customNavigationController animated:YES completion:nil];
}

#pragma mark -
#pragma mark - Flat Container Protocol
#pragma mark -

- (void)flatContainerViewControllerupdateToNormalSize:(FlatReserveContainerViewController *)sender
{
    if (self.customNavigationController) {
        [self.customNavigationController setCustomViewSize:CGSizeMake(450.0f, 450.0f)];
        [self.customNavigationController updateViewSize];
    }
    
}

- (void)flatContainerViewControllerupdateToExpandedSize:(FlatReserveContainerViewController *)sender
{
    if (self.customNavigationController) {
        CGSize size = CGSizeMake(screenWidth, screenHeight);
        [self.customNavigationController setCustomViewSize:size];
        [self.customNavigationController updateViewSize];
    }
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[FlatPlantsViewController class]])
    {
        FlatPlantsViewController* destinationVC = segue.destinationViewController;
        destinationVC.selectedProyectID = self.selectedProyectID;
        destinationVC.containerSize = self.containerSize;
    }
}
@end
