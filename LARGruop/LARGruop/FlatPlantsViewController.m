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
#import "Floor.h"
#import "PlantButtonCollectionViewCell.h"
#import <Haneke.h>
#import "FlatDetailViewController.h"
#import "CustomNavigationViewController.h"
#import "FlatReserveContainerViewController.h"

static NSString* const PLANT_BUTTON_CELL = @"PLANT_BUTTON_CELL";

@interface FlatPlantsViewController ()

@property (strong,nonatomic) NSArray* proyectFloors;
@property (weak, nonatomic) IBOutlet UICollectionView *buttonsCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *plantImageView;
@property (strong, nonatomic) CustomNavigationViewController* customNavigationController;
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
    [self setupViews];
    [self setupVars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.proyectFloors =[NSArray arrayWithArray:[selectedProyect.floors allObjects]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    self.proyectFloors=[self.proyectFloors sortedArrayUsingDescriptors:@[sort]];

    if(self.proyectFloors && self.proyectFloors.count>0)
    {
        selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        Floor* firstFloor= [self.proyectFloors objectAtIndex:0];
        NSURL* url = [NSURL URLWithString:firstFloor.image];
        [self.plantImageView hnk_setImageFromURL:url];
        [self createTouchableContentForFloor:firstFloor];
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
    return self.proyectFloors.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:@"PlantButtonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:PLANT_BUTTON_CELL];
    PlantButtonCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:PLANT_BUTTON_CELL forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    Floor* floor = [self.proyectFloors objectAtIndex:indexPath.row];
    NSString* plantName = [NSString stringWithFormat:@"Planta %@",floor.name];
    BOOL isSelected;
    if(selectedIndexPath.item == indexPath.item)
        isSelected= true;
    else
        isSelected = false;
    [((PlantButtonCollectionViewCell*) cell)  setupCellWithPlantName:plantName isSelected:isSelected];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   if(selectedIndexPath != indexPath)
   {
       NSIndexPath* lastSelectedIndexPath = selectedIndexPath;
       selectedIndexPath = indexPath;
       NSArray* indexPaths = @[selectedIndexPath, lastSelectedIndexPath];
       [collectionView reloadItemsAtIndexPaths:indexPaths];
       
       Floor* floor = [self.proyectFloors objectAtIndex:indexPath.row];
       NSURL* url = [NSURL URLWithString:floor.image];
       [self showHUDOnView:self.plantImageView];
       [self.plantImageView hnk_setImageFromURL:url placeholder:nil success:^(UIImage *image) {
           [self.plantImageView setImage:image];
           [self hideHUDOnView:self.plantImageView];
           [self createTouchableContentForFloor:floor];
       } failure:^(NSError *error) {
           [self hideHUDOnView:self.plantImageView];
           
       }];

   }
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

-(void)createTouchableContentForFloor:(Floor*)floor
{
    [self removeAllSubviewsOfPlantImageView];
    Proyect* selectedProyect = [Proyect MR_findFirstByAttribute:@"uid" withValue:self.selectedProyectID];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF.floor.number == %@",floor.number];
    NSArray* proyectDepartments = [[selectedProyect.flats allObjects] filteredArrayUsingPredicate:predicate];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    proyectDepartments=[proyectDepartments sortedArrayUsingDescriptors:@[sort]];
    
    
    for (int i=0; i<proyectDepartments.count; i++) {
        Flat* flat = [proyectDepartments objectAtIndex:i];
        UITapGestureRecognizer *oneTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        CGFloat x, y,width,height;
        x = flat.posX.floatValue;
        y = flat.posY.floatValue;
        width = self.plantImageView.frame.size.width/floor.imageWidth.floatValue;
        height = self.plantImageView.frame.size.height/floor.imageHeight.floatValue;
        CGRect frame = CGRectMake(x, y, width*100, height*50);
        UIView* view = [[UIView alloc]initWithFrame:frame];
        view.tag = i;
        [view setBackgroundColor:[UIColor redColor]];
        [self.plantImageView addSubview:view];
        [view addGestureRecognizer:oneTap];
    }
}

-(void)removeAllSubviewsOfPlantImageView
{
    NSArray *viewsToRemove = [self.plantImageView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}

-(void)handleSingleTap:(UIGestureRecognizer*)recognizer
{
    UIView* view = recognizer.view;
    NSInteger index= view.tag;
    
    Floor* floor = [self.proyectFloors objectAtIndex:selectedIndexPath.row];
    
    Proyect* selectedProyect = [Proyect MR_findFirstByAttribute:@"uid" withValue:self.selectedProyectID];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF.floor.number == %@",floor.number];
    NSArray* proyectDepartments = [[selectedProyect.flats allObjects] filteredArrayUsingPredicate:predicate];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    proyectDepartments=[proyectDepartments sortedArrayUsingDescriptors:@[sort]];
    Flat* flat = [proyectDepartments objectAtIndex:index];
    [self performSegueToFlatDetailWithFlat:flat];
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
