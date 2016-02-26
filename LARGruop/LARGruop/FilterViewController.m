//
//  FilterViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "FilterViewController.h"
#import "ProyectService.h"
#import "StatusCode.h"
@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lowValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *highValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomsLabel;
@property (weak, nonatomic) IBOutlet UISwitch *avaibleProyectsSwitch;
@property (nonatomic) int rommsSelected;
@property (nonatomic) CGFloat minPrice;
@property (nonatomic) CGFloat maxPrice;
@property (nonatomic) NSNumber* avaibleProyectsOnly;
@end

@implementation FilterViewController
{
    NSCompoundPredicate* finalPredicate;
}
#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configureMetalSlider];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
    [self setupVars];
    [self setupViews];
    [self setupNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    [self defaultSetup];//TODO: GET IF IS DEFAULT OR THERE IS A PREVIOUS FILTERED VALUE
}

-(void)defaultSetup
{
    [self cleanFilters:nil];
    if(self.rommsSelected == 0)
        self.roomsLabel.text= @"No seleccionado";
    else
        self.roomsLabel.text = [NSNumber numberWithInt:self.rommsSelected ].stringValue;
}

-(void)customSetup
{
    NSPredicate* predicate =[[ProyectService sharedService] filterProyectsPredicate];
    if(predicate)
    {
        NSArray* proyects = [[ProyectService sharedService]getAllProyects];
        NSArray* filteredProyects = [proyects filteredArrayUsingPredicate:finalPredicate];
        [ProyectService setFilterProyects:filteredProyects.mutableCopy];
        NSDictionary *userInfo = @{NOTIFICATION_SENDER: FILTER_SENDER, FILTER_MODE: @TRUE};
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationApplyFilters object:self userInfo:userInfo];

    }
}

-(void)setupVars
{
    self.rommsSelected = 0;
    self.minPrice = self.maxPrice = 0;
    self.avaibleProyectsOnly= [NSNumber numberWithBool:false];
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
    
    NSArray* proyects = [[ProyectService sharedService]getAllProyects];
    NSPredicate* avaibleProyectsOnlyPredicate;
    NSPredicate* roomsPredicate;
    NSPredicate* pricePredicate;
    
    NSMutableArray* subpredicates = [[NSMutableArray alloc]init];
    
    if(self.avaibleProyectsOnly.boolValue==true)
    {
        avaibleProyectsOnlyPredicate = [NSPredicate predicateWithFormat:@"SELF.state >= %@",@1];
        [subpredicates addObject:avaibleProyectsOnlyPredicate];
    }
    if(self.rommsSelected >0)
    {
        roomsPredicate = [NSPredicate predicateWithFormat:@"SELF.minRooms >= %@ || SELF.maxRooms >= %@",[NSNumber numberWithInteger:self.rommsSelected],[NSNumber numberWithInteger:self.rommsSelected]];
        [subpredicates addObject:roomsPredicate];
    }
    if(self.minPrice >0 && self.maxPrice>0)
    {
        pricePredicate = [NSPredicate predicateWithFormat:@"SELF.minPrice >= %@ && SELF.maxPrice <=%@",[NSNumber numberWithFloat:self.minPrice].stringValue,[NSNumber numberWithFloat:self.maxPrice].stringValue];
        [subpredicates addObject:pricePredicate];
    }
    else{
        if(self.minPrice > 0)
        {
            pricePredicate = [NSPredicate predicateWithFormat:@"SELF.minPrice >= %@",[NSNumber numberWithFloat:self.minPrice].stringValue,[NSNumber numberWithFloat:self.maxPrice].stringValue];
            [subpredicates addObject:pricePredicate];

        }
        if(self.maxPrice >0)
        {
            pricePredicate = [NSPredicate predicateWithFormat:@"SELF.maxPrice <= %@",[NSNumber numberWithFloat:self.minPrice].stringValue,[NSNumber numberWithFloat:self.maxPrice].stringValue];
            [subpredicates addObject:pricePredicate];
        }
    }
    if(subpredicates && subpredicates.count>0)
    {
        finalPredicate= [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
        [[ProyectService sharedService] setfilterProyectsPredicate:finalPredicate];
        NSArray* filteredProyects = [proyects filteredArrayUsingPredicate:finalPredicate];
        [ProyectService setFilterProyects:filteredProyects.mutableCopy];
        NSDictionary *userInfo = @{NOTIFICATION_SENDER: FILTER_SENDER, FILTER_MODE: @TRUE};
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationApplyFilters object:self userInfo:userInfo];
    }
   
}

- (IBAction)resetFilter:(UIButton *)sender {
    [self cleanFilters:nil];
    [[ProyectService sharedService] resetProyectsFilter];
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
    self.avaibleProyectsOnly = [NSNumber numberWithBool:sender.on];
}
- (IBAction)sliderValueChanged:(NMRangeSlider *)sender {
    int min = (sender.lowerValue+ 0.2) * 100000;
    int max = sender.upperValue * 100000;
    self.minPrice = min;
    self.maxPrice = max;
    self.lowValueLabel.text = [NSString stringWithFormat:@"S/%d", min];
    self.highValueLabel.text =[NSString stringWithFormat:@"S/%d", max];
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

-(void)cleanFilters:(NSNotification*)notification
{
    self.rommsSelected = 0;
    [self.avaibleProyectsSwitch setOn:FALSE];
    self.roomsLabel.text= @"No seleccionado";
    [self configureMetalSlider];
    int min = (self.sliderView.lowerValue+ 0.2) * 100000;
    int max = self.sliderView.upperValue * 100000;
    self.lowValueLabel.text = [NSString stringWithFormat:@"S/%d", min];
    self.highValueLabel.text =[NSString stringWithFormat:@"S/%d", max];
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
