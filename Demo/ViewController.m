//
//  ViewController.m
//  Demo
//
//  Created by 佐毅 on 15/10/11.
//  Copyright © 2015年 上海乐住信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *login;
- (IBAction)Login:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Login:(id)sender {
    
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"mimiss";
    [WXApi sendReq:req];
}
@end
