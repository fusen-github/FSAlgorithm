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

@interface BinarySearchTree : NSObject

- (void)insertItem:(id<FSComparable>)item;

/*
 二叉树遍历
 */

/**
 前序遍历：就是把根结点放在前面先遍历
 先访问根结点、再访问左子树、最后访问右子树
 */
- (void)preorderEnumerate:(BTEnumeratorBlock)block;

/**
 中序遍历：把根结点放在中间遍历
 先访问左子树、再访问根结点、最后遍历右子树
 */
- (void)inorderEnumerate:(BTEnumeratorBlock)block;

/**
 后序变历：把根结点放在最后
 先访问左子树、再访问右子树、最后访问根结点
 */
- (void)postorderEnumerate:(BTEnumeratorBlock)block;

@end

NS_ASSUME_NONNULL_END
