//
//  ProyectDetailLocateViewController.h
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ProyectDetailLocateViewController : BaseViewController <MKMapViewDelegate>


@property (nonatomic,strong) NSString* selectedProyectID;
@property (nonatomic) CGSize containerSize;

@end
