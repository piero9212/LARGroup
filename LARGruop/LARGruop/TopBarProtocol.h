//
//  TopBarProtocol.h
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//



@protocol TopBarProtocolDelegate <NSObject>

- (void)showAddCustomerViewController;
- (void)showFilterViewController;
- (void)showSearch;

@end
