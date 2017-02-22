//
//  ThanariAdv.h
//  Pods
//
//  Created by Abhay Shankar on 21/02/17.
//
//


#import "Macro.h"
#import <UIKit/UIKit.h>


@interface ThanariAdv : NSObject

+(id)sharedManager;


@property (strong, nonatomic) NSTimer *timeAPI; // to call api after a particulat time

/**
 Starts the advertisement service and ranging for beacons.
 
 @param launchOptions The launchOptions from applicationDidFinishLaunchingwithOptions
 */

-(void)startThanariAdvertisementwithLaunchOptions:(NSDictionary *)launchOptions;

/**
 Stops ranging for beacons and advertisement Service.
*/
-(void)stopThanariAdvertisement;

/*
 Perform as per local notification data
 
 @param notification th local notification from didRecieveLocalNotification
 */
-(void)didReceiveLocalNotification:(UILocalNotification *)notification;

@end
