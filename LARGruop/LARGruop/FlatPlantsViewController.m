//
//  FlatPlantsViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 18/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "FlatPlantsViewController.h"
#import "Proyect.h"
#import "Flat.h"
#import "PlantButtonCollectionViewCell.h"
#import <Haneke.h>
#import "FlatDetailViewController.h"

static NSString* const PLANT_BUTTON_CELL = @"PLANT_BUTTON_CELL";

@interface FlatPlantsViewController ()

@property (strong,nonatomic) NSArray* proyectDepartments;
@property (weak, nonatomic) IBOutlet UICollectionView *buttonsCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *plantImageView;

@end

@implementation FlatPlantsViewController
{
    NSIndexPath* selectedIndexPath;
}
#pragma mark -
#pragma mark - View Life Cicle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupVars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupVars
{
    Proyect* selectedProyect = [Proyect MR_findFirstByAttribute:@"uid" withValue:self.selectedProyectID];
    self.proyectDepartments =[NSArray arrayWithArray:[selectedProyect.flats allObjects]]; //TODO: ACA DEBERIAN SER PISOS
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    self.proyectDepartments=[self.proyectDepartments sortedArrayUsingDescriptors:@[sort]];

    if(self.proyectDepartments && self.proyectDepartments.count>0)
    {
        selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        Flat* firstFlat= [self.proyectDepartments objectAtIndex:0];//TODO: ACA DEBERIA SER PISO
        NSURL* url = [NSURL URLWithString:firstFlat.flatImageURL];
        [self.plantImageView hnk_setImageFromURL:url];
    }
    for (int i=0; i<self.proyectDepartments.count; i++) {
        Flat* flat = [self.proyectDepartments objectAtIndex:i];
        UITapGestureRecognizer *oneTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        CGFloat x, y;
        x = flat.posX.floatValue;
        y = flat.posY.floatValue;
        //TODO: CALCULAR PROPORCION
        CGRect frame = CGRectMake(x, y, 100, 40);
        UIView* view = [[UIView alloc]initWithFrame:frame];
        view.tag = i;
        [view setBackgroundColor:[UIColor clearColor]];
        [self.plantImageView addSubview:view];
        [view addGestureRecognizer:oneTap];
    }
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
    return self.proyectDepartments.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:@"PlantButtonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:PLANT_BUTTON_CELL];
    PlantButtonCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLANT_BUTTON_CELL forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    Flat* flat = [self.proyectDepartments objectAtIndex:indexPath.row];//ACA DEBE SER PISO
    NSString* plantName = [NSString stringWithFormat:@"Planta %@",flat.name];
    BOOL isSelected;
    if(selectedIndexPath.item == indexPath.item)
        isSelected= true;
    else
        isSelected = false;
    [((PlantButtonCollectionViewCell*) cell)  setupCellWithPlantName:plantName isSelected:isSelected];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath* lastSelectedIndexPath = selectedIndexPath;
    selectedIndexPath = indexPath;
    NSArray* indexPaths = @[selectedIndexPath, lastSelectedIndexPath];
    [collectionView reloadItemsAtIndexPaths:indexPaths];
    
    Flat* flat = [self.proyectDepartments objectAtIndex:indexPath.row];//ACA DEBE SER PISO
    NSURL* url = [NSURL URLWithString:flat.flatImageURL];
    [self showHUDOnView:self.plantImageView];
    [self.plantImageView hnk_setImageFromURL:url placeholder:nil success:^(UIImage *image) {
        [self.plantImageView setImage:image];
        [self hideHUDOnView:self.plantImageView];
    } failure:^(NSError *error) {
        [self hideHUDOnView:self.plantImageView];
        
    }];
    
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

-(void)handleSingleTap:(UIGestureRecognizer*)recognizer
{
    UIView* view = recognizer.view;
    NSInteger index= view.tag;
    Flat* flat = [self.proyectDepartments objectAtIndex:index];
    [self performSegueWithIdentifier:@"" sender:flat];
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[FlatDetailViewController class]])
    {
        Flat* flat = sender;
        CGSize temporalPopoverSize = CGSizeMake(450.0f, 540.0f);
        FlatDetailViewController* destinationVC = segue.destinationViewController;
        [destinationVC setPopOverViewSize:temporalPopoverSize];
        destinationVC.selectedFlat = flat;
    }
}

@end
