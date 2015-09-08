//
//  ProyectsViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectsViewController.h"
#import "ProyectCollectionViewCell.h"

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
    
    
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
}


@end
