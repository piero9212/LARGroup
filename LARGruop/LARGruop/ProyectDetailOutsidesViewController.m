//
//  ProyectDetailOutsidesViewController.m
//  LARGruop
//
//  Created by Piero on 20/09/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//
#import "ProyectDetailOutsideViewController.h"
#import "ProyectDetailOutsidesViewController.h"

@interface ProyectDetailOutsidesViewController ()

@property (strong,nonatomic) UIImageView* getterImageView;
@property (nonatomic,strong) NSArray* outsides;
@property (nonatomic,strong) NSMutableArray* outsideImages;
@property (nonatomic) NSInteger currentIndex;
@end

@implementation ProyectDetailOutsidesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupVars];
    [self downloadImages];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.view.superview.frame = CGRectMake(0, 0, _containerSize.width, _containerSize.height);
}


-(void)downloadImages
{
    NSLog(@"%ld",self.outsides.count);
    for(int i=0; i<self.outsides.count; i++){
        [self.outsideImages addObject:@""];
    }
    __block int counter=0;
    for(int i=0; i<self.outsides.count; i++)
    {
        Outside* outsideImage = [self.outsides objectAtIndex:i];
        NSURL* url =[NSURL URLWithString:outsideImage.image];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^(void) {
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage* image = [[UIImage alloc] initWithData:imageData];
            if (image) {
                counter++;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.outsideImages replaceObjectAtIndex:i withObject:image];
                    if(counter == 1)
                    {
                        //self.dataSource = nil;
                        self.dataSource = self;
                        ProyectDetailOutsideViewController *initialViewController = [self viewControllerAtIndex:0];
                        NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
                        [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
                    }
                });
            }
        });
        
    }
}

-(void)setupViews{
//    self.dataSource = self;
//    [self.view setFrame:[[self view] bounds]];
//    
//    ProyectDetailOutsideViewController *initialViewController = [self viewControllerAtIndex:0];
//    
//    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
//    
//    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
}

-(void)setupVars
{
    self.outsideImages = [[NSMutableArray alloc]init];
    self.outsides = [[NSArray alloc]initWithArray:[self.currentSelectedProyect.outsideImages allObjects]];
    self.currentIndex=0;
}

#pragma mark -
#pragma mark - Page Controller Delegate
#pragma mark -

- (ProyectDetailOutsideViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    ProyectDetailOutsideViewController *childViewController =  (ProyectDetailOutsideViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ProyectDetailOutsideViewController"];
    childViewController.index = index;
    childViewController.image = [self.outsideImages objectAtIndex:index];
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
    
    if (index == self.outsideImages.count) {
        return nil;
    }
    self.currentIndex=index;
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    NSLog(@"Presentation Count %lu",(unsigned long)self.outsideImages.count);
    return self.outsideImages.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

#pragma mark -
#pragma mark - Actions
#pragma mark -


@end
