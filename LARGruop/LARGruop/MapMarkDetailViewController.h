//
//  MapMarkDetailViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 23/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import "ProyectAnnotationProtocol.h"

@interface MapMarkDetailViewController : BaseViewController


@property (readwrite) CGSize popOverViewSize;
@property (weak, nonatomic) IBOutlet UIImageView *proyectAnnotationImageView;
@property (weak, nonatomic) IBOutlet UILabel *proyectAnnotationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *proyectAnnotationAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *mapDesciptionLabel;
@property (weak,nonatomic) id<ProyectAnnotationDelegate> delegate;
@property(strong,nonatomic) NSString* proyectUID;
@end
