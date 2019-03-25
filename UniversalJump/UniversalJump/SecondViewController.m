//
//  SecondViewController.m
//  UniversalJump
//
//  Created by yinhe on 2019/3/25.
//  Copyright © 2019 yinhe. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
    titleLab.textColor = [UIColor blackColor];
    [self.view addSubview:titleLab];
    titleLab.text = [NSString stringWithFormat:@"%@--%@",self.age,self.sex];
}


@end
