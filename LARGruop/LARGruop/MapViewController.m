//
//  MapViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "MapViewController.h"

static NSString *MAP_ANNOTATION_IDENTIFIER = @"MAP_ANNOTATION_IDENTIFIER";

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *proyectsMapView;
@property CLLocationManager *locationManager;

@end

@implementation MapViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self setupVars];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    #ifdef __IPHONE_8_0
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.locationManager.delegate =self;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startMonitoringSignificantLocationChanges];
        [self.locationManager startUpdatingLocation];
        self.proyectsMapView.showsUserLocation = YES;
        //    CLLocationCoordinate2D coordinate;
        //    NSString *Latitud = @"-12.080614";
        //    NSString *Longitud = @"-77.029506";
        //    coordinate.latitude = [Latitud floatValue];
        //    coordinate.longitude = [Longitud floatValue];
        
        //    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        //    point.coordinate = coordinate;
        //    [mapa addAnnotation:point];
        //
        //    MKCoordinateRegion region;
        //    MKCoordinateSpan span;
        //    span.latitudeDelta=0.15;
        //    span.longitudeDelta=0.15;
        //
        //    CLLocationCoordinate2D location= point.coordinate = coordinate;
        //    region.span=span;
        //    region.center=location;
        //
        //    [mapa setRegion:region animated:YES];
        //    [mapa regionThatFits:region];
        //    [self getHospital];
        //Set Default location to zoom
        CLLocationCoordinate2D noLocation = CLLocationCoordinate2DMake(51.900708, -2.083160); //Create the CLLocation from user cordinates
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 50000, 50000); //Set zooming level
        MKCoordinateRegion adjustedRegion = [self.proyectsMapView regionThatFits:viewRegion]; //add location to map
        [self.proyectsMapView setRegion:adjustedRegion animated:YES]; // create animation zooming
        
        // Place Annotation Point
        MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init]; //Setting Sample location Annotation
        [annotation1 setCoordinate:CLLocationCoordinate2DMake(51.900708, -2.083160)]; //Add cordinates
        [self.proyectsMapView addAnnotation:annotation1];
        
    }

}

-(void)setupVars
{
    
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    ProyectAnnotationView *pinView = nil; //create MKAnnotationView Property
    
    pinView = (ProyectAnnotationView *)[self.proyectsMapView dequeueReusableAnnotationViewWithIdentifier:MAP_ANNOTATION_IDENTIFIER]; //Setting custom MKAnnotationView to the ID
    if ( pinView == nil )
        pinView = [[ProyectAnnotationView alloc]
                   initWithAnnotation:annotation reuseIdentifier:MAP_ANNOTATION_IDENTIFIER];     
    [pinView addSubview:self.annotationView];
    addSubview:self.annotationView.center = CGPointMake(self.annotationView.bounds.size.width*0.1f, -self.annotationView.bounds.size.height*0.5f);
    
    pinView.image = self.annotationView.proyectAnnotationImageView.image;
    
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
    NSLog(@"Project location was updated");
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error type: %@ \n", error.localizedDescription);
}

- (IBAction)displayProyectTouch:(UIButton *)sender {
}
@end
