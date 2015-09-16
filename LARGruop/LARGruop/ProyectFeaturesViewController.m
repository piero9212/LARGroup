//
//  ProyectFeaturesViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectFeaturesViewController.h"
#import "ProyectFeatureService.h"
#import "FeatureTableViewCell.h"

static NSString* const FEATURE_CELL = @"FEATURE_CELL";

@interface ProyectFeaturesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *featuresTableView;
@property (weak, nonatomic) IBOutlet UILabel *featureDescriptionLabel;
@property (strong,nonatomic) NSArray* features;
@end

@implementation ProyectFeaturesViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupVars];
    [self setupViews];
    
}

-(void)setupViews
{
    self.featureDescriptionLabel.text = self.currentSelectedProyect.proyectDescription;
}

-(void)setupVars
{
    self.features = [[ProyectFeatureService sharedService]getAllFeaturesWithProyect:self.currentSelectedProyect];
}


#pragma mark -
#pragma mark - Table View Delegate
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!self.features)
        return 0;
    else
        return self.features.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeatureTableViewCell* cell = [self.featuresTableView dequeueReusableCellWithIdentifier:FEATURE_CELL];
    
    ProyectFeature* feature = [self.features objectAtIndex:indexPath.row];
    cell.featureDescriptionLabel.text = feature.featureDescription;
    return cell;
}

@end
