//
//  FirstViewController.m
//  tabbarDemo
//
//  Created by MD101 on 14-10-8.
//  Copyright (c) 2014年 TabBarDemo. All rights reserved.
//

#import "FirstViewController.h"
#import "Masonry.h"
#import "JSONKit.h"
#import "Reachability.h"
#import "AFNetworking.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor redColor];
        self.title = @"联系人";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 60)];
    [button setBackgroundColor:[UIColor purpleColor]];
    [button setTitle:@"响应事件" forState:UIControlStateNormal];
    button.layer.cornerRadius = 10.f;
    [button addTarget:self action:@selector(goOtherView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
    
    UIButton *noticationBtn = [UIButton new];
    noticationBtn.backgroundColor  = [UIColor lightGrayColor];
    [self.view addSubview:noticationBtn];
    [noticationBtn setTitle:@"数据测试" forState:UIControlStateNormal];
    [noticationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [noticationBtn.layer setCornerRadius:5.0f];
    [noticationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.mas_left);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
        make.top.equalTo(button.mas_bottom).offset(20);

    }];
    

}

#pragma mark 点击按钮进入其他界面

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    //[self.delegate isHiddenCustomTabBarByBoolean:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
