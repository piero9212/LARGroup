//
//  ProyectDetailOutsideViewController.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailOutsideViewController.h"

@interface ProyectDetailOutsideViewController ()
@property (weak, nonatomic) IBOutlet UIPageControl *outsidePageControl;
@property (weak, nonatomic) IBOutlet UIImageView *outsideImageView;

@end

@implementation ProyectDetailOutsideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)imagePageControlChanged:(UIPageControl *)sender {
    
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
