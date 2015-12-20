//
//  NewCustomerViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "NewCustomerViewController.h"
#import "NewCustomerTableViewCell.h"
#import "ClientService.h"
#import "AlertViewFactory.h"

static NSString* const CUSTOMER_CELL= @"CUSTOMER_CELL";
static NSString* const NAME_KEY= @"NAME_KEY";
static NSString* const PHONE_KEY= @"PHONE_KEY";
static NSString* const COMMENT_KEY= @"COMMENT_KEY";
static NSString* const MAIL_KEY= @"MAIL_KEY";

@interface NewCustomerViewController ()
@property NSMutableArray* fields;
@property NSMutableArray* placeholders;
@property NSMutableDictionary* fieldValues;
@property (weak, nonatomic) IBOutlet UITableView *fieldsTableView;
@end

@implementation NewCustomerViewController

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupDismissOnTouch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
}

-(void)setupVars
{
    self.fields = [[NSMutableArray alloc]initWithObjects:@"Nombre del Cliente", @"Télefono", @"Correo del Cliente", @"Agregar Comentarios", nil];
    self.placeholders = [[NSMutableArray alloc]initWithObjects:@"Ingrese aqui el nombre de  su cliente", @"Ejem: 999405033", @"cliente@correo.com", @"Escribe tu comentario", nil];
    self.fieldValues = [[NSMutableDictionary alloc]init];
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
#pragma mark - Table View Delegate
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!self.fields)
        return 0;
    else
        return self.fields.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewCustomerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMER_CELL forIndexPath: indexPath];
    
    cell.fieldTitleLabel.text = [self.fields objectAtIndex:indexPath.row];
    cell.fieldInputTextField.placeholder = [self.placeholders objectAtIndex:indexPath.row];
    cell.fieldInputTextField.delegate = self;
    cell.fieldInputTextField.tag = indexPath.row;
    if([cell.fieldTitleLabel.text isEqualToString:@"Télefono" ])
        cell.fieldInputTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    else if ([cell.fieldTitleLabel.text isEqualToString:@"Correo del Cliente" ])
        cell.fieldInputTextField.keyboardType = UIKeyboardTypeEmailAddress;
    else
        cell.fieldInputTextField.keyboardType = UIKeyboardTypeAlphabet;
    
    if(cell.fieldInputTextField.tag == self.placeholders.count-1)
        cell.fieldInputTextField.returnKeyType = UIReturnKeyGo;
    else
        cell.fieldInputTextField.returnKeyType = UIReturnKeyNext;
    [cell.fieldInputTextField makeUnderlineWithBordeWidth:1 color:[UIColor grayColor] andAlpha:0.3];
    return cell;
}

#pragma mark -
#pragma mark - TextField Delegate
#pragma mark -

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
    UIResponder* nextResponder = [self.fieldsTableView viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.fields && textField.tag < self.fields.count)
    {
        switch (textField.tag) {
            case 0:
                [self.fieldValues setObject:textField.text forKey:NAME_KEY];
                break;
            case 1:
                [self.fieldValues setObject:textField.text forKey:MAIL_KEY];
                break;
            case 2:
                [self.fieldValues setObject:textField.text forKey:PHONE_KEY];
                break;
            case 3:
                [self.fieldValues setObject:textField.text forKey:COMMENT_KEY];
                break;
            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)saveCustomer:(UIButton *)sender {
    for (UIView *view in self.view.subviews) {
        if (view.isFirstResponder && [view isKindOfClass:[UITextField class]]) {
            [((UITextField*)view) resignFirstResponder];
        }
    }
    NSString* name = [self.fieldValues objectForKey:NAME_KEY];
    NSString* email = [self.fieldValues objectForKey:MAIL_KEY];
    NSString* phone = [self.fieldValues objectForKey:PHONE_KEY];
    NSString* interest = @"1";
    NSString* comment = [self.fieldValues objectForKey:COMMENT_KEY];
    
    if(name && email && phone && interest && comment)
    {
        [[ClientService sharedService] apiCreateClientWithUsername:name email:email phone:phone interest:interest comment:comment errorAlertView:TRUE userInfo:nil andCompletionHandler:^(BOOL succeeded) {
                [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
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

@end
