//
//  ViewController.m
//  UniversalJump
//
//  Created by yinhe on 2019/3/25.
//  Copyright © 2019 yinhe. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

@interface ViewController ()

@property (nonatomic, weak) UISegmentedControl * seg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    
    NSArray * array = @[@"消息1",@"消息2",@"消息3",@"消息4"];
    UISegmentedControl * seg = [[UISegmentedControl alloc]initWithItems:array];
    seg.frame = CGRectMake(70, 200, 240, 45);
    [self.view addSubview:seg];
    seg.selectedSegmentIndex = 0;
    self.seg = seg;
    
    UIButton * jupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jupBtn.frame = CGRectMake(100, 250, 60, 45);
    [jupBtn setTitle:@"跳转" forState:UIControlStateNormal];
    [jupBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    jupBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:jupBtn];
    [jupBtn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    //创建Class
    //objc_allocateClassPair(Class superclass, const char * name, size_t extraBytes)
    //注册Class
    //void objc_registerClassPair(Class cls)
    //添加变量
    //class_addIvar(Class cls, const char * name,size_t size, uint8_t alignment , const char * types)
    //添加方法
    //class_addMethod(Class cls, SEL name, IMP  imp, const char * types)
    //获取属性
    //class_getProperty(Class  cls, const char * name)
    //获取实例变量
    //class_getInstanceVariable(Class cls, const char * name)
}

-(void)action{
    
    NSDictionary * infoDic = nil;
    
    switch (self.seg.selectedSegmentIndex) {
        case 0:
            infoDic = @{@"class":@"FirstViewController",
                        @"property":@{
                                @"name":@"尼古拉斯赵四"
                                }
                        };
            break;
        case 1:
            infoDic = @{@"class":@"SecondViewController",
                        @"property":@{
                                @"age":@"26",
                                @"sex":@"男"
                                }
                        };
            break;
        case 2:
            infoDic = @{@"class":@"ThredViewController",
                        @"property":@{
                                @"teacher":@"王老师",
                                @"money":@"5000"
                                }
                        };
            break;
        case 3:
            //NewViewController
            infoDic = @{@"class":@"WorkerController",
                        @"property":@{
                                @"phoneNumber":@"17710948530"
                                }
                        };
            break;
            
        default:
            break;
    }
    
    [self pushToControllerWithData:infoDic];
    
}
-(void)pushToControllerWithData:(NSDictionary * )vcData{
    //1.获取class
    const char * className = [vcData[@"class"] UTF8String];
    Class cls = objc_getClass(className);
    if(!cls){
        //创建新的类，并添加变量和方法
        Class superClass = [UIViewController class];
        cls = objc_allocateClassPair(superClass, className, 0);
        //添加phoneNumber变量
        class_addIvar(cls, "phoneNumber", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
        //添加titleLab控件
        class_addIvar(cls, "titleLab", sizeof(UILabel *), log2(sizeof(UILabel *)), @encode(UILabel *));
        //添加方法，方法交换，执行viewDidLoad加载
        Method method = class_getInstanceMethod([self class], @selector(workerLoad));
        IMP methodIMP = method_getImplementation(method);
        const char * types = method_getTypeEncoding(method);
        class_addMethod(cls, @selector(viewDidLoad), methodIMP, types);
    }
    //2.创建实例对象，给属性赋值
    id instance = [[cls alloc]init];
    NSDictionary * values = vcData[@"property"];
    [values enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //检测是否存在为key的属性
        if(class_getProperty(cls, [key UTF8String])){
            [instance setValue:obj forKey:key];
        }
        //检测是否存在为key的变量
        else if (class_getInstanceVariable(cls, [key UTF8String])){
            [instance setValue:obj forKey:key];
        }
    }];
    
    //2.跳转到对应的界面
    [self.navigationController pushViewController:instance animated:YES];
    
}

-(void)workerLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    //初始化titleLab
    [self setValue:[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 40)] forKey:@"titleLab"];
    UILabel * titleLab = [self valueForKey:@"titleLab"];
    //添加到视图上
    [[self valueForKey:@"view"] performSelector:@selector(addSubview:) withObject:titleLab];
    titleLab.text =[self valueForKey:@"phoneNumber"];
    titleLab.textColor = [UIColor blackColor];
    
}

@end
