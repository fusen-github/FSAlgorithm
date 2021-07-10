//
//  BinaryTree.h
//  01-BinaryTree
//
//  Created by 付森 on 2021/7/10.
//

#import <Foundation/Foundation.h>
#import "FSComparable.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BTEnumeratorBlock)(id<FSComparable> item, BOOL *stop);

@interface BinaryTree : NSObject

- (void)insertItem:(id<FSComparable>)item;

/*
 二叉树遍历:
 1、前序遍历-先访问根结点、再访问左子树、最后访问右子树
 */

- (void)preorderEnumerate:(BTEnumeratorBlock)block;

@end

NS_ASSUME_NONNULL_END
