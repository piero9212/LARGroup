//
//  ProyectDetailItemViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailItemViewController.h"
#import "ProyectDetailDepartamentsViewController.h"
#import "ProyectDetailLocateViewController.h"
#import "ProyectDetailOutsideViewController.h"
#import "ProyectDetailOutsidesViewController.h"

@interface ProyectDetailItemViewController ()

@property (weak, nonatomic) IBOutlet UILabel *proyectDetailItemLabel;
@end

@implementation ProyectDetailItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self presentSelectedViewController];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)proyectItemPopToRoot:(UIButton *)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

-(void)setViewControllerChildWith:(UIViewController*)newChildViewController from:(UIViewController*)fromViewController
{
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:newChildViewController];
    [self transitionFromViewController:fromViewController toViewController:newChildViewController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^
     {
         [fromViewController removeFromParentViewController];
         [newChildViewController didMoveToParentViewController:self];
     } completion:nil];
}

-(UIViewController*)getCurrentViewController
{
    UIViewController* fromVC;
    for (UIViewController*  vc in self.childViewControllers)
    {
        if([vc isKindOfClass:[ProyectDetailOutsideViewController class]] || [vc isKindOfClass:[ProyectDetailDepartamentsViewController class]] ||  [vc isKindOfClass:[ProyectDetailLocateViewController class]])
            fromVC =vc;
        
    }
    return fromVC;
}

-(void)presentSelectedViewController
{
    UIViewController* destinationVC;
    UIViewController* currentVC = [self getCurrentViewController];
    
    switch (self.itemType) {
        case ProyectDetailItemTypeDepartaments:
            self.proyectDetailItemLabel.text = @"Departamentos";
            destinationVC = (ProyectDetailDepartamentsViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ProyectDetailDepartamentsViewController"];
            break;
        case ProyectDetailItemTypeLocate:
            self.proyectDetailItemLabel.text = @"Ubicación";
            destinationVC = (ProyectDetailLocateViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ProyectDetailLocateViewController"];
            ((ProyectDetailLocateViewController*)destinationVC).selectedProyectID = self.selectedProyectID;
            ((ProyectDetailLocateViewController*)destinationVC).containerSize = self.proyectItemContainerView.frame.size;
            break;
        case ProyectDetailItemTypeOutside:
            self.proyectDetailItemLabel.text = @"Imagenes de Exteriores";
            destinationVC = (ProyectDetailOutsidesViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ProyectDetailOutsidesViewController"];
            ((ProyectDetailOutsidesViewController*)destinationVC).selectedProyectID = self.selectedProyectID;
            ((ProyectDetailOutsidesViewController*)destinationVC).containerSize = self.proyectItemContainerView.frame.size;
            break;
//        case ProyectDetailItemTypePanoramic:
//            destinationVC = (pro*)[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
//            break;
//        case ProyectDetailItemTypeVideo:
//            destinationVC = (MapViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
//            break;
        default:
            destinationVC = (ProyectDetailDepartamentsViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ProyectDetailDepartamentsViewController"];
            break;
    }
    
    [self setViewControllerChildWith:destinationVC from:currentVC];
}
#pragma mark -
#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
