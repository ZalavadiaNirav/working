//
//  ViewController.m
//  GoogleMapDirection
//
//  Created by C N Soft Net on 06/10/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@interface ViewController () 
{
    
    
}

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _circularImgvw.backgroundColor=[UIColor clearColor];
    _circularImgvw.image=[UIImage imageNamed:@"images.jpg"];
    _circularImgvw.layer.cornerRadius = 50;
    _circularImgvw.layer.masksToBounds = YES;

    

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:23.0225
                                                            longitude:72.5714
                                                                 zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectMake(0, 130, 420, 500) camera:camera];
    mapView.myLocationEnabled = YES;

    [self.view addSubview:mapView];
    
    // Creates a marker in the center of the map.
    
    sourceMarker = [[GMSMarker alloc] init];
    sourceMarker.position = CLLocationCoordinate2DMake(23.0225, 72.5714);
    sourceMarker.title = @"Ahmedabad";
    sourceMarker.snippet = @"India";
    sourceMarker.map = mapView;
    
    sourceLocation=[[CLLocation alloc] init];
    destinationMarker = [[GMSMarker alloc] init];
    destinationMarker.position = CLLocationCoordinate2DMake(22.3039, 70.8022);
    destinationMarker.title = @"Rajkot";
    destinationMarker.snippet = @"India";
    destinationMarker.map = mapView;
    destinationLocation=[[CLLocation alloc] init];
    

    
    sourceLocation=[[CLLocation alloc] initWithLatitude:sourceMarker.position.latitude longitude:sourceMarker.position.longitude];

    destinationLocation=[[CLLocation alloc] initWithLatitude:destinationMarker.position.latitude longitude:destinationMarker.position.longitude];
    [self drawRoute];
    [self vehicalRoute];
}

-(void)vehicalRoute
{
    UIImage *carImg = [UIImage imageNamed:@"car1.png"];
    carImg = [carImg imageWithRenderingMode:UIImageRenderingModeAutomatic];
    UIImageView *carImgvw = [[UIImageView alloc] initWithImage:carImg];
    [carImgvw setBackgroundColor:[UIColor clearColor]];
    carImgvw.frame=CGRectMake(0, 0, 50, 50);
    


    vehicalMarker=[[GMSMarker alloc] init];
    vehicalMarker.title=@"Rider";
    vehicalMarker.snippet = @"India";
    vehicalMarker.position=sourceMarker.position;
    vehicalMarker.iconView.frame=CGRectMake(0, 0, 50, 50);
    vehicalMarker.iconView=carImgvw;
    vehicalMarker.groundAnchor = CGPointMake(0.5f, 0.5f);
    vehicalMarker.flat=YES;
    vehicalMarker.map=mapView;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:2000.0];
    [UIView setAnimationDuration:100.0];
    [UIView setAnimationDelegate:self];
    vehicalMarker.position=destinationMarker.position;
    [UIView commitAnimations];
}

- (void)drawRoute
{
    [self fetchPolylineWithOrigin:sourceLocation destination:destinationLocation completionHandler:^(GMSPolyline *polyline){
         if(polyline)
             polyline.map = mapView;
     }];
}

- (void)fetchPolylineWithOrigin:(CLLocation *)origin destination:(CLLocation *)destination completionHandler:(void (^)(GMSPolyline *))completionHandler
{
    NSString *originString = [NSString stringWithFormat:@"%f,%f", origin.coordinate.latitude, origin.coordinate.longitude];
    NSString *destinationString = [NSString stringWithFormat:@"%f,%f", destination.coordinate.latitude, destination.coordinate.longitude];
    NSString *directionsAPI = @"https://maps.googleapis.com/maps/api/directions/json?";
    NSString *directionsUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&mode=driving", directionsAPI, originString, destinationString];
    NSURL *directionsUrl = [NSURL URLWithString:directionsUrlString];
    
    
    NSURLSessionDataTask *fetchDirectionsTask = [[NSURLSession sharedSession] dataTaskWithURL:directionsUrl completionHandler:
                                                 ^(NSData *data, NSURLResponse *response, NSError *error)
                                                 {
                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                     if(error)
                                                     {
                                                         if(completionHandler)
                                                             completionHandler(nil);
                                                         return;
                                                     }
                                                     
                                                     NSArray *routesArray = [json objectForKey:@"routes"];
                                                     
                                                     GMSPolyline *polyline = nil;
                                                     if ([routesArray count] > 0)
                                                     {
                                                         NSDictionary *routeDict = [routesArray objectAtIndex:0];
                                                         NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
                                                         NSString *points = [routeOverviewPolyline objectForKey:@"points"];
                                                         GMSPath *path = [GMSPath pathFromEncodedPath:points];
                                                         polyline = [GMSPolyline polylineWithPath:path];
                                                         NSLog(@"route info %@ ",routeDict);
                                                     }
                                                     
                                                     if(completionHandler)
                                                         completionHandler(polyline);
                                                 }];
    [fetchDirectionsTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
