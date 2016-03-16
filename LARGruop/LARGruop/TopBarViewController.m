//
//  TopBarViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "TopBarViewController.h"
#import <Haneke.h>
#import "User.h"
#import "LoginService.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TopBarViewController


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
    [self setupVars];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    switch (self.currentControllerIndex) {
        case 0:
            self.titleLabel.text = @"Proyectos";
            break;
        case 1:
            self.titleLabel.text = @"Mis Clientes";
            break;
        case 2:
            self.titleLabel.text = @"Mi Perfil";
            break;
            
        default:
            self.titleLabel.text = @"Proyectos";
            break;
    }
}

-(void)setupVars
{
    User* user = [[LoginService sharedService]lastLoggedInUser];
    NSURL* url = [NSURL URLWithString:user.imageURL];
    [self.userImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRefreshCached];
    float radius = self.userImageView.frame.size.width/2;
    self.userImageView.layer.cornerRadius =  radius;
    self.userImageView.clipsToBounds = YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)doFilter:(id)sender {
    [self.delegate showFilterViewController];
}

- (IBAction)search:(id)sender {
    [self.delegate showSearch];
}
- (IBAction)tapProfile:(UITapGestureRecognizer *)sender {
    [self.delegate showProfile];
}

- (IBAction)addCustomer:(id)sender {
    [self.delegate showAddCustomerViewController];
}
@end
