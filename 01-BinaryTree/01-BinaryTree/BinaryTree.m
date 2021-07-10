//
//  BinaryTree.m
//  01-BinaryTree
//
//  Created by 付森 on 2021/7/10.
//

#import "BinaryTree.h"

@interface BTNode : NSObject
{
@public
    id<FSComparable> value;
    BTNode *left;
    BTNode *right;
    BTNode *parent;
}

+ (instancetype)nodeByValue:(id<FSComparable>)value parent:(BTNode *)parent;

@end

@implementation BTNode

+ (instancetype)nodeByValue:(id<FSComparable>)value parent:(BTNode *)parent
{
    BTNode *node = [[BTNode alloc] init];
    node->value = value;
    node->parent = parent;
    return node;
}

@end

@interface BinaryTree ()
{
    BOOL isPreorderStop;
    BOOL isInorderStop;
}
// 前序遍历block
@property (nonatomic, copy) BTEnumeratorBlock preorderBlock;

// 中序遍历block
@property (nonatomic, copy) BTEnumeratorBlock inorderBlock;


@end

@implementation BinaryTree
{
    NSUInteger length;
    BTNode *root;
    
}


- (void)insertItem:(id<FSComparable>)item
{
    if (item == nil) {
        return;
    }
    
    if (root == nil) {
        root = [BTNode nodeByValue:item parent:nil];
        return;
    }
    
    BTNode *node = root;
    BTNode *needParent = nil;
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
    
    BTNode *newNode = [BTNode nodeByValue:item parent:needParent];
    
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



- (void)private_preorderEnumerate:(BTNode *)node
{
    if (node == nil) {
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

- (void)private_inorderEnumerate:(BTNode *)node
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

@end
