//
//  main.m
//  01-BinarySearchTree
//
//  Created by 付森 on 2021/7/10.
//

#import <Foundation/Foundation.h>
#import "BinarySearchTree.h"
#import "NSNumber+Extension.h"


/**
 测试二叉搜索树
 */
static void func01()
{
    BinarySearchTree *tree = [[BinarySearchTree alloc] init];
    printf("源始数据:\n");
    for (int i= 0; i < 10; i++) {
        
        int value = arc4random_uniform(1000) + 1;
        
        [tree insertItem:@(value)];
        
        printf("%d, ", value);
    }
    
    printf("\n");
    
    printf("前序遍历:\n");
    __block int index = 0;
    [tree preorderEnumerate:^(id<FSComparable> item, BOOL *stop) {
        NSString *valueDescription = [item description];
        printf("%s, ", [valueDescription UTF8String]);
        index++;
        if (index == 4) {
            *stop = YES;
        }
    }];
    printf("\n");
    
    printf("中序遍历:\n");
    index = 0;
    [tree inorderEnumerate:^(id<FSComparable> item, BOOL *stop) {
        NSString *valueDescription = [item description];
        printf("%s, ", [valueDescription UTF8String]);
        index++;
//        if (index == 8) {
//            *stop = YES;
//        }
    }];
    printf("\n");
    
    printf("后序遍历:\n");
    index = 0;
    [tree postorderEnumerate:^(id<FSComparable> item, BOOL *stop) {
        NSString *valueDescription = [item description];
        printf("%s, ", [valueDescription UTF8String]);
        index++;
        if (index == 3) {
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
