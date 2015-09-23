//
//  ProyectAnnotationView.h
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ProyectAnnotationView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *proyectAnnotationImageView;
@property (weak, nonatomic) IBOutlet UILabel *proyectAnnotationTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *proyectAnnotationAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *mapDesciptionLabel;

@end
