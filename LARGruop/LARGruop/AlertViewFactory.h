//
//  AlertViewFactory.h
//  LARGruop
//
//  Created by Piero on 11/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertViewFactory : NSObject

+ (UIAlertView *)createAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString*)cancelTitle otherButtonTitle:(NSString*)otherButtonTitle AndDelegate:(id)delegate;


+ (UIAlertView *)alertViewForNoInternetConnectionErrorWithDelegate:(id)delegate;
+ (UIAlertView *)alertViewForUnexpectedErrorWithDelegate:(id)delegate;
+ (UIAlertView *)alertViewForNotFoundErrorWithDelegate:(id)delegate;
+ (UIAlertView *)alertViewForNotInternalServerErrorWithDelegate:(id)delegate;
+(UIAlertView *)alertViewForLoginError;
+(UIAlertView *)alertViewForNoUserCredentials;
+(UIAlertView *)alertViewForPasswordRecovered;
+(UIAlertView *)alertViewForPasswordRecoveredFailed;
@end
