//
//  ViewController.m
//  BolckClass
//
//  Created by liqiang on 2018/11/21.
//  Copyright © 2018 lqqjob. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self blockClass];
}

- (void)blockClass {
    //定义局部变量 i
    int i = 0;
    
    NSLog(@"\n=====================block 没有引入外部变量");
    //block 没有引用局部变量 i
    void (^tempBlock1)(int a) = ^(int a) {

    };
    
    //打印 block 的class
    NSString * tempBlock1Class = NSStringFromClass([tempBlock1 class]);
    NSLog(@"tempBlock1Class %@",tempBlock1Class);
    
    //循环打印block的父类，直到父类为空
    Class tempBlock1SuperClass = class_getSuperclass([tempBlock1 class]);
    
    while (tempBlock1SuperClass) {
        NSLog(@"tempBlock1SuperClass %@",NSStringFromClass(tempBlock1SuperClass));
        tempBlock1SuperClass = class_getSuperclass(tempBlock1SuperClass);
    }
    
    NSLog(@"\n=====================block 引入外部变量");
    //block 引用局部变量 i
    void (^tempBlock2)(int a) = ^(int a) {
        NSLog(@"%d",i);
    };
    
    //打印 block 的class
    NSString * tempBlock2Class = NSStringFromClass([tempBlock2 class]);
    NSLog(@"tempBlock2Class %@",tempBlock2Class);
    
    //循环打印block的父类，直到父类为空
    Class tempBlock2SuperClass = class_getSuperclass([tempBlock2 class]);
    
    while (tempBlock2SuperClass) {
        NSLog(@"tempBlock2SuperClass %@",NSStringFromClass(tempBlock2SuperClass));
        tempBlock2SuperClass = class_getSuperclass(tempBlock2SuperClass);
    }
    
    
    NSLog(@"\n===================== weak block 引入外部变量");
    //block 引用局部变量 i
    __weak void (^weakBlock)(int a) = ^(int a) {
        NSLog(@"%d",i);
    };
    
    //打印 block 的class
    NSString * weakBlockClass = NSStringFromClass([weakBlock class]);
    NSLog(@"weakBlockClass %@",weakBlockClass);
    
    //循环打印block的父类，直到父类为空
    Class weakBlockSuperClass = class_getSuperclass([weakBlock class]);
    
    while (weakBlockSuperClass) {
        NSLog(@"weakBlockSuperClass %@",NSStringFromClass(weakBlockSuperClass));
        weakBlockSuperClass = class_getSuperclass(weakBlockSuperClass);
    }
}

@end
