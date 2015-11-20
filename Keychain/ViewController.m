//
//  ViewController.m
//  Keychain
//
//  Created by zhcpeng on 15/11/20.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

#import "ViewController.h"

#import "KeychainItemWrapper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *logLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self setKeyChainValue];
//    NSLog(@"Get UUID: %@",[self gen_uuid]);
    
    
    KeychainItemWrapper *keyChainItem=[[KeychainItemWrapper alloc]initWithIdentifier:@"MyUUID" accessGroup:@"971954561.com.hml17.shop"];
    NSString *strUUID = [keyChainItem objectForKey:(id)kSecValueData];
//    const char *sid = [strUUID UTF8String];
//    printf("%s",sid);
    
    if (strUUID==nil||[strUUID isEqualToString:@""])
    {
        [keyChainItem setObject:[self gen_uuid] forKey:(id)kSecValueData];
        
        //新设备第一次运行，新用户
        //这里 补充用户代码
        
        _logLabel.text = [NSString stringWithFormat:@"当前为新用户：\nUUID为：%@",strUUID];
        
    }else{
        // strUUID 为唯一标识符
        // 用户重装应用后不改变
        //这是补充老用户代码
        
        _logLabel.text = [NSString stringWithFormat:@"当前为老用户：\nUUID为：%@",strUUID];
    }
    NSLog(@"UUID:%@",strUUID);
    
    
//    //保存数据
//    [wrapper setObject:@"<帐号>" forKey:(id)kSecAttrAccount];
//    
//    [wrapper setObject:@"<帐号密码>" forKey:(id)kSecValueData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void) setKeyChainValue
//{
//    KeychainItemWrapper *keyChainItem=[[KeychainItemWrapper alloc]initWithIdentifier:@"MyUUID" accessGroup:@"971954561.com.hml17.shop"];
//    NSString *strUUID = [keyChainItem objectForKey:(id)kSecValueData];
//    if (strUUID==nil||[strUUID isEqualToString:@""])
//    {
//        [keyChainItem setObject:[self gen_uuid] forKey:(id)kSecValueData];
//    }
//}

-(NSString *) gen_uuid
{
    CFUUIDRef uuid_ref=CFUUIDCreate(nil);
    CFStringRef uuid_string_ref=CFUUIDCreateString(nil, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid=[NSString stringWithString:(__bridge NSString * _Nonnull)(uuid_string_ref)];
    CFRelease(uuid_string_ref);
    return uuid;
}

@end
