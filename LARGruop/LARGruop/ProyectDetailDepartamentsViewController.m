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
    [NSPredicate predicateWithFormat:@"SELF.floor.number == %d",indexPath.item];
    NSArray *flats =
    [self.proyectDepartments filteredArrayUsingPredicate:floorPredicate];
    BOOL isHeader;
    if(indexPath.item == 0)
    {
        isHeader=true;
    }
    else
    {
        isHeader=false;
    }
    NSString* floorNumber = [NSString stringWithFormat:@"%ld",indexPath.row];
    [cell setupBottomHeaderCellsWithFloorNumber:floorNumber allItemsSolidColor:isHeader andFlatsArray:flats andMaxFlatsPerFloor:maxFlatsPerFloor];
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
        case 0:
            legendName = @"Libre";
            break;
        case 1:
            legendName = @"Separada";
            break;
        case 2:
            legendName = @"Contrato (Minuta)";
            break;
        case 3:
            legendName = @"Escriturado";
            break;
        case 4:
            legendName = @"Bloqueado";
            break;
    }
    [cell setupCellWithLegendStatus:legendStatus andLegendName:legendName];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.departmentCollectionView.frame.size.width, self.departmentCollectionView.frame.size.height/(maxFloors+1));
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    UIEdgeInsets insets;
//    if(self.proyectPlants && self.proyectPlants.count!=0)
//    {
//        float space = self.containerSize.width/(self.proyectPlants.count);
//        space = space+20;
//        insets = UIEdgeInsetsMake(10, space, 0, space);
//    }
//    else
//        insets  = UIEdgeInsetsMake(10, 10, 0, 10);
//    
//    return  insets;
//    
//}
@end
