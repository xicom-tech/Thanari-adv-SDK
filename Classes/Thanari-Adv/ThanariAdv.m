//
//  ThanariAdv.m
//  Pods
//
//  Created by Abhay Shankar on 21/02/17.
//
//
#import "LocalNotificationManager.h"
#import "ThanariAdv.h"
#import "BeaconMonitor.h"

@implementation ThanariAdv

+(id)sharedManager
{
    
    static ThanariAdv *sharedThanariManager=nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedThanariManager=[[self alloc] init];
        
    });
    
    return sharedThanariManager;
}

-(instancetype)init
{
    
    return self;
}


#pragma mark - Init

-(void)startThanariAdvertisementwithLaunchOptions:(NSDictionary *)launchOptions
{
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        
        [[UIApplication sharedApplication] registerUserNotificationSettings :[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    //Pass the launchOption for processing in case from Local notification
    
    [[LocalNotificationManager sharedManager] appLaunchedWithOptions:launchOptions];
    
 
    //Call API For fetching UUIDs to monitor (max 20 allowed)
    
    
    
    
    // starts ranging for the UUIDs
    
    [[BeaconMonitor sharedManager] startRangingForiBeacons];
}

-(void)stopThanariAdvertisement
{
    //Stop updating UUID's API
    
    

    
    // starts ranging for the UUIDs
    
    [[BeaconMonitor sharedManager] stopRangingForiBeacons];
}

-(void)didReceiveLocalNotification:(UILocalNotification *)notification
{
    //Pass the launchOption for processing in case from Local notification
    
    [[LocalNotificationManager sharedManager] recivedLocalNotification:notification];
    

}
@end
