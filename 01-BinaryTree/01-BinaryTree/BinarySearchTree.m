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

@interface BSTIterator ()

@property (nonatomic, copy) BSTEnumeratorBlock block;

@property (nonatomic, assign) BOOL isStop;

@end

@implementation BSTIterator

+ (instancetype)iteratorEnumerator:(BSTEnumeratorBlock)block
{
    BSTIterator *it = [[BSTIterator alloc] init];
    it.isStop = NO;
    it.block = block;
    return it;
}

- (void)preorderIterate:(BSTNode *)node
{
    if (node == nil || _isStop) {
        return;
    }
    
    if (self.block) {
        self.block(node->value, &_isStop);
    }
    
    if (_isStop) {
        return;
    }
    
    [self preorderIterate:node->left];
    if (_isStop) {
        return;
    }
    [self preorderIterate:node->right];
}

- (void)dealloc
{
    NSLog(@"Iterator dealloc");
}

@end

@interface BinarySearchTree ()
{
    BOOL isPreorderStop;
    BOOL isInorderStop;
    BOOL isPostorderStop;
}
// 前序遍历block
@property (nonatomic, copy) BSTEnumeratorBlock preorderBlock;

// 中序遍历block
@property (nonatomic, copy) BSTEnumeratorBlock inorderBlock;

// 后序遍历block
@property (nonatomic, copy) BSTEnumeratorBlock postorderBlock;

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

- (void)preorderEnumerate:(BSTEnumeratorBlock)block
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


- (void)preorderIterate:(BSTIterator *)iterator
{
    [iterator preorderIterate:root];
}


- (void)inorderEnumerate:(BSTEnumeratorBlock)block
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

- (void)postorderEnumerate:(BSTEnumeratorBlock)block
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



- (void)levelOrderEnumerate:(BSTEnumeratorBlock)block
{
    if (root == nil) {
        return;
    }
    
    BOOL isLevelStop = NO;
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:root];
    
    while (array.count > 0) {
        
        // 1.出队
        BSTNode *lastNode = [array lastObject];
        [array removeLastObject];
        
        if (block) {
            block(lastNode->value, &isLevelStop);
        }
        
        if (isLevelStop) {
            return;
        }
        
        // 2.把左右结点分别入队
        if (lastNode->left) {
            [array insertObject:lastNode->left atIndex:0];
        }
        
        if (lastNode->right) {
            [array insertObject:lastNode->right atIndex:0];
        }
    }
}

@end
