//
//  FlatDetailViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 18/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "FlatDetailViewController.h"
#import <Haneke.h>
#import "StatusCode.h"

@interface FlatDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flatNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeFlatButton;
@property (weak, nonatomic) IBOutlet UIImageView *flatImageView;
@property (weak, nonatomic) IBOutlet UILabel *flatStatusLabel;

@end

@implementation FlatDetailViewController


#pragma mark -
#pragma mark - View Life Cicle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupDismissOnTouch];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupVars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupVars
{
    NSURL* url = [NSURL URLWithString:self.selectedFlat.flatImageURL];
    [self.flatImageView hnk_setImageFromURL:url];
    [self.flatNameLabel setText:[NSString stringWithFormat:@"Modelo %@ %@m2",self.selectedFlat.name,self.selectedFlat.size]];
    self.flatStatusLabel.text = self.selectedFlat.status;
    self.seeFlatButton.layer.cornerRadius = 10;
    self.seeFlatButton.layer.borderWidth =  2 ;
    self.seeFlatButton.layer.borderColor = [UIColor orangeLARColor].CGColor;
    UIColor* statusColor = [UIColor colorForDepartmentsStatus:self.selectedFlat.status.integerValue];
    NSString* statusName;
    switch (self.selectedFlat.status.integerValue) {
        case StatusCodeFree:
            statusName = @"Libre";
            break;
        case StatusCodeReserved:
            statusName = @"Separada";
            break;
        case StatusCodeContract:
            statusName = @"Contrato (Minuta)";
            break;
        case StatusCodesWrited:
            statusName = @"Escriturado";
            break;
        case StatusCodeBlocked:
            statusName = @"Bloqueado";
            break;
    }
    [self.flatStatusLabel setText:statusName];
    [self.flatStatusLabel setTextColor:statusColor];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, _popOverViewSize.width, _popOverViewSize.height);
    
    self.view.superview.layer.cornerRadius  = 5.0;
    self.view.superview.layer.masksToBounds = YES;
}

-(void)setupDismissOnTouch
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
    [recognizer setNumberOfTapsRequired:1];
    recognizer.cancelsTouchesInView = NO; //So the user can still interact with controls in the modal view
    [self.view.window addGestureRecognizer:recognizer];
    recognizer.delegate = self;
}


#pragma mark -
#pragma mark - Actions
#pragma mark -

- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        // passing nil gives us coordinates in the window
        CGPoint location = [sender locationInView:nil];
        
        // swap (x,y) on iOS 8 in landscape
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                location = CGPointMake(location.y, location.x);
            }
        }
        
        // convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
        if (![self.view pointInside:[self.view convertPoint:location fromView:self.view.window] withEvent:nil]) {
            
            // remove the recognizer first so it's view.window is valid
            [self.view.window removeGestureRecognizer:sender];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

#pragma mark -
#pragma mark - Gesture Recognizer Delegate
#pragma mark -

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    UIView *view = otherGestureRecognizer.view;
    if (view.class != UIView.class) {
        if (view.class == [UITableView class] || view.class == [UITextField class]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -
- (IBAction)seeFlatTapped:(UIButton *)sender {
    [self performSegueWithIdentifier:@"" sender:nil];
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
