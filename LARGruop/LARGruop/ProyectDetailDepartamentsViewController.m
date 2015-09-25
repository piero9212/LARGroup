//
//  ProyectDetailDepartamentsViewController.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailDepartamentsViewController.h"
#import "DepartmentCollectionViewCell.h"

static NSString* const DEPARTMENT_PLAIN_CELL = @"DEPARTMENT_PLAIN_CELL";

@interface ProyectDetailDepartamentsViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *departmentCollectionView;
@property (weak, nonatomic) IBOutlet UIWebView *departmentPlanWebView;
@property (strong,nonatomic) NSArray* proyectPlants;
@property (nonatomic) NSIndexPath* selectedPlantIndexPath;
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
    self.proyectPlants =[NSArray arrayWithArray:[selectedProyect.plants allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    self.proyectPlants=[self.proyectPlants sortedArrayUsingDescriptors:@[sort]];
    if(self.proyectPlants && self.proyectPlants.count!=0)
    {
        Plant* plant = [self.proyectPlants objectAtIndex:0];
        NSURL *websiteUrl = [NSURL URLWithString:plant.plainURL];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
        [self.departmentPlanWebView loadRequest:urlRequest];
    }
    self.selectedPlantIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.departmentCollectionView selectItemAtIndexPath:self.selectedPlantIndexPath animated:TRUE scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}


#pragma mark -
#pragma mark - Collection View Delegate
#pragma mark -

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DepartmentCollectionViewCell* cell = [self.departmentCollectionView dequeueReusableCellWithReuseIdentifier:DEPARTMENT_PLAIN_CELL forIndexPath:indexPath];
    Plant* plant = [self.proyectPlants objectAtIndex:indexPath.row];
    
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 6;
    cell.departmentNameLabel.text = plant.name;
    if([self.selectedPlantIndexPath isEqual:indexPath])
    {
        cell.backgroundColor = [UIColor redColor];
        cell.departmentNameLabel.textColor = [UIColor whiteColor];
        cell.selected =true;
    }
    else
    {
        cell.backgroundColor = [UIColor clearColor];
        cell.departmentNameLabel.textColor = [UIColor blackColor];
        cell.selected =false;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedPlantIndexPath = indexPath;
    [self.departmentCollectionView reloadData];
    Plant* plant = [self.proyectPlants objectAtIndex:indexPath.row];
    NSURL *websiteUrl = [NSURL URLWithString:plant.plainURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.departmentPlanWebView loadRequest:urlRequest];
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    NSLog(@"deselected");
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(!self.proyectPlants)
        return 0;
    else
        return self.proyectPlants.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets;
    if(self.proyectPlants && self.proyectPlants.count!=0)
    {
        float space = self.containerSize.width/(self.proyectPlants.count);
        space = space+20;
        insets = UIEdgeInsetsMake(10, space, 0, space);
    }
    else
        insets  = UIEdgeInsetsMake(10, 10, 0, 10);
    
    return  insets;
    
}
@end
