//
//  BeaconMonitor.m
//  Pods
//
//  Created by Abhay Shankar on 22/02/17.
//
//

#import "BeaconMonitor.h"

@implementation BeaconMonitor


+(id)sharedManager
{
    
    static BeaconMonitor *sharedBeaconManager=nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedBeaconManager=[[self alloc] init];
        
    });
    
    return sharedBeaconManager;
}

-(instancetype)init
{
    
    return self;
}

#pragma mark - Init

-(void)startRangingForiBeacons
{
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    //    self.locationManager.allowsBackgroundLocationUpdates = YES;
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 10; // meters
    //    [self.locationManager startUpdatingLocation];
    
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"A77A1B68-49A7-4DBF-914C-760D07FBB87B"];
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
    currentRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                       identifier:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    
    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:currentRegion];
    [self.locationManager startRangingBeaconsInRegion:currentRegion];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusNotDetermined) {
        //[locationManager requestAlwaysAuthorization];
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationManager requestAlwaysAuthorization];
        }
        //        if ([_locationManager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)])
        //        {
        //            [_locationManager setAllowsBackgroundLocationUpdates:YES];
        //        }
        
    }
    else if ( status != kCLAuthorizationStatusAuthorizedAlways ) {
        NSString *title;
        title = @"Location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    
}

-(void)stopRangingForiBeacons
{
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopMonitoringForRegion:currentRegion];
    self.locationManager = nil;
}

#pragma mark - Alertview Delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

#pragma mark - Location Delegates

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
  
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    
    
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    //beacon found!!!!!!!
    //Call API to get relevant advertisement
    // generate a local push notification
    [self generateLocalNotitificationForBeacon:beacons.firstObject];
}

#pragma mark - iBeacon

-(void)generateLocalNotitificationForBeacon:(CLBeacon*)beacon
{
    if ([self shouldGenerateLocalNotification:beacon])
    {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:7];
        notification.alertBody = @"This is the advertisement when beacon is in range.";
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.userInfo = [ self getUserInfoForLocalNotfication];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

-(NSDictionary*)getUserInfoForLocalNotfication
{
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    
    [userInfo setObject:[NSURL URLWithString:@"www.google.com"] forKey:@"url"];
    [userInfo setObject:[NSURL URLWithString:@"Thanari"] forKey:kUniqueIdentifier];
    return userInfo;
}

-(BOOL)shouldGenerateLocalNotification:(CLBeacon*)beacon
{
    NSString *str = [NSString stringWithFormat:@"%@%@%@",beacon.proximityUUID.UUIDString,beacon.major.stringValue,beacon.minor.stringValue];
    
    if (GET_USER_DEFAULTS(str))
    {
        NSDate *date = GET_USER_DEFAULTS(str);
        NSTimeInterval timePassedSinceLastDetection = [date timeIntervalSinceDate:[NSDate date]];
        if (fabs(timePassedSinceLastDetection)< 24*60*60)
        {
            return NO;
        }
    }
    
    SAVE_USER_DEFAULTS([NSDate date], str);
    return YES;
}



@end
