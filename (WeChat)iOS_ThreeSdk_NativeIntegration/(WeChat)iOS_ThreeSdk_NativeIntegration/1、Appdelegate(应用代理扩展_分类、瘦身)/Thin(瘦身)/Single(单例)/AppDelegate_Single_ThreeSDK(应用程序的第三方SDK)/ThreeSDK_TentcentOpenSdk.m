#import "ThreeSDK_TentcentOpenSdk.h"

@implementation ThreeSDK_TentcentOpenSdk
// 单例对象
+ (ThreeSDK_TentcentOpenSdk *)getInstance{
    static ThreeSDK_TentcentOpenSdk *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// 初始化的时候调用
- (id)init{
    if (self = [super init]) {
        NSLog(@"%s , 初始化腾讯 微信开放平台 --- start",__func__);
        [self lyh_initThreeSDK_TentcentOpenSdk];
        NSLog(@"%s , 初始化腾讯 微信开放平台 --- end",__func__);
        
        // 故意演示闪退代码
        //        [self lyh_tencentBuglyTestDebug];
    }
    return self;
}

#pragma mark - 初始化 腾讯 微信开放平台 start
- (void)lyh_initThreeSDK_TentcentOpenSdk
{
    NSLog(@"%s , 初始化",__func__);
    //向微信注册
    [WXApi registerApp:ThreeSDK_TentcentOpenSdk_AppID];
}
#pragma mark  初始化 腾讯微信开放平台 end

#pragma mark -  腾讯 微信开放平台 代理 start
// 打开
- (BOOL)wx_application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)wx_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}


#pragma 登录授权代理
#pragma mark 1、微信授权第一步：获取code
- (void)onResp:(BaseResp *)resp
{
    NSLog(@"回调处理");
    // 处理 分享请求 回调
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        switch (resp.errCode) {
            case WXSuccess:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"分享成功!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
                
            default:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"分享失败!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
        }
//        self.messageTool = [SendMessageToool showMessage];
//        [self.messageTool fireEvent:@"returnIOSFenXiangWeiXin" args:[NSString stringWithFormat:@"%d",resp.errCode]];
    }
    else
        if ([resp isKindOfClass:[SendAuthResp class]])
        {
#pragma mark 1、微信授权第一步：获取code
            
            switch (resp.errCode)
            {
                case 0:
                {
                    // 用户同意 获取code
                    SendAuthResp *yuResp = (SendAuthResp *)resp;
                    NSLog(@"code == %@",yuResp.code);
                    [self getWeiXinOpenId:yuResp.code];
                }
                    break;
                case -4://用户拒绝授权
                {
                    NSLog(@"您拒绝授权微信登录");
                }
                    break;
                case -2://用户取消
                {
                    NSLog(@"您取消了授权微信登录");
                }
                    break;
            }
        }
    
}


#pragma mark 3、微信授权第三步：通过access_token获取个人信息
/**
 通过code和应用的appid、appsecret
 去获取access_token 和openid 或者 unionid
 */
-(void)getWeiXinOpenId:(NSString *)code{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",ThreeSDK_TentcentOpenSdk_AppID,ThreeSDK_TentcentOpenSdk_Appecret,code];
//    NSString *url;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@"dic %@",[dic lyh_jsonLog_descriptionWithLocale:nil]);
                NSString *openID = dic[@"openid"];
                NSString *unionid = dic[@"unionid"];
                NSString *access_token = dic[@"access_token"];
                
//                NSLog(@"openID %@",openID);
//                NSLog(@"unionid %@",unionid);
//                NSLog(@"access_token %@",access_token);
                [self getWeiXinUserInfoAccessToken:access_token Openid:openID];
            }
        });
    });
}

/**
 通过access_token 和 openid 去获取个人信息
 */
-(void)getWeiXinUserInfoAccessToken:(NSString *)access_token Openid:(NSString *)openId{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                //                NSLog(@"dic %@",[dic lyh_jsonLog_descriptionWithLocale:nil]);
//                self.weChatOauthMsg = [dic lyh_jsonLog_descriptionWithLocale:nil];
#pragma 获取到授权的信息
//                NSLog(@"dic %@",[self dictToStrWith:dic]);
                self.oauthMsg = [self dictToStrWith:dic];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    self.messageTool = [SendMessageToool showMessage];
//                    NTESAppDelegate *AppDelegate = (NTESAppDelegate *)[UIApplication sharedApplication].delegate;
//                    [self.messageTool fireEvent:@"returnWeiXinLogin" args:AppDelegate.weChatOauthMsg];
                });
//                NSLog(@"weChatOauthMsg %@",self.weChatOauthMsg);
                
            }
        });
    });
}

// 将字典 转出 json字符串
- (NSString *)dictToStrWith:(NSDictionary *)dict
{
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

#pragma mark  初始化 腾讯 微信开放平台 代理 end
@end
