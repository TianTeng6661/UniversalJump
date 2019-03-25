//
//  ThredViewController.m
//  UniversalJump
//
//  Created by yinhe on 2019/3/25.
//  Copyright © 2019 yinhe. All rights reserved.
//

#import "ThredViewController.h"

@interface ThredViewController ()

@end

@implementation ThredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
    titleLab.textColor = [UIColor blackColor];
    [self.view addSubview:titleLab];
    
    titleLab.text = [NSString stringWithFormat:@"%@--%@",self.teacher,self.money];
    
}



@end
