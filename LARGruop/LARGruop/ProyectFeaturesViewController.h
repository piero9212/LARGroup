//
//  ProyectFeaturesViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"

@interface ProyectFeaturesViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) Proyect* currentSelectedProyect;
@end
