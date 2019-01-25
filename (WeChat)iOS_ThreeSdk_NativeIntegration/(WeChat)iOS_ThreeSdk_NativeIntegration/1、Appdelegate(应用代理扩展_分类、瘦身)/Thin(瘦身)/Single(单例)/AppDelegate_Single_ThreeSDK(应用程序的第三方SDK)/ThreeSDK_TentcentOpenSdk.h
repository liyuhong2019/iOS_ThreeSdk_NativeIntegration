/**
 微信开放平台
 产品名称 : TC青之蓝漫画
 App ID : wxb932a84da14f3a96
 App Key : 0791e21742d6dd9d8e2bbe1e0d21c6fd
 */

// 宏定义
#define ThreeSDK_TentcentOpenSdk_AppID @"wxb932a84da14f3a96"
#define ThreeSDK_TentcentOpenSdk_Appecret @"0791e21742d6dd9d8e2bbe1e0d21c6fd"

#import <Foundation/Foundation.h>
#import "WXApi.h"
@interface ThreeSDK_TentcentOpenSdk : NSObject<WXApiDelegate>
@property (nonatomic,strong) NSString *oauthMsg;

+ (ThreeSDK_TentcentOpenSdk *)getInstance;

//
- (BOOL)wx_application:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (BOOL)wx_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end
