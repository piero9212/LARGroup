//
//  TopBarViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import "TopBarProtocol.h"

@interface TopBarViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) id<TopBarProtocolDelegate> delegate;
@property int currentControllerIndex;
@end
