//
//  ProyectDetailItemViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,ProyectDetailItemType) {
    ProyectDetailItemTypeLocate,
    ProyectDetailItemTypeOutside,
    ProyectDetailItemTypeVideo,
    ProyectDetailItemTypePanoramic,
    ProyectDetailItemTypeDepartaments,
    ProyectDetailItemTypeSchemeDepartments,
};

@interface ProyectDetailItemViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *proyectItemContainerView;
@property (nonatomic) ProyectDetailItemType itemType;
@property (nonatomic,strong) NSString* selectedProyectID;
@end
