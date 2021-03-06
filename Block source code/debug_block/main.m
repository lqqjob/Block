//
//  main.m
//  debug_block
//
//  Created by liqiang on 2018/11/26.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <Block.h>

typedef void(^EOCBlock)(void);

//block源代码：https://opensource.apple.com/source/libclosure/libclosure-65/
//工程的搭建参考：http://blog.csdn.net/wotors/article/details/52489464
//main.m 转成C++的代码命令（xcode 9.4下）：xcrun -sdk macosx10.13 clang -S -rewrite-objc -fobjc-arc main.m

///分析源代码的目的：
//block本身是在栈，当在arc下，赋值给strong或copy修饰的block变量，block会自动从栈拷贝到堆区，这个流程是怎么样的？
//1、__block修饰的外部变量
//2、非__block修饰的外部变量
//这个过程会明白到block结构里的一些变量到底起什么作用

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        __block NSButton *btn = [[NSButton alloc] init];
        
        void (^block)(void) = Block_copy( ^{
            
            NSLog(@"这是自己的block %@", btn);
            
        });
        
        block();
        
    }
    return 0;
}








//-fno-objc-arc
