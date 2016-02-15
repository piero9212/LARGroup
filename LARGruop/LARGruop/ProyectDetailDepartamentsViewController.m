//
//  ProyectDetailDepartamentsViewController.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailDepartamentsViewController.h"
#import "DepartmentCollectionViewCell.h"
#import "Proyect.h"
#import "Plant.h"
#import "Flat.h"
#import "Floor.h"

static NSString* const DEPARTAMENT_SQUARE_CELL = @"DEPARTAMENT_SQUARE_CELL";

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
    if(!self.proyectDepartments)
        return 0;
    else
        return maxFlatsPerFloor+1;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:@"DepartmentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:DEPARTAMENT_SQUARE_CELL];
    DepartmentCollectionViewCell* cell = [self.departmentCollectionView dequeueReusableCellWithReuseIdentifier:DEPARTAMENT_SQUARE_CELL forIndexPath:indexPath];
    NSString* floorNumber;
    BOOL isSolidColor;
    UIColor* color;
    Flat* flat = [self.proyectDepartments objectAtIndex:indexPath.item];
    if(indexPath.row == self.proyectDepartments.count-1 || indexPath.item == 0) // INDEX
    {
        isSolidColor = false;
        UIColor* color = [UIColor clearColor];
    }
    else
    {
        isSolidColor = true;
        UIColor* color = flat.status;//
    }
    [cell setupCellWithFloorNumber:floorNumber color:color isSolidColor:isSolidColor];
    return cell;
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
