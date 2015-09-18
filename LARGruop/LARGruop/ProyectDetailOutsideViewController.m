//
//  ProyectDetailOutsideViewController.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailOutsideViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface ProyectDetailOutsideViewController ()
@property (weak, nonatomic) IBOutlet UIPageControl *outsidePageControl;
@property (weak, nonatomic) IBOutlet UIImageView *outsideImageView;
@property (nonatomic,strong) NSArray* outsideImages;
@property (nonatomic, strong) NSMutableArray *outsidePageViews;
@end

@implementation ProyectDetailOutsideViewController


#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVars];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)setupVars
{
    self.outsideImages = [[NSArray alloc]initWithArray:[self.currentSelectedProyect.outsideImages allObjects]];
    self.outsidePageViews = [[NSMutableArray alloc] init];
}

-(void)setupViews
{
    NSInteger pageCount = self.outsideImages.count;
    self.outsidePageControl.currentPage = 0;
    self.outsidePageControl.numberOfPages = pageCount;
    
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.outsidePageViews addObject:[NSNull null]];
    }
    [self loadVisiblePagesWithCurrentPage:0];
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)imagePageControlChanged:(UIPageControl *)sender {
    int page = sender.currentPage;
    [self loadPage:page];
}


#pragma mark -
#pragma mark - Actions
#pragma mark -

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.outsideImages.count) {
        return;
    }
    
    UIImage *pageView = [self.outsidePageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null] || ([pageView isKindOfClass:[UIImage class]])) {
        
        Outside* outsideObject = [self.outsideImages objectAtIndex:page];
        
        NSURL* url =[NSURL URLWithString:outsideObject.image];
        [self.outsideImageView setImageWithURLRequest:[NSURLRequest requestWithURL:url] placeholderImage:nil success:^(NSURLRequest *request , NSHTTPURLResponse *response , UIImage *image ){
            self.outsideImageView.image = image;
            [self.outsidePageViews replaceObjectAtIndex:page withObject:image];
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
            NSLog(@"failed loading: %@", error);
        }];
        
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.outsideImages.count) {
        return;
    }
    
    UIView *pageView = [self.outsidePageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.outsidePageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)loadVisiblePagesWithCurrentPage:(NSInteger)page {
    
    self.outsidePageControl.currentPage = page;
    
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    
    for (NSInteger i=lastPage+1; i<self.outsideImages.count; i++) {
        [self purgePage:i];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
