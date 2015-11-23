//
//  HomeViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import "TopBarProtocol.h"

@interface HomeViewController : BaseViewController <TopBarProtocolDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSArray* proyects;
@end
