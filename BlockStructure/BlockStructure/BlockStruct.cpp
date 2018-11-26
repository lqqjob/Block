//
//  BlockStruct.cpp
//  BlockStructure
//
//  Created by liqiang on 2018/11/26.
//  Copyright © 2018 lqqjob. All rights reserved.
//

#include "BlockStruct.hpp"
struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};


struct __block_impl_0 {
    struct __block_impl impl;
    struct __block_desc_0* Desc;
    int *i;
    __block_impl_0(void *fp,struct __block_desc_0 *desc,int *_i,int flags=0):i(_i) {
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};

static void __block_func_0(struct __block_impl_0 * cself) {
    printf("block 实现 %d \n",*(cself->i));
    *(cself->i) = 10000;
}

static struct __block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __block_desc_0_DATA = {0,sizeof(struct __block_impl_0)};




void test() {
    
    int i = 100;
    
    struct __block_impl_0 imp = __block_impl_0((void *)__block_func_0,&__block_desc_0_DATA,&i);
    
    void(*impPointer)() = (void(*)())&imp;
    
    __block_impl *tmpPointer = (__block_impl *)impPointer;
    
    void (*Func)(__block_impl *) = (void(*)(__block_impl *))tmpPointer->FuncPtr;
    
    Func(tmpPointer);
    printf("block 调用之后 %d",i);

    return;
    
}
