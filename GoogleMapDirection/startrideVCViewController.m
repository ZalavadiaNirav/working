//
//  startrideVCViewController.m
//  GoogleMapDirection
//
//  Created by C N Soft Net on 07/10/16.
//  Copyright © 2016 C N Soft Net. All rights reserved.
//

#import "startrideVCViewController.h"

@interface startrideVCViewController ()

@end

@implementation startrideVCViewController

@synthesize geocoder;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ridernameTxtfield.delegate=self;
    sourceTxtfield.delegate=self;
    destinationTxtfield.delegate=self;
    
    
}

#pragma mark -

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startrideAction:(id)sender
{
    if(!(([sourceTxtfield.text isEqualToString:@""]) && ([destinationTxtfield.text isEqualToString:@""])))
    {
        
        [self performSelector:@selector(getGeoLocation:) onThread:[NSThread mainThread] withObject:sourceTxtfield.text waitUntilDone:YES];
        NSLog(@"source Location %@ /n Destination Location %@",sourceLoc,destinationLoc);
    }
    else
        NSLog(@"Enter Source and destination ");
}

-(void)getGeoLocation:(NSString *)locationStr
{
    

    if (!self.geocoder) {
        NSLog(@"Geocdoing");
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    [self.geocoder geocodeAddressString:locationStr completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Fetch Gecodingaddress");
        if ([placemarks count] > 0)
        {
            
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            NSLog(@"GET placemark%@",placemark);
            if(bit==false)
            {
                sourceLoc = placemark.location;
                [self performSelectorOnMainThread:@selector(getGeoLocation:) withObject:destinationTxtfield.text waitUntilDone:YES];
                bit=true;
                NSLog(@"source %@",sourceLoc);

            }
            else
            {
                destinationLoc=placemark.location;
                NSLog(@"destination %@",destinationLoc);
                [self performSegueWithIdentifier:@"startedID" sender:nil];
            }
            
            
        }
    }];

}


-(IBAction)cancelAction:(id)sender
{

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"startID"])
    {
        
    }
}


@end
