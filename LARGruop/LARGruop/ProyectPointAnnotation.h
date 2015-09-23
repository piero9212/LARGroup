//
//  ProyectPointAnnotation.h
//  LARGruop
//
//  Created by piero.sifuentes on 23/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface ProyectPointAnnotation : MKPointAnnotation

@property (strong,nonatomic) NSString* proyectImage;
@property (strong,nonatomic) NSString* proyectUID;
@property (strong,nonatomic) NSNumber* leftDepartments;
@end
