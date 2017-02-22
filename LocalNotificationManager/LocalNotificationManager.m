//
//  LocalNotificationManager.m
//  Pods
//
//  Created by Abhay Shankar on 22/02/17.
//
//

#import "LocalNotificationManager.h"

@implementation LocalNotificationManager


+(id)sharedManager
{
    
    static LocalNotificationManager *sharedLocalNotificationManager=nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedLocalNotificationManager=[[self alloc] init];
        
    });
    
    return sharedLocalNotificationManager;
}

-(instancetype)init
{
    
    return self;
}

#pragma mark - Init

-(void)appLaunchedWithOptions:(NSDictionary *)launchOptions
{
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey]) {
        [self recivedLocalNotification:[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey]];
    }
}

-(void)recivedLocalNotification:(UILocalNotification *)notification
{
    if ([notification.userInfo objectForKey:kUniqueIdentifier])
    {
        if ([[notification.userInfo objectForKey:kUniqueIdentifier] isEqualToString:@"Thanari"]) {
            
            // The notofication was generated from the beacon
            [self processLocalNotification:notification.userInfo];
        }
    }
}

-(void)processLocalNotification:(NSDictionary*)userDict
{
    NSString *str = [userDict objectForKey:@"url"];
    
    [self showAlertMessage:str];
}

-(UIViewController*)getTopViewCOntroller
{
    id rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    if([rootViewController isKindOfClass:[UINavigationController class]])
    {
        rootViewController = ((UINavigationController *)rootViewController).topViewController;
    }
    if([rootViewController isKindOfClass:[UITabBarController class]])
    {
        rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
    }
    return rootViewController;
}


-(void)showAlertMessage:(NSString*)strMessage
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Beacon Detected"
                                      message:strMessage
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * yesButton = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         //Handel your yes please button action here
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
        
        [alert addAction:yesButton];
        [[self getTopViewCOntroller] presentViewController:alert animated:YES completion:nil];
    });
    

    
    
}

@end
