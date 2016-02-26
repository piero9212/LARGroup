//
//  FlatContainerProtocol.h
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlatReserveContainerViewController;

@protocol FlatContainerProtocol <NSObject>

- (void)flatContainerViewControllerupdateToNormalSize:(FlatReserveContainerViewController *)sender;
- (void)flatContainerViewControllerupdateToExpandedSize:(FlatReserveContainerViewController *)sender;

@end
