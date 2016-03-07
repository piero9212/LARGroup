//
//  PromoViewController.m
//  LARGruop
//
//  Created by Piero on 6/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//


#import "PromoViewController.h"

@interface PromoViewController()
@property (weak, nonatomic) IBOutlet UIButton *aceptButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *promoDetail;
@property (weak, nonatomic) IBOutlet UILabel *promoTitleLabel;
@end

@implementation PromoViewController
{
    int timeSec;
    int timeMin;
    int timeMiniSec;
    NSTimer *timer;
}

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
    [self startTimer];
}

-(void)viewWillAppear:(BOOL)animated
{
    timeSec = 60;
    timeMin = self.selectedPromo.time.intValue;
    timeMiniSec = (timeSec* 60) % 1000;
    [super viewWillAppear:animated];
    
    NSString* name = self.selectedPromo.name;
    self.promoTitleLabel.text = [NSString stringWithFormat:@"Promoción %@",name];
    self.promoDetail.text = self.selectedPromo.promoDescription;
    self.timerLabel.text =@"";
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, _popOverViewSize.width, _popOverViewSize.height);
    
    self.view.superview.layer.cornerRadius  = 5.0;
    self.view.superview.layer.masksToBounds = YES;
}

-(void)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

//Event called every time the NSTimer ticks.
- (void)timerTick:(NSTimer *)timer
{
    if(timeMin-1 <= 0)
        [self StopTimer];
    
    if (timeSec <= 0 && timeMin-1>=0)
    {
        timeSec = 60;
        timeMin--;
    }
    if(timeSec-1>=0)
        timeSec--;
    //Format the string 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    self.timerLabel.text= timeNow;
}

- (void) StopTimer
{
    [timer invalidate];
    timeSec = 0;
    timeMin = 0;
    //Since we reset here, and timerTick won't update your label again, we need to refresh it again.
    //Format the string in 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    // [timeLabel setStringValue:timeNow];
    self.timerLabel.text= timeNow;
}

- (IBAction)aceptTapped:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPromoAcepted object:self userInfo:nil];
    [self StopTimer];
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)cancelTapped:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPromoCancel object:self userInfo:nil];
    [self StopTimer];
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
@end
