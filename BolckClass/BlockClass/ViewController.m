//
//  ViewController.m
//  BolckClass
//
//  Created by liqiang on 2018/11/21.
//  Copyright © 2018 lqqjob. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

typedef void(^MyBlock)(int a);

@interface ViewController ()

@property (nonatomic, strong) MyBlock  stongBlock;
@property (nonatomic, copy) MyBlock  copyBlock;
@property (nonatomic, weak) MyBlock  weakBlock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self blockClass];
    
    [self blockMemory];
}


- (void)blockClass {
    //定义局部变量 i
    int i = 0;
    
    NSLog(@"\n=====================block 没有引用外部变量");
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
    
    NSLog(@"\n=====================block 引用外部变量");
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
    
    
    NSLog(@"\n===================== weak block 引用外部变量");
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
/**
 结论：
 Block 总共有三种类型分别是：
 1、__NSGlobalBlock__ -> __NSGlobalBlock -> NSBlock -> NSObject
 2、__NSMallocBlock__ -> __NSMallocBlock -> NSBlock -> NSObject
 3、__NSStackBlock__ -> __NSStackBlock -> NSBlock -> NSObject
 
 Block 总共就是三种类型，从名称可以看出，这三种类型分别是在全局区、堆区、栈区，那么他们分别是在什么情况下产生的？，请看BlockMemory
 */
    
}

static int c = 0;

- (void)blockMemory {
    
    NSLog(@"\n=====================block 内存分布");

//    首先定义了三个block 分别用strong、cope、weak修饰
    
//    1、三种类型的block 都没有引用外部变量
    
    _stongBlock = ^(int a) {
        NSLog(@"%d",a);
    };
    
    _copyBlock = ^(int a) {
        NSLog(@"%d",a);
    };
    
    _weakBlock = ^(int a) {
        NSLog(@"a");
    };
    
    NSLog(@"1、三种类型的block 都没有引用外部变量 \n _strongBlock:%@ \n _copyBlock:%@ \n _weakBlock:%@ \n",NSStringFromClass([_stongBlock class]),NSStringFromClass([_copyBlock class]),NSStringFromClass([_weakBlock class]));
    
//    结论：strong、copy、weak修饰的block没有引用外部变量时都分布在全局区
    
//     2、三种类型的block 引用局部静态变量
    static int b = 0;
    
    _stongBlock = ^(int a) {
        NSLog(@"%d",b);
    };
    
    _copyBlock = ^(int a) {
        NSLog(@"%d",b);
    };
    
    _weakBlock = ^(int a) {
        NSLog(@"%d",b);
    };
    
    
    NSLog(@"2、三种类型的block 引用局部静态变量 \n _strongBlock:%@ \n _copyBlock:%@ \n _weakBlock:%@ \n",NSStringFromClass([_stongBlock class]),NSStringFromClass([_copyBlock class]),NSStringFromClass([_weakBlock class]));

//        结论：strong、copy、weak修饰的block引用局部静态变量时都分布在全局区
    
//      3、三种类型的block 引用全局静态变量

    _stongBlock = ^(int a) {
        NSLog(@"%d",c);
    };
    
    _copyBlock = ^(int a) {
        NSLog(@"%d",c);
    };
    
    _weakBlock = ^(int a) {
        NSLog(@"%d",c);
    };
    
    NSLog(@"3、三种类型的block 引用全局静态变量 \n _strongBlock:%@ \n _copyBlock:%@ \n _weakBlock:%@ \n",NSStringFromClass([_stongBlock class]),NSStringFromClass([_copyBlock class]),NSStringFromClass([_weakBlock class]));

//            结论：strong、copy、weak修饰的block引用全局静态变量时都分布在全局区
    
    
//          4、三种类型的block 引用局部变量
    
    int d = 0;
    _stongBlock = ^(int a) {
        NSLog(@"%d",d);
    };
    
    _copyBlock = ^(int a) {
        NSLog(@"%d",d);
    };
    
    _weakBlock = ^(int a) {
        NSLog(@"%d",a);
    };
    _weakBlock(1000000);
    NSLog(@"4、三种类型的block 引用局部变量 \n _strongBlock:%@ \n _copyBlock:%@ \n _weakBlock:%@ \n",NSStringFromClass([_stongBlock class]),NSStringFromClass([_copyBlock class]),NSStringFromClass([_weakBlock class]));
    
//                结论：1、strong、copy修饰的block引用局部变量时分布在堆区
//                     2、weak修饰的block引用局部变量时分布在堆区


    /**
     总结：
     1、strong、copy、weak修饰的block没有引用外部变量时都分布在全局区；
     2、strong、copy、weak修饰的block引用局部静态变量、全局静态变量时都分布在全局区；
     3、strong、copy、weak修饰的block引用局部变量时
        3.1 weak修饰的block引用局部变量时分布在栈区；
        3.2 strong、copy修饰block引用局部变量时分布在堆区；
        3.3 strong、copy修饰block的作用是一样的；
        3.4 block引用局部变量都是分配在栈区，只不过用strong、copy修饰的block会由栈区拷贝到堆区（后面会证明，先记住）
     
     */

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _weakBlock(123);
}


@end
