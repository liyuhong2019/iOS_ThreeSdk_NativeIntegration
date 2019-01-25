/**
 1、APPDelegate 生命周期
 https://www.cnblogs.com/junhuawang/p/5742535.html
 2、Appdelegate 瘦身(分类、单例等)
 https://www.jianshu.com/p/20f852bfef75
 */

#import "AppDelegate.h"
#import "ThreeSDK_TentcentOpenSdk.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ThreeSDK_TentcentOpenSdk *weChatSdk = [ThreeSDK_TentcentOpenSdk getInstance];
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [[ThreeSDK_TentcentOpenSdk getInstance] wx_application:application handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[ThreeSDK_TentcentOpenSdk getInstance] wx_application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
