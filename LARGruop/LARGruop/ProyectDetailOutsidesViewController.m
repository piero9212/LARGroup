//
//  ProyectDetailOutsidesViewController.m
//  LARGruop
//
//  Created by Piero on 20/09/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//
#import "ProyectDetailOutsideViewController.h"
#import "ProyectDetailOutsidesViewController.h"
#import <Haneke/Haneke.h>
#import <MagicalRecord/MagicalRecord.h>
#import "Proyect.h"
#import "Outside.h"

@interface ProyectDetailOutsidesViewController ()

@property (strong,nonatomic) UIImageView* getterImageView;
@property (nonatomic,strong) NSArray* outsides;
@property (nonatomic) NSInteger currentIndex;
@end

@implementation ProyectDetailOutsidesViewController

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
    [[UIPageControl appearance] setPageIndicatorTintColor:[UIColor LARGreyColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor:[UIColor LAROrangeColor]];
    self.delegate = self;
    self.dataSource = self;
    ProyectDetailOutsideViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(void)setupVars
{
    Proyect* selectedProyect = [Proyect MR_findFirstByAttribute:@"uid" withValue:self.selectedProyectID];
    self.outsides = [[NSArray alloc]initWithArray:[selectedProyect.outsideImages allObjects]];
    self.currentIndex=0;
}


#pragma mark -
#pragma mark - Page Controller Delegate
#pragma mark -

- (ProyectDetailOutsideViewController *)viewControllerAtIndex:(NSUInteger)index {
    
   
    ProyectDetailOutsideViewController *childViewController =  (ProyectDetailOutsideViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ProyectDetailOutsideViewController"];
    if(self.outsides && self.outsides.count>0)
    {
        childViewController.index = index;
        Outside* outside = self.outsides[index];
        if([outside isFault])
            outside = (Outside *)[[NSManagedObjectContext MR_defaultContext] objectWithID:outside.objectID];
        NSURL* url = [NSURL URLWithString:outside.imageURL];
        
        CGRect frame = childViewController.view.frame;
        childViewController.outsideImageView.frame = frame;
        [childViewController.outsideImageView hnk_setImageFromURL:url placeholder:nil];}
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ProyectDetailOutsideViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    index--;
    self.currentIndex=index;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ProyectDetailOutsideViewController *)viewController index];
    
    index++;
    
    if (index == self.outsides.count) {
        return nil;
    }
    self.currentIndex=index;
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.outsides.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}



@end
