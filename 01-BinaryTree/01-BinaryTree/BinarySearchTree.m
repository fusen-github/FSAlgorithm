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

/**
 是否是叶子结点
 */
- (BOOL)isLeafNode;

// 是否是满结点
- (BOOL)isFullNode;

@end

@implementation BSTNode

+ (instancetype)nodeByValue:(id<FSComparable>)value parent:(BSTNode *)parent
{
    BSTNode *node = [[BSTNode alloc] init];
    node->value = value;
    node->parent = parent;
    return node;
}

- (BOOL)isLeafNode
{
    return self->left == nil && self->right == nil;
}

- (BOOL)isFullNode
{
    return self->left != nil && self->right != nil;
}

- (BOOL)isSingleLeft
{
    return self->left != nil && self->right == nil;
}

- (BOOL)isSingleRight
{
    return self->left == nil && self->right != nil;
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

- (NSUInteger)treeHeight
{
    if (root == nil) {
        return 0;
    }
    // 树的高度
    NSUInteger height = 0;
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:root];
    
    // 记录每一层的结点数
    NSUInteger levelCount = array.count;
    
    while (array.count > 0) {
        
        // 1.取出队列的队头结点
        BSTNode *lastNode = array.lastObject;
        [array removeLastObject];
        
        // 2.该层减少一个
        levelCount--;
        
        // 3. 添加叶子结点到队尾
        if (lastNode->left) {
            [array insertObject:lastNode->left atIndex:0];
        }
        
        if (lastNode->right) {
            [array insertObject:lastNode->right atIndex:0];
        }
        
        // 4.当某层数量==0时，array中的元素就是下一层的所有元素
        if (levelCount == 0) {
            levelCount = array.count;
            height++;
        }
    }
    
    return height;
}

- (BOOL)isComplectTree
{
    if (root == nil) {
        return NO;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:root];
    
    BOOL leafFlag = NO;
    
    while (array.count) {
        
        BSTNode *node = array.lastObject;
        [array removeLastObject];
        
        // 
        if (leafFlag && ![node isLeafNode]) {
            return NO;
        }
        
        // 可以确定不是完全二叉树
        if (node->left == nil && node->right) {
            return NO;
        }
        else if ([node isLeafNode] || [node isSingleLeft])
        {
            leafFlag = YES;
        }
        
        if (node->left) {
            [array insertObject:node->left atIndex:0];
        }
        
        if (node->right) {
            [array insertObject:node->right atIndex:0];
        }
        
    }
    
    return true;
}

@end
