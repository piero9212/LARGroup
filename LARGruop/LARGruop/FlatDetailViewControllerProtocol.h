//
//  FlatDetailViewControllerProtocol.h
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlatDetailViewController;

@protocol FlatDetailViewControllerProtocol <NSObject>

- (void)flatDetailViewControllerupdateToNormalSize:(FlatDetailViewController *)sender;
- (void)flatDetailViewControllerupdateToExpandedSize:(FlatDetailViewController *)sender;
@end
