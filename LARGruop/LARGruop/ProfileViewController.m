//
//  ProfileViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProfileViewController.h"
#import "NewCustomerViewController.h"
#import "TopBarViewController.h"
#import "LoginService.h"
#import "HomeViewController.h"
#import "User.h"
#import <Haneke.h>
#import <AFNetworking.h>
#import "ApplicationConstants.h"

static NSString* LOGOUT_SEGUE = @"LOGOUT_SEGUE";

@interface ProfileViewController()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *changePictureButton;
@property (weak, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userPictureImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation ProfileViewController

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
    [self setupNotifications];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    [[UITabBar appearance] setTintColor:[UIColor orangeLARColor]];
    User* user = [[LoginService sharedService]lastLoggedInUser];
    if(user.firstName && user.lastName)
    {
        [self.userFullNameLabel setText:[NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName]];
    }
    else if(user.firstName)
    {
        [self.userFullNameLabel setText:[NSString stringWithFormat:@"%@",user.firstName]];
    }
    else
        [self.userFullNameLabel setText:@"----"];

    if(user.email)
         [self.userEmailLabel setText:user.email];
    else
        [self.userFullNameLabel setText:@"----"];
    
    if(user.mobilePhone)
        [self.cellPhoneLabel setText:user.mobilePhone];
    else
        [self.cellPhoneLabel setText:@"----"];
        
    if(user.phone)
        [self.phoneLabel setText:user.phone];
    else
        [self.phoneLabel setText:@"----"];
    
    
    [self.userNameLabel setText:user.username];
    
    [self.userPictureImageView hnk_setImageFromURL:[NSURL URLWithString:user.imageURL]];
    self.userPictureImageView.clipsToBounds = YES;
    float radius = self.userPictureImageView.frame.size.width/2;
    self.userPictureImageView.layer.cornerRadius =  radius;
    self.logoutButton.layer.cornerRadius= self.changePictureButton.layer.cornerRadius = 10;
    self.logoutButton.layer.borderWidth = self.changePictureButton.layer.borderWidth = 3 ;
    self.logoutButton.layer.borderColor = self.changePictureButton.layer.borderColor = [UIColor orangeLARColor].CGColor;
}

-(void)setupVars
{
    
}

-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccess:)
                                                 name:kNotificationLogoutFinished object:nil];
}


#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)logout:(UIButton *)sender {
    [[LoginService sharedService] logoutWithNotification:TRUE];
}
- (IBAction)changePictureTapped:(UIButton *)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:true completion:nil];
}

- (IBAction)editInfoTapped:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.nameTextField.alpha = self.mailTextField.alpha = self.phoneTextField.alpha = self.mobilePhoneTextField.alpha = self.saveButton.alpha= 1.0;
    } completion:nil];
}

- (IBAction)saveButton:(UIButton *)sender {
    [self showHUDOnView:self.view];
    [UIView animateWithDuration:0.5 animations:^{
        self.nameTextField.alpha = self.mailTextField.alpha = self.phoneTextField.alpha = self.mobilePhoneTextField.alpha = self.saveButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(finished)
        {
            NSString* name = self.nameTextField.text;
            NSString* email = self.mailTextField.text;
            NSString* phone = self.phoneTextField.text;
            NSString* mobilePhone = self.mobilePhoneTextField.text;
            
            User* user = [[LoginService sharedService]lastLoggedInUser];
            if((name && ![name  isEqual:@""]) || (email && ![email  isEqual:@""]) || (phone && ![phone  isEqual:@""]) || (mobilePhone && ![mobilePhone  isEqual:@""]))
            {
                if(!name && [name  isEqual:@""])
                {
                    if(user.firstName && user.lastName)
                    {
                        name = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
                    }
                    else if(user.firstName)
                    {
                        name = [NSString stringWithFormat:@"%@",user.firstName];
                    }

                }
                if(!email && ![email  isEqual:@""])
                {
                    email = user.email;
                }
                if(!phone && ![phone  isEqual:@""])
                {
                    phone = user.phone;
                }
                if(!mobilePhone && ![mobilePhone  isEqual:@""])
                {
                    mobilePhone = user.mobilePhone;
                }
                NSString* pass = [[LoginService sharedService] lastPassword];
                [[LoginService sharedService] apiEditUserWithName:name password:pass email:email phone:phone mobilePhone:mobilePhone User:user errorAlertView:TRUE userInfo:nil andCompletionHandler:^(BOOL succeeded) {
                    [self hideHUDOnView:self.view];
                    if(succeeded)
                    {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self setupViews];
                        });
                    }
                    else
                    {
                        [[AlertViewFactory alertViewForUnexpectedErrorWithDelegate:self]show];
                    }
                }];
            }
        }
    }];
}
#pragma mark -
#pragma mark - Actions
#pragma mark -

