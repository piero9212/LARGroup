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
#import "Plant.h"
#import "Flat.h"
#import "Floor.h"
#import "FlatLegendTableViewCell.h"
#import "StatusCode.h"
#import "FlatPlantsViewController.h"

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
@end

@implementation ProyectDetailDepartamentsViewController
{
    NSInteger maxFloors;
    NSInteger maxFlatsPerFloor;
}
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
    maxFloors = selectedProyect.floorsCount.integerValue;
    self.proyectDepartments =[NSArray arrayWithArray:[selectedProyect.flats allObjects]];
    NSInteger floorWithMaxFlats =-1;
    for(int i = 0; i <self.proyectDepartments.count ; i++)
    {
        if(i==0)
        {
            floorWithMaxFlats = i;
        }
        else
        {
            Flat * currentFlat = self.proyectDepartments[i];
            Flat * lastFalt = self.proyectDepartments[i-1];
            if(currentFlat.floor.flats.count> lastFalt.floor.flats.count )
            {
                floorWithMaxFlats = i;
            }
            else
            {
                floorWithMaxFlats = i-1;
            }
        }
    }
    if(floorWithMaxFlats != -1)
    {
        Flat* maxFlat= self.proyectDepartments[floorWithMaxFlats];
        maxFlatsPerFloor = maxFlat.floor.flats.count;
    }
    [self.departmentCollectionView reloadData];
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
    return maxFloors+1;
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
    if(indexPath.item == maxFloors)
    {
        isSolidColor=false;
    }
    else
    {
        isSolidColor=true;
    }
    NSString* floorNumber = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [cell setupBottomHeaderCellsWithFloorNumber:floorNumber allItemsSolidColor:isSolidColor andFlatsArray:flats andMaxFlatsPerFloor:maxFlatsPerFloor];
    return cell;
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
    [cell setupCellWithLegendStatus:legendStatus andLegendName:legendName];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = self.departmentCollectionView.frame.size.height/(maxFloors+1);
    return CGSizeMake(self.departmentCollectionView.frame.size.width, height );
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)goToPlantsTapped:(UIButton *)sender {
    [self performSegueWithIdentifier:PLANTS_SEGUE sender:nil];
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
