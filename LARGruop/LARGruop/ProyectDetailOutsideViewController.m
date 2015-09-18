//
//  ProyectDetailOutsideViewController.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailOutsideViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "FXPageControl.h"

@interface ProyectDetailOutsideViewController ()
@property (weak, nonatomic) IBOutlet FXPageControl *outsidePageControl;
@property (strong,nonatomic) UIImageView* getterImageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) NSArray* outsides;
@property (nonatomic,strong) NSMutableArray* outsideImages;
@property (nonatomic, strong) NSMutableArray *outsidePageViews;
@end

@implementation ProyectDetailOutsideViewController


#pragma mark -
#pragma mark - View Life Cycle
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
    [self downloadImages];
    
//    CGSize pagesScrollViewSize = self.scrollView.frame.size;
//    CGSize scrollSize = CGSizeMake(pagesScrollViewSize.width * self.outsides.count, pagesScrollViewSize.height);
//    self.scrollView.contentSize = scrollSize;
    [self loadVisiblePages];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    CGSize scrollSize = CGSizeMake(pagesScrollViewSize.width * self.outsides.count, pagesScrollViewSize.height);
    self.scrollView.contentSize = scrollSize;
}

-(void)setupVars
{
    self.outsideImages = [[NSMutableArray alloc]init];
    self.outsidePageViews = [[NSMutableArray alloc] init];
    self.outsides = [[NSArray alloc]initWithArray:[self.currentSelectedProyect.outsideImages allObjects]];
    NSInteger pageCount = self.outsides.count;
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.outsidePageViews addObject:[NSNull null]];
    }
}

-(void)setupViews
{
    NSInteger pageCount = self.outsides.count;
    self.outsidePageControl.currentPage = 0;
    self.outsidePageControl.numberOfPages = pageCount;
    self.outsidePageControl.defersCurrentPageDisplay = YES;
    self.outsidePageControl.selectedDotSize = 10.0;
    self.outsidePageControl.dotColor = [UIColor whiteColor];
    self.outsidePageControl.dotSpacing = 30.0;
    self.outsidePageControl.wrapEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}

-(void)downloadImages
{
    for(Outside* outsideImage in self.outsides)
    {
        Outside* outsideObject = outsideImage;
        NSURL* url =[NSURL URLWithString:outsideObject.image];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^(void) {
            
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage* image = [[UIImage alloc] initWithData:imageData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.outsideImages addObject:image];
                    if(self.outsideImages.count == self.outsides.count)
                        [self loadVisiblePages];
                });
            }
        });

    }
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -



#pragma mark -
#pragma mark - Actions
#pragma mark -

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.outsides.count) {
        return;
    }
    
    UIView *pageView = [self.outsidePageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.outsidePageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)loadVisiblePages {
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    self.outsidePageControl.currentPage = page;
    
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    
    for (NSInteger i=lastPage+1; i<self.outsides.count; i++) {
        [self purgePage:i];
    }

}


- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.outsides.count || self.outsideImages.count==0) {
        return;
    }
    
    UIImage *pageView = [self.outsidePageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        frame.size.width = _containerSize.width;
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.outsideImages objectAtIndex:page]];
        newPageView.backgroundColor = [UIColor redColor];
        newPageView.frame = frame;
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:newPageView];
        [self.scrollView  sendSubviewToBack:newPageView];
        [self.view bringSubviewToFront:self.outsidePageControl];
        [self.outsidePageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages which are now on screen
    [self loadVisiblePages];
}

@end