-(void)logoutSuccess:(NSNotification*)notification
{
    [self performSegueWithIdentifier:LOGOUT_SEGUE sender:nil];
}

#pragma mark -
#pragma mark - Top Bar Delegate
#pragma mark -

- (void)showAddCustomerViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewCustomerViewController *newCustomerViewController = [storyboard instantiateViewControllerWithIdentifier:@"NewCustomerViewController"];
    
    newCustomerViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:newCustomerViewController animated:YES completion:nil];
    
    CGSize temporalPopoverSize = CGSizeMake(450.0f, 540.0f);
    [newCustomerViewController setPopOverViewSize:temporalPopoverSize];
}

- (void)showFilterViewController
{
    for(UIViewController* controller in self.navigationController.childViewControllers)
    {
        if([controller isKindOfClass:[UITabBarController class]])
        {
            UITabBarController* tabBarController = (UITabBarController*)controller;
            HomeViewController* home = [tabBarController.viewControllers objectAtIndex:0];
            [home showSearch];
            tabBarController.selectedViewController
            = home;
            [home showFilterViewController];
        }
    }

}

- (void)showSearch
{
    for(UIViewController* controller in self.navigationController.childViewControllers)
    {
        if([controller isKindOfClass:[UITabBarController class]])
        {
            UITabBarController* tabBarController = (UITabBarController*)controller;
            HomeViewController* home = [tabBarController.viewControllers objectAtIndex:0];
            [home showSearch];
            tabBarController.selectedViewController
            = home;
        }
    }
}

-(void)showProfile
{
    
}


#pragma mark -
#pragma mark - Image Picker Delegate
#pragma mark -

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:TRUE completion:^{
        [self showHUDOnView:self.view];
        UIImage *newImage = image;
        [self.userPictureImageView setImage:image];
        self.userPictureImageView.clipsToBounds = YES;
        float radius = self.userPictureImageView.frame.size.width/2;
        self.userPictureImageView.layer.cornerRadius =  radius;
        NSData *imageData = UIImagePNGRepresentation(newImage);
        
        // Init the URLRequest
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        manager.requestSerializer.timeoutInterval = 0.30;
        NSDictionary *parameters = @{@"username": [[LoginService sharedService] lastUsername], @"password" :  [[LoginService sharedService] lastPassword]};
        AFHTTPRequestOperation *op = [manager POST:@"ACA_VA_LA_URL_QUE_FALTA" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            //do not put image inside parameters dictionary as I did, but append it!
            [formData appendPartWithFileData:imageData name:@"" fileName:@"userPhoto.jpg" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
            [self hideHUDOnView:self.view];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@ ***** %@", operation.responseString, error);
            [self hideHUDOnView:self.view];
        }];
        [op start];
    }];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.keyboardType == UIKeyboardTypeNumberPad)
    {
        if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
        {
            return NO;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[TopBarViewController class]])
    {
        ((TopBarViewController*)segue.destinationViewController).delegate = self;
        ((TopBarViewController*)segue.destinationViewController).currentControllerIndex = 2;
    }
}


@end
