//
//  ProyectDetailDepartamentsViewController.h
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"

@interface ProyectDetailDepartamentsViewController : BaseViewController <UICollectionViewDataSource,UICollectionViewDelegate,UIWebViewDelegate>

@property (nonatomic,strong) NSString* selectedProyectID;
@property (nonatomic) CGSize containerSize;

@end
