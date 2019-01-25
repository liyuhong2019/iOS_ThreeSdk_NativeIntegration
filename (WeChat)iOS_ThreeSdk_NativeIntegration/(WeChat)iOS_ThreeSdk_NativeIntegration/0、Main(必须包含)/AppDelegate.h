#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end



/**
 使用之前
    请阅读 (README)0、Main(必须包含).md
 
 本项目使用的是手动集成
 参考3.2的手动集成 https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417694084&token=&lang=zh_CN

 
 1、导入依赖库(微信开放平台使用的功能依赖于系统的库)
    SystemConfiguration.framework, libz.dylib, libsqlite3.0.dylib, libc++.dylib, Security.framework, CoreTelephony.framework, CFNetwork.framework
 2、编译设置 Build Setting
    在"Other Linker Flags"中加入"-Objc -all_load"，在Search Paths中添加 libWeChatSDK.a ，WXApi.h，WXApiObject.h，文件所在位置
 
 3、配置URL type 添加 URL scheme (这个使用于 跳转到第三方之后 标记怎么回到之前的App)
    选择你的工程设置项，选中“TARGETS”一栏，在“info”标签栏的“URL type“添加“URL scheme”为你所注册的应用程序id
 
 4、在Xcode中，选择你的工程设置项，选中“TARGETS”一栏，在“info”标签栏的“LSApplicationQueriesSchemes“添加weixin（如下图所示）。
 
 注:这里我就随便拿公司一个项目已经申请过的这些功能的id过来集成了
    wxb932a84da14f3a96
 
 ---- go2 code 开始编写代码
 
 */



/**
 项目扩展知识篇
 other linker flags的作用 https://blog.csdn.net/bobo553443/article/details/78633340
 */
