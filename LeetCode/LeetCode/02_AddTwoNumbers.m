//
//  02_AddTwoNumbers.m
//  LeetCode
//
//  Created by 付森 on 2021/7/11.
//

#import "02_AddTwoNumbers.h"

/**
 结点对象
 */
@interface Node02 : NSObject
{
@public
    int value;
    Node02 *next;
}

@end
@implementation Node02

+ (instancetype)nodeByValue:(int)value
{
    Node02 *node = [[Node02 alloc] init];
    
    node->value = value;
    return node;
}

@end

/**
 链表对象
 */
@interface LinkList02 : NSObject
{
@public
    Node02 *header;
}


@end

@implementation LinkList02

- (void)append:(int)num
{
    Node02 *node = [Node02 nodeByValue:num];
    
    if (header == nil) {
        header = node;
        return;
    }
    
    Node02 *parent = header;
    
    while (parent->next) {
        parent = parent->next;
    }
    
    parent->next = node;
}

@end



@implementation AddTwoNumbers

+ (void)method1
{
    // 倒序的链表
    LinkList02 *ll1 = [[LinkList02 alloc] init];
    
    LinkList02 *ll2 = [[LinkList02 alloc] init];
    
    Node02 *node1 = ll1->header;
    Node02 *node2 = ll2->header;
    
    Node02 *ansHeader = nil;
    Node02 *ansFooter = nil;
    
    // 是否进位标识，因为是个位数相加，进位值最大是1, 最小是0
    int flag = 0;
    
    while (node1 || node2) {
        
        int v1 = node1 ? node1->value : 0;
        int v2 = node2 ? node2->value : 0;
        
        int sum = v1 + v2;
        
        if (ansHeader == nil) {
            ansHeader = [[Node02 alloc] init];
            ansHeader->value = sum % 10;
            ansFooter = ansHeader;
        }
        else
        {
            sum = sum + flag;
            Node02 *next = [[Node02 alloc] init];
            next->value = sum % 10;
            ansFooter->next = next;
            ansFooter = next;
        }
        
        flag = sum / 10;
        
        if (node1) {
            node1 = node1->next;
        }
        if (node2) {
            node2 = node2->next;
        }
        
    }
    
    if (flag > 0) {
        
        Node02 *next = [[Node02 alloc] init];
        next->value = flag;
        ansFooter->next = next;
    }
}

@end
