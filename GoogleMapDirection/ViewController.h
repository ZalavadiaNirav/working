//
//  ViewController.h
//  GoogleMapDirection
//
//  Created by C N Soft Net on 06/10/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

#import "AppDelegate.h"

@class AppDelegate;
@interface ViewController : UIViewController <GMSMapViewDelegate>
{
    AppDelegate *app;
    GMSMapView *mapView;
    GMSMarker *sourceMarker,*destinationMarker,*vehicalMarker;
    CLLocation *sourceLocation,*destinationLocation;
    
    
}

@property (strong, nonatomic) IBOutlet UIImageView *circularImgvw;
@property (nonatomic,assign) CLLocation *sourceLocation,*destinationLocation;
@property (nonatomic,retain) AppDelegate *app;

@property (strong, nonatomic) IBOutlet UILabel *ridernameLbl;
@property (strong, nonatomic) IBOutlet UILabel *durationLbl;
@property (strong, nonatomic) IBOutlet UILabel *sourceLbl;
@property (strong, nonatomic) IBOutlet UILabel *destinationLbl;
@property (strong, nonatomic) IBOutlet UILabel *distanceLbl;

//- (void)fetchPolylineWithOrigin:(CLLocation *)origin destination:(CLLocation *)destination completionHandler:(void (^)(GMSPolyline *))completionHandler;
-(void)vehicalRoute;

@end

