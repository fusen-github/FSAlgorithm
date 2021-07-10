//
//  main.m
//  01-BinaryTree
//
//  Created by 付森 on 2021/7/10.
//

#import <Foundation/Foundation.h>
#import "BinaryTree.h"
#import "NSNumber+Extension.h"


/**
 测试二叉搜索树
 */
static void func01()
{
    BinaryTree *tree = [[BinaryTree alloc] init];
    
    for (int i= 0; i < 10; i++) {
        
        int value = arc4random_uniform(1000) + 1;
        
        [tree insertItem:@(value)];
        
        printf("%d, ", value);
    }
    
    printf("\n");
        
    __block int index = 0;
    [tree preorderEnumerate:^(id<FSComparable> item, BOOL *stop) {
        
        NSString *valueDescription = [item description];
        printf("%s, ", [valueDescription UTF8String]);
        
        index++;
        
        if (index == 5) {
            *stop = YES;
        }
    }];
    
    printf("\n");
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        func01();
        
        NSLog(@"end");
    }
    return 0;
}
