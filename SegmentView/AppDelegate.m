//
//  AppDelegate.m
//  SegmentView
//
//  Created by linyansen on 2025/7/29.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *rootView = [[ViewController alloc] init];
//    rootView.view.frame = CGRectMake(0, 200, 320, 300);
    self.navController = [[UINavigationController alloc] initWithRootViewController:rootView];
//    self.navController.navigationBarHidden = YES;
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
