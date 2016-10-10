//
//  startrideVCViewController.h
//  GoogleMapDirection
//
//  Created by C N Soft Net on 07/10/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"

@interface startrideVCViewController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate>
{
        

    IBOutlet UITextField *ridernameTxtfield;

    IBOutlet UITextField *sourceTxtfield;

    IBOutlet UITextField *destinationTxtfield;
    
    AppDelegate *objapp;
    CLGeocoder *geocoder;
    CLLocation *sourceLoc,*destinationLoc,*tempLoc;
    CFBit bit;
    UIAlertController *pleaseWaitAlert;
    UIActivityIndicatorView *indicator;
}

@property (nonatomic,retain) AppDelegate *app;
@property (strong, nonatomic) IBOutlet UIButton *startrideBtn;

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@property (nonatomic,strong) CLLocation *tempLoc;


@property (nonatomic,strong)CLGeocoder *geocoder;

-(IBAction)startrideAction:(id)sender;
-(IBAction)cancelAction:(id)sender;
-(void)getGeoLocation:(NSString *)location;
@end
