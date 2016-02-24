//
//  ProyectsViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectsViewController.h"
#import "ProyectCollectionViewCell.h"
#import "ProyectService.h"
#import "ProyectDetailViewController.h"
#import <Haneke/Haneke.h>
#import "Proyect.h"
#import "StatusCode.h"

static NSString* const PROYECT_CELL = @"PROYECT_CELL";
static NSString* const PROYECT_DETAIL_SEGUE = @"PROYECT_DETAIL_SEGUE";

@interface ProyectsViewController ()

@property NSMutableArray* proyects;
@property (weak, nonatomic) IBOutlet UICollectionView *proyectsCollectionView;

@end

@implementation ProyectsViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
    [self setupViews];
    [self setupVars];
    [self setupNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self deallocNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
}

-(void)setupVars
{
    if([[[ProyectService sharedService] getAllProyects] isEqual:[ProyectService filterProyects]])
    {
        self.proyects = [[NSMutableArray alloc]initWithArray:[[ProyectService sharedService]getAllProyects]];
    }
    else
    {
        self.proyects = [[NSMutableArray alloc]initWithArray:[ProyectService filterProyects]];
    }
}
-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyFilters:)
                                                 name:kNotificationApplyFilters object:nil];
}

-(void)deallocNotifications
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:kNotificationApplyFilters];
}

#pragma mark -
#pragma mark Collection View data source
#pragma mark -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(!self.proyects)
        return 0;
    else
        return [self.proyects count];
}

#pragma mark -
#pragma mark - Collection View delegate
#pragma mark -

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProyectCollectionViewCell *cell = [self.proyectsCollectionView dequeueReusableCellWithReuseIdentifier:PROYECT_CELL forIndexPath:indexPath];
    
    Proyect* proyect = [self.proyects objectAtIndex:indexPath.row];
    
    cell.proyectNameLabel.text = [NSString stringWithFormat:@"Proyecto %@",proyect.name];
    cell.proyectAddressLabel.text = proyect.address;
    cell.districtLabel.text = proyect.district;
    [cell.districtLabel sizeToFit];
    
    NSArray* flats = [proyect.flats allObjects];
    NSPredicate *flatsPredicate =
    [NSPredicate predicateWithFormat:@"SELF.status == %@",[NSString stringWithFormat:@"%d",StatusCodeFree]];
    NSArray *fileterdflats =
    [flats filteredArrayUsingPredicate:flatsPredicate];
    cell.departamentsLeftLabel.text = [NSString stringWithFormat:@"Departamentos disponibles: %lu",(unsigned long)fileterdflats.count];
    [cell.departamentsLeftLabel setTextColor:[UIColor colorForAvaibleDepartmentsCount:fileterdflats.count]];
    [cell.buildImageView hnk_setImageFromURL:[NSURL URLWithString:proyect.imageURL]];
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:PROYECT_DETAIL_SEGUE sender:indexPath];
    
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

-(void)applyFilters:(NSNotification *)notification
{
    self.proyects = [[NSMutableArray alloc]initWithArray:[ProyectService filterProyects]];
    [self.proyectsCollectionView reloadData];
}


#pragma mark -
#pragma mark - Navigation
#pragma mark -

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[ProyectDetailViewController class]])
    {
        ProyectDetailViewController* destinationVC = segue.destinationViewController;
        NSInteger index = ((NSIndexPath*)sender).row;
        Proyect* selectedProyect = [self.proyects objectAtIndex:index];
        destinationVC.selectedProyectID = selectedProyect.uid;
    }
}

@end
