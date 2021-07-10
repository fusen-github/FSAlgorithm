//
//  BinarySearchTree.m
//  01-BinaryTree
//
//  Created by 付森 on 2021/7/10.
//

#import "BinarySearchTree.h"

@interface BSTNode : NSObject
{
@public
    id<FSComparable> value;
    BSTNode *left;
    BSTNode *right;
    BSTNode *parent;
}

+ (instancetype)nodeByValue:(id<FSComparable>)value parent:(BSTNode *)parent;

@end

@implementation BSTNode

+ (instancetype)nodeByValue:(id<FSComparable>)value parent:(BSTNode *)parent
{
    BSTNode *node = [[BSTNode alloc] init];
    node->value = value;
    node->parent = parent;
    return node;
}

@end

@interface BinarySearchTree ()
{
    BOOL isPreorderStop;
    BOOL isInorderStop;
    BOOL isPostorderStop;
}
// 前序遍历block
@property (nonatomic, copy) BTEnumeratorBlock preorderBlock;

// 中序遍历block
@property (nonatomic, copy) BTEnumeratorBlock inorderBlock;

// 后序遍历block
@property (nonatomic, copy) BTEnumeratorBlock postorderBlock;


@end

@implementation BinarySearchTree
{
    NSUInteger length;
    BSTNode *root;
    
}


- (void)insertItem:(id<FSComparable>)item
{
    if (item == nil) {
        return;
    }
    
    if (root == nil) {
        root = [BSTNode nodeByValue:item parent:nil];
        return;
    }
    
    BSTNode *node = root;
    BSTNode *needParent = nil;
    BOOL isLeft = NO;
    while (node) {
        
        needParent = node;
        NSComparisonResult cmpResult = [item doCompare:node->value];
        if (cmpResult == NSOrderedAscending) {
            node = node->left;
            isLeft = YES;
        }else {
            node = node->right;
            isLeft = NO;
        }
    }
    
    BSTNode *newNode = [BSTNode nodeByValue:item parent:needParent];
    
    if (isLeft) {
        needParent->left = newNode;
    } else {
        needParent->right = newNode;
    }
}

- (void)preorderEnumerate:(BTEnumeratorBlock)block
{
    isPreorderStop = false;
    self.preorderBlock = block;
    [self private_preorderEnumerate:root];
}



- (void)private_preorderEnumerate:(BSTNode *)node
{
    if (node == nil || isPreorderStop) {
        return;
    }
    
    if (self.preorderBlock) {
        self.preorderBlock(node->value, &isPreorderStop);
    }
    
    if (isPreorderStop) {
        return;
    }
    
    [self private_preorderEnumerate:node->left];
    if (isPreorderStop) {
        return;
    }
    [self private_preorderEnumerate:node->right];
}

- (void)inorderEnumerate:(BTEnumeratorBlock)block
{
    self.inorderBlock = block;
    self->isInorderStop = false;
    [self private_inorderEnumerate:root];
}

- (void)private_inorderEnumerate:(BSTNode *)node
{
    if (node == nil || isInorderStop) {
        return;
    }
    // 先访问左子树
    [self private_inorderEnumerate:node->left];
    
    if (isInorderStop) {
        return;
    }
    if (self.inorderBlock) {
        self.inorderBlock(node->value, &isInorderStop);
    }
    if (isInorderStop) {
        return;
    }
    [self private_inorderEnumerate:node->right];
}

- (void)postorderEnumerate:(BTEnumeratorBlock)block
{
    self->isPostorderStop = false;
    self.postorderBlock = block;
    [self private_postorderEnumerate:root];
}

- (void)private_postorderEnumerate:(BSTNode *)node
{
    if (node == nil || isPostorderStop) {
        return;
    }
    
    [self private_postorderEnumerate:node->left];
    
    if (isPostorderStop) {
        return;
    }
    [self private_postorderEnumerate:node->right];
    
    if (isPostorderStop) {
        return;
    }
    if (self.postorderBlock) {
        self.postorderBlock(node->value, &isPostorderStop);
    }
}

@end
