//
//  LocalNotificationManager.h
//  Pods
//
//  Created by Abhay Shankar on 22/02/17.
//
//

#import "Macro.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LocalNotificationManager : NSObject


+(id)sharedManager;

/**
 Perform as per local notification data in launch options.
 
 @param launchOptions The launchOptions from applicationDidFinishLaunchingwithOptions
 */
-(void)appLaunchedWithOptions:(NSDictionary *)launchOptions;

/*
 Perform as per local notification data
 
 @param notification th local notification from didRecieveLocalNotification
 */
-(void)recivedLocalNotification:(UILocalNotification *)notification;

@end
