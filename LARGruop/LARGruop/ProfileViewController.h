//
//  ProfileViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import "TopBarProtocol.h"

@interface ProfileViewController : BaseViewController<TopBarProtocolDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@end
