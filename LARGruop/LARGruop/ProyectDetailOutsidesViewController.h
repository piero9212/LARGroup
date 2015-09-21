//
//  ProyectDetailOutsidesViewController.h
//  LARGruop
//
//  Created by Piero on 20/09/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"

@interface ProyectDetailOutsidesViewController : UIPageViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic,strong) NSString* selectedProyectID;
@property (nonatomic) CGSize containerSize;

@end
