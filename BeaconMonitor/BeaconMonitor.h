//
//  BeaconMonitor.h
//  Pods
//
//  Created by Abhay Shankar on 22/02/17.
//
//


#import "Macro.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface BeaconMonitor : NSObject<CLLocationManagerDelegate>
{
    NSArray *arrUUIDs;
    CLBeaconRegion *currentRegion;
}
@property (strong, nonatomic) CLLocationManager *locationManager;


+(id)sharedManager;

/**
 Starts ranging for beacons transmiting advetisements.
 */
-(void)startRangingForiBeacons;

/**
 Stops ranging for beacons.
 */
-(void)stopRangingForiBeacons;

@end
