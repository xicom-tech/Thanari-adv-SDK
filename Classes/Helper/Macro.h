//
//  Macro.h
//  Pods
//
//  Created by Abhay Shankar on 22/02/17.
//
//

#ifndef Macro_h
#define Macro_h

#define SAVE_USER_DEFAULTS(VALUE,KEY)       [[NSUserDefaults standardUserDefaults] setObject:VALUE forKey:KEY]; [[NSUserDefaults standardUserDefaults] synchronize]
#define GET_USER_DEFAULTS(KEY)              [[NSUserDefaults standardUserDefaults] objectForKey:KEY]
#define REMOVE_USER_DEFAULTSFOR(KEY)        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY]

#define kUniqueIdentifier @"UniqueIdentifier"

#endif /* Macro_h */
