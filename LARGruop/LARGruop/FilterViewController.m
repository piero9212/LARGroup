//
//  FilterViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lowValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *highValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomsLabel;
@property (weak, nonatomic) IBOutlet UISwitch *avaibleProyectsSwitch;
@property (nonatomic) int rommsSelected;
@end

@implementation FilterViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configureMetalSlider];
    if(self.rommsSelected == 0)
        self.roomsLabel.text= @"No seleccionado";
    else
        self.roomsLabel.text = [NSNumber numberWithInt:self.rommsSelected ].stringValue;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
    [self setupViews];
    [self setupVars];
    [self setupNotifications];
}

-(void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    self.lowValueLabel.text = [NSString stringWithFormat:@"%f", (float)self.sliderView.lowerValue];
    self.highValueLabel.text =[NSString stringWithFormat:@"%f", (float)self.sliderView.upperValue];
    }

-(void)setupVars
{
    self.rommsSelected = 0;
}

-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanFilters:)
                                                 name:kNotificationDismissFilterWithoutApply object:nil];
}
#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)applyFilters:(UIButton *)sender {
    NSDictionary *userInfo = @{NOTIFICATION_SENDER: FILTER_SENDER, FILTER_MODE: @TRUE};
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationApplyFilters object:self userInfo:userInfo];
    
    //TODO APPLY FILTERS
}

- (IBAction)resetFilter:(UIButton *)sender {
    [self cleanFilters:nil];
}

- (IBAction)addRooms:(UIButton *)sender {
    if(self.rommsSelected+1 <MAX_ROOM_FILTER)
        self.rommsSelected +=1;
    self.roomsLabel.text = [NSNumber numberWithInt:self.rommsSelected ].stringValue;
}

- (IBAction)removeRooms:(UIButton *)sender {
    if(self.rommsSelected-1>=0)
        self.rommsSelected -=1;
    self.roomsLabel.text = [NSNumber numberWithInt:self.rommsSelected ].stringValue;
}

- (IBAction)avaibleProyectsValueChanged:(UISwitch *)sender {
    
}
- (IBAction)sliderValueChanged:(NMRangeSlider *)sender {
    
    self.lowValueLabel.text = [NSString stringWithFormat:@"%f", (float)sender.lowerValue];
    self.highValueLabel.text =[NSString stringWithFormat:@"%f", (float)sender.upperValue];
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

-(void)cleanFilters:(NSNotification*)notification
{
    [self.avaibleProyectsSwitch setOn:FALSE];
    self.roomsLabel.text= @"No seleccionado";
    //TODO CLEAN SLIDER
}

#pragma mark -
#pragma mark - Slider View Setup
#pragma mark -

- (void) configureMetalThemeForSlider:(NMRangeSlider*) slider
{
    UIImage* image = nil;
    
//    image = [UIImage imageNamed:@"slider-metal-trackBackground"];
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
//    slider.trackBackgroundImage = image;
    
//    image = [UIImage imageNamed:@"slider-metal-track"];
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
//    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"slider"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"slider-highlighted"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    slider.lowerHandleImageHighlighted = image;
    slider.upperHandleImageHighlighted = image;
}

- (void) configureMetalSlider
{
    [self configureMetalThemeForSlider:self.sliderView];
    
    self.sliderView.lowerValue = 0;
    self.sliderView.upperValue = 1;
}

@end
