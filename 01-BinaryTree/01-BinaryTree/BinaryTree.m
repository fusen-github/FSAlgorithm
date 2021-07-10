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

@property (nonatomic, copy) BTEnumeratorBlock preorderBlock;


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
    self.preorderBlock = block;
    [self private_preorderEnumerate:root];
}

- (void)private_preorderEnumerate:(BTNode *)node
{
    if (node == nil) {
        return;
    }
    
    BOOL isStop = false;
    
    if (self.preorderBlock) {
        self.preorderBlock(node->value, &isStop);
    }
    
    if (isStop) {
        return;
    }
    [self private_preorderEnumerate:node->left];
    [self private_preorderEnumerate:node->right];
}

@end
