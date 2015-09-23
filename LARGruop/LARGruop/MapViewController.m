//
//  MapViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "MapViewController.h"
#import "ProyectService.h"
#import "ProyectPointAnnotation.h"
#import <Haneke/Haneke.h>

static NSString *MAP_ANNOTATION_IDENTIFIER = @"MAP_ANNOTATION_IDENTIFIER";

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *proyectsMapView;
@property CLLocationManager *locationManager;
@property NSMutableArray* proyects;

@end

@implementation MapViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
    [self setupVars];
    [self setupViews];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    [self loadPins];
}

-(void)setupVars
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.proyects = [[NSMutableArray alloc]initWithArray:[[ProyectService sharedService]getAllProyects]];
}

-(void)loadPins
{
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.locationManager.delegate =self;
        [self.locationManager startMonitoringSignificantLocationChanges];
        [self.locationManager startUpdatingLocation];
        self.proyectsMapView.showsUserLocation = YES;
        
        for (Proyect* proyect in self.proyects) {
            CLLocationCoordinate2D location = CLLocationCoordinate2DMake(proyect.latitud.doubleValue, proyect.longitude.doubleValue);
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 40000, 40000);
            MKCoordinateRegion adjustedRegion = [self.proyectsMapView regionThatFits:viewRegion];
            [self.proyectsMapView setRegion:adjustedRegion animated:NO];
            ProyectPointAnnotation *annotation1 = [[ProyectPointAnnotation alloc] init];
            [annotation1 setCoordinate:location]; //Add cordinates
            annotation1.proyectImage = proyect.mapImageURL;
            annotation1.proyectUID = proyect.uid;
            annotation1.leftDepartments = proyect.leftDepartaments;
            [self.proyectsMapView addAnnotation:annotation1];
        }
    }
    [self displayCorrectZoom];
}

-(void)displayCorrectZoom
{
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.proyectsMapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [self.proyectsMapView setVisibleMapRect:zoomRect animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    AnnotationView *pinView = nil;
    if ([annotation isKindOfClass:[ProyectPointAnnotation class]])
    {
        
        pinView = (AnnotationView *)[self.proyectsMapView dequeueReusableAnnotationViewWithIdentifier:MAP_ANNOTATION_IDENTIFIER];
        if ( pinView == nil )
            pinView = [[AnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:MAP_ANNOTATION_IDENTIFIER];
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
    
    
    
//    
//    MKAnnotationView *annotationView = (MKAnnotationView *)[self.proyectsMapView dequeueReusableAnnotationViewWithIdentifier:MAP_ANNOTATION_IDENTIFIER];
//    
//    if (annotationView == nil)
//    {
//        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:MAP_ANNOTATION_IDENTIFIER] ;
//        
//    }
//    
//    if([[annotation title]  isEqual:@"anotacion1"])
//        
//    {
//        annotationView.image = [UIImage imageNamed:@"hospital.png"];
//        
//        //  annotationView.tag=3;
//    }
//    if([[annotation title]  isEqual:@"anotacion2"])
//    {
//        annotationView.image = [UIImage imageNamed:@"annotation2.png"];
//        //  annotationView.tag=4;
//    }
//    
//    
//    if (annotation ==self.proyectsMapView.userLocation)
//    {
//        annotationView.image = [UIImage imageNamed:@"gps.png"];
//    }
//    annotationView.frame = CGRectMake(0.0, 0.0, 64, 64);
//    
//    annotationView.tag = [[annotation subtitle] integerValue];
//    
//    annotationView.annotation = annotation;
//    
//    
//    return annotationView;
}


- (void)mapView:(MKMapView *)mapView1 didSelectAnnotationView:(MKAnnotationView *)mapView2
{

//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor=[UIColor clearColor];
//    label.frame = CGRectMake(0, 26, 120, 30);
//    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
//    label.textColor=[UIColor whiteColor];
//    [label setTextAlignment:NSTextAlignmentCenter];
//    NSString *sede = [[NSUserDefaults standardUserDefaults]
//                      stringForKey:@"sede"];
//    label.text = sede;
//    
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 32, 32)];
//    img.image = [UIImage imageNamed:@"doc.png"];
//    CGSize  calloutSize = CGSizeMake(120.0, 60.0);
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(mapa.center.x  +5.0, mapa.center.y -90.0, calloutSize.width, calloutSize.height)];
//    view.tag=1;
//    view.layer.cornerRadius = 5;
//    view.layer.masksToBounds = YES;
//    //    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 180, 80)];
//    view.backgroundColor = [UIColor colorWithRed:114.0/255 green:30.0/255 blue:30.0/255 alpha:1];
//    [mapa addSubview:view];
//    [view addSubview:label];
//    [view addSubview:img];
    
    NSLog(@"selected");
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
//    UIView* subview = [self.view viewWithTag:1];
//    [subview removeFromSuperview];
//    subview = nil;
    
}

#pragma mark -
#pragma mark - Core Location Manager Methods
#pragma mark -

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error type: %@ \n", error.localizedDescription);
}

- (IBAction)displayProyectTouch:(UIButton *)sender {
}
@end
