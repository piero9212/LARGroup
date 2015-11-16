//
//  AlertViewFactory.m
//  LARGruop
//
//  Created by Piero on 11/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "AlertViewFactory.h"
#import "UIConstants.h"
#import "ApplicationConstants.h"
#import "AlertViewType.h"
#import "AlertViewTags.h"

@implementation AlertViewFactory


+ (UIAlertView *)createAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString*)cancelTitle otherButtonTitle:(NSString*)otherButtonTitle AndDelegate:(id)delegate{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitle, nil];
    return alertView;
}

+ (UIAlertView *)alertViewForNoInternetConnectionErrorWithDelegate:(id)delegate;
{
    UIAlertView* alertView = [self createAlertViewWithTitle:GLARUI(@"kDefaultTitle") message:GLARUI(@"kNoInternetConnectionMessage") cancelButtonTitle:GLARUI(@"kErrorButtonOk") otherButtonTitle:GLARUI(@"kErrorButtonRefresh") AndDelegate:delegate];
    alertView.tag = AlertViewTagNoInternetConnection;
    return alertView;
}

+ (UIAlertView *)alertViewForUnexpectedErrorWithDelegate:(id)delegate
{
    UIAlertView* alertView = [self createAlertViewWithTitle:GLARUI(@"kDefaultTitle") message:GLARUI(@"kUnexpectedErrorMessage") cancelButtonTitle:GLARUI(@"kErrorButtonOk") otherButtonTitle:GLARUI(@"kErrorButtonRefresh") AndDelegate:delegate];
    alertView.tag = AlertViewTagUnexpectedError;
    return alertView;
}

+ (UIAlertView *)alertViewForNotFoundErrorWithDelegate:(id)delegate;
{
    UIAlertView* alertView = [self createAlertViewWithTitle:GLARUI(@"kDefaultTitle") message:GLARUI(@"kNotFoundErrorMessage") cancelButtonTitle:GLARUI(@"kErrorButtonOk") otherButtonTitle:GLARUI(@"kErrorButtonRefresh") AndDelegate:delegate];
    alertView.tag = AlertViewTagNotFound;
    return alertView;
}

+ (UIAlertView *)alertViewForNotInternalServerErrorWithDelegate:(id)delegate;
{
    UIAlertView* alertView = [self createAlertViewWithTitle:GLARUI(@"kDefaultTitle") message:GLARUI(@"kInternalServerErrorMessage") cancelButtonTitle:GLARUI(@"kErrorButtonOk") otherButtonTitle:GLARUI(@"kErrorButtonRefresh") AndDelegate:delegate];
    alertView.tag = AlertViewTagInternalServerError;
    return alertView;
}

+(UIAlertView *)alertViewForLoginErrorWithDelegate:(id)delegate
{
    UIAlertView* alertView = [self createAlertViewWithTitle:GLARUI(@"kDefaultTitle") message:GLARUI(@"kLoginNoUserMessage") cancelButtonTitle:GLARUI(@"kErrorButtonCancel") otherButtonTitle:GLARUI(@"kErrorButtonOk") AndDelegate:delegate];
    alertView.tag = AlertViewTagLoginError;
    return alertView;
}

@end
