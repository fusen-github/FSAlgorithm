//
//  05_CharPair.m
//  LeetCode
//
//  Created by 付森 on 2021/7/11.
//

#import "05_CharPair.h"

@implementation CharPair

+ (void)pairIsValid
{
    NSDictionary *dict = @{
        @")":@"(",
        @"]":@"[",
        @"}":@"{",
    };
    
    NSString *string = @"";
    
    NSMutableArray *stack = [NSMutableArray array];
    
    BOOL flag = true;
    
    for (int i = 0; i < string.length; i++) {
        
        NSString *ch = [string substringWithRange:NSMakeRange(i, 1)];
        
        if ([dict.allKeys containsObject:ch]) {
            
            NSString *value = [dict objectForKey:ch];
            
            if (!stack.count || ![stack.lastObject isEqualTo:value]) {
                flag = false;
                break;
            } else {
                [stack removeLastObject];
            }
        }
        else {
            [stack addObject:ch];
        }
    }
    
    flag = stack.count == 0;
    
    
}

@end
