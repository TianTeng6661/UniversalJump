//
//  FirstViewController.m
//  UniversalJump
//
//  Created by yinhe on 2019/3/25.
//  Copyright © 2019 yinhe. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
    titleLab.textColor = [UIColor blackColor];
    [self.view addSubview:titleLab];
    titleLab.text =self.name;
    
}


@end
