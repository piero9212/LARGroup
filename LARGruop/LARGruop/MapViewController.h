//
//  MapViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import "ProyectAnnotationView.h"
#import "AnnotationView.h"

@interface MapViewController : BaseViewController <MKMapViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet ProyectAnnotationView *annotationView;

- (IBAction)displayProyectTouch:(UIButton *)sender;
@end
