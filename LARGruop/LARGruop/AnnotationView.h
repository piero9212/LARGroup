//
//  AnnotationView.h
//  MKMapViewTutorial
//
//  Created by DilumNavanjana on 19/10/14.
//  Copyright (c) 2014 Dilum Navanjana. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ProyectPointAnnotation.h"

@interface AnnotationView : MKAnnotationView

@property (nonatomic,strong) ProyectPointAnnotation* proyectAnnotation;
@end
