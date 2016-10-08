//
//  AppDelegate.h
//  GoogleMapDirection
//
//  Created by C N Soft Net on 06/10/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray *journeyArr;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) CLLocation *sourceLoc,*destinationLoc;
@property (nonatomic,retain) NSMutableArray *journeyArr;

@end

