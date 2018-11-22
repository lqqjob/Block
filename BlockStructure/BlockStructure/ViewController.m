//
//  ViewController.m
//  BlockStructure
//
//  Created by liqiang on 2018/11/22.
//  Copyright © 2018 lqqjob. All rights reserved.
//

#import "ViewController.h"
typedef void(^eocblock)(void);

@interface ViewController () {
    
    UILabel *label;
    eocblock instanceBlock;
    
}

@end

int globalValueOne = 10;
static int staticValue = 5;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self emptyBlcokFun];
}

//
- (void)emptyBlcokFun {
    void (^emptyBlock)(void) = ^(){
        NSLog(@"amptyBlock");
    };
    
    emptyBlock();
}


- (void)simpleDataBlockFunction {
    
    int i = 10;
    
    void (^simpleDataBlock)(void) = ^{
        
        NSLog(@"simpleDataBlockFunction %d", i);
        
    };
    
    NSLog(@"i == %d", i);
    
    simpleDataBlock();
}

- (void)objcDataBlockFunction {
    
    UILabel *tmpLabel = [[UILabel alloc] init];
    
    void (^objcDataBlock)(void) = ^{
        
        NSLog(@"八点钟学院, %@", tmpLabel);
        
    };
    
    objcDataBlock();
}

- (void)weakObjcDataBlockFunction {
    
    __weak UILabel *tmpLabel = [[UILabel alloc] init];
    
    void (^objcDataBlock)(void) = ^{
        
        NSLog(@"八点钟学院, %@", tmpLabel);
        
    };
    
    objcDataBlock();
}


- (void)classDataBlockFunction {
    
    void (^classDataBlock)(void) = ^{
        
        NSLog(@"八点钟学院 %@", label);
        
    };
    
    classDataBlock();
}


- (void)blockDataBlockFunction {
    
    __block int a = 100;   ///栈区
    
    void (^blockDataBlock)(void) = ^{
        
        a = 1000;
        NSLog(@"八点钟学院, %d", a);     ///堆区
        
    };
    
    blockDataBlock();
    NSLog(@"a = %d", a);
    
}

- (void)globalDataBlockFunction {
    
    void (^globalDataBlock)(void) = ^{
        
        NSLog(@"八点钟学院 %d", globalValueOne);
        
    };
    
    globalDataBlock();
}

- (void)staticDataBlockFunction {
    
    void (^staticDataBlock)(void) = ^{
        
        NSLog(@"八点钟学院 %d", staticValue);
        
    };
    
    staticDataBlock();
}

- (void)tmpStaticDataBlockFunction {
    
    static int b = 11;
    
    instanceBlock = ^{
        
        //        b = 110;
        NSLog(@"八点钟学院 %d", b);
        
    };
    
    b= 100;
    instanceBlock();
}


@end
