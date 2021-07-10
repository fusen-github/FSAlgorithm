//
//  BinaryTree.h
//  01-BinaryTree
//
//  Created by 付森 on 2021/7/10.
//

#import <Foundation/Foundation.h>
#import "FSComparable.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BSTEnumeratorBlock)(id<FSComparable> item, BOOL *stop);

@interface BSTIterator : NSObject

+ (instancetype)iteratorEnumerator:(BSTEnumeratorBlock)block;

@end

@interface BinarySearchTree : NSObject

- (void)insertItem:(id<FSComparable>)item;

/*
 二叉树遍历
 */

/**
 前序遍历：就是把根结点放在前面先遍历
 先访问根结点、再访问左子树、最后访问右子树
 */
- (void)preorderEnumerate:(BSTEnumeratorBlock)block;

/** 前序迭代*/
- (void)preorderIterate:(BSTIterator *)iterator;

/**
 中序遍历：把根结点放在中间遍历
 先访问左子树、再访问根结点、最后遍历右子树
 */
- (void)inorderEnumerate:(BSTEnumeratorBlock)block;

/**
 后序变历：把根结点放在最后
 先访问左子树、再访问右子树、最后访问根结点
 */
- (void)postorderEnumerate:(BSTEnumeratorBlock)block;

/**
 层序遍历：按照二叉树的层级顺序，从上向下、从左向右依次遍历
 原理:
 1、准备一个队列，先将rootNode入队
 2、利用while循环 将队头出队
 3、在队头出队后，将队头的左、右子结点分别入队
 4、当队列是空时 循环结束
 */
- (void)levelOrderEnumerate:(BSTEnumeratorBlock)block;

/**
 获取二叉树的高度
 */
- (NSUInteger)treeHeight;

/**
 判断是否是完全二叉树
 */
- (BOOL)isComplectTree;

/**
 翻转二叉树
 */
- (void)reverse;

@end

NS_ASSUME_NONNULL_END
