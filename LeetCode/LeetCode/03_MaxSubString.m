//
//  03_MaxSubString.m
//  LeetCode
//
//  Created by 付森 on 2021/7/11.
//

#import "03_MaxSubString.h"

@implementation MaxSubString

+ (void)lengthOfLongestSubstring:(NSString *)string
{
    // 起始索引
    int left = -1;
    // 最大长度
    int maxLen = 0;
    
    // 队列, key:字符 value: 起始索引
    NSMutableDictionary *queue = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < string.length; i++) {
        
        // 单个字符
        NSString *ch = [string substringWithRange:NSMakeRange(i, 1)];
        
        if ([queue.allKeys containsObject:ch]) {
            int lastIndex = [[queue objectForKey:ch] intValue];
            left = MAX(lastIndex, left);
        }
        
        maxLen = MAX(maxLen, i - left);
        
        [queue setValue:@(i) forKey:ch];
    }
}

@end
