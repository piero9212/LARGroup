//
//  ProyectDetailLocateViewController.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailLocateViewController.h"
#import "ProyectPointAnnotation.h"
#import "AnnotationView.h"
#import "ProyectPointAnnotation.h"
#import "Proyect.h"

static NSString *MAP_ANNOTATION__LOCATE_IDENTIFIER = @"MAP_ANNOTATION__LOCATE_IDENTIFIER";
BOOL isPinLoaded = false;
@interface ProyectDetailLocateViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *proyectMapView;
@property Proyect* selectedProyect;
@end

@implementation ProyectDetailLocateViewController

#pragma mark -
#pragma mark - View Life Cicle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    isPinLoaded = FALSE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupMap];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupVars];
    CGRect frame = self.view.frame;
    frame.size.width = self.containerSize.width;
    frame.size.height = self.containerSize.height;
    self.view.frame = frame;
}

-(void)setupMap
{
    [self.navigationController setNavigationBarHidden:TRUE];
    if(!isPinLoaded)
        [self loadPins];
}

-(void)setupVars
{
    self.selectedProyect = [Proyect MR_findFirstByAttribute:@"uid" withValue:self.selectedProyectID];
}

-(void)loadPins
{
    self.proyectMapView.showsUserLocation = YES;
    
    if(self.selectedProyect)
    {
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.selectedProyect.latitud.doubleValue, self.selectedProyect.longitude.doubleValue);
        ProyectPointAnnotation *annotation = [[ProyectPointAnnotation alloc] init];
        [annotation setCoordinate:location]; //Add cordinates
        annotation.proyectImage = self.selectedProyect.imageURL;
        annotation.proyectUID = self.selectedProyect.uid;
        annotation.leftDepartments = [NSNumber numberWithInteger:self.selectedProyect.flats.count];
        [self.proyectMapView addAnnotation:annotation];
    }
    
    
    [self displayCorrectZoom];
}

-(void)displayCorrectZoom
{
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.proyectMapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    isPinLoaded= TRUE;
    [self.proyectMapView setVisibleMapRect:zoomRect animated:YES];
}


- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    AnnotationView *pinView = nil;
    if ([annotation isKindOfClass:[ProyectPointAnnotation class]])
    {
        
        pinView = (AnnotationView *)[self.proyectMapView dequeueReusableAnnotationViewWithIdentifier:MAP_ANNOTATION__LOCATE_IDENTIFIER];
        if ( pinView == nil )
            pinView = [[AnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:MAP_ANNOTATION__LOCATE_IDENTIFIER];
        else
        {
            pinView.annotation = annotation;
        }
        
        pinView.enabled = YES;
        pinView.canShowCallout = NO;
        
        NSURL* url = [NSURL URLWithString:((ProyectPointAnnotation*)annotation).proyectImage];
        UIImage* image;
        NSData *data = [NSData dataWithContentsOfURL:url];
        image = [UIImage imageWithData:data];
        image = [image resizedImage:CGSizeMake(70, 70) interpolationQuality:kCGInterpolationHigh ];
        image = [image roundedCornerImage:35 borderSize:2];
        CGRect frame = CGRectMake(0, 0,image.size.width,image.size.height);
        UIView* border = [[UIView alloc]initWithFrame:frame];
        border.layer.cornerRadius = border.bounds.size.width/2;
        border.layer.masksToBounds = YES;
        border.layer.borderWidth = 5.0;
        border.layer.borderColor = [UIColor colorForAvaibleDepartmentsCount:((ProyectPointAnnotation*)annotation).leftDepartments.integerValue].CGColor;
        [pinView addSubview:border];
        [pinView sendSubviewToBack:border];
        pinView.image = image;
        
    }
    return pinView;
    
    
}


@end
