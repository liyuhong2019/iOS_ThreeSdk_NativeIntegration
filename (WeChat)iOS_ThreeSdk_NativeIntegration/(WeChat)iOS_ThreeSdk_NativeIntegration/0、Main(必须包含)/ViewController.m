#import "ViewController.h"
#import "ThreeSDK_TentcentOpenSdk.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UITextView *tf_getWeChatInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self custom_UISetings];
}
- (IBAction)go2LoginWeChat:(UIButton *)sender {
    NSLog(@"去微信授权登录获取数据 %s",__func__);
    
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        //这里是按照官方文档的说明来的此处我要获取的是个人信息内容
        req.scope = @"snsapi_userinfo";
        req.state = @"";
        //向微信终端发起SendAuthReq消息
        [WXApi sendReq:req];
    } else {
        NSLog(@"安装微信客户端");
    }
    
    
#warning 这里做一个获取信息 延迟获取
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"授权之后 返回的数据 %@", [ThreeSDK_TentcentOpenSdk getInstance].oauthMsg);
        self.tf_getWeChatInfo.text =[NSString stringWithFormat:@"微信授权之后返回的信息:%@",[ThreeSDK_TentcentOpenSdk getInstance].oauthMsg];
        
        
// 设置授权之后的图片
        NSString *str = @"http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKKV3BuNiaPV1GEKW7tic9Bbz39YAWbWHph2TheC6RVliaic3HgUXN7tYNaeI1peLia3iaSlGA4BTtf8a2w/132";
        
        NSURL *url = [NSURL URLWithString:str];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.img.image = [[UIImage alloc]initWithData:data];
    });
}


#pragma mark - 自定义方法
/**
 UI设置
 */
- (void)custom_UISetings
{
    self.img.layer.borderColor = [UIColor redColor].CGColor;
    self.img.layer.borderWidth = 2;
}

@end
