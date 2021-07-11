//
//  03_MaxSubString.m
//  LeetCode
//
//  Created by 付森 on 2021/7/11.
//

#import "03_MaxSubString.h"

@implementation MaxSubString

// 暴力解  很耗时
+ (void)lengthOfLongestSubstring_1:(NSString *)string
{
    NSUInteger maxLen = 0;
    int startIndex = -1;
    
    for (int i = 0; i < string.length; i++) {
        
        for (int j = i + 1; j < string.length; j++) {
            
            NSString *sub = [string substringWithRange:NSMakeRange(i, j - i)];
            
            NSMutableSet *tmpSet = [NSMutableSet set];
            
            // 判断sub是否包含重复字符串，如果包含，就continue
            for (int k = 0; k < sub.length; k++) {
                char ch = [sub characterAtIndex:k];
                [tmpSet addObject:@(ch)];
            }
            
            // 有重复字符
            if (tmpSet.count < sub.length) {
                continue;
            }
            else {
                // 无重复字符, 记录maxLen、startIndex
                
                if (maxLen < sub.length) {
                    maxLen = sub.length;
                    startIndex = i;
                }
                
            }
        }
    }
}


+ (void)lengthOfLongestSubstring_2:(NSString *)string
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

/**
 推箱子
1、指定left、right边界确定一个箱子
2、left边界从0开始，right边界是循环因子i+1
3、在遍历过程中，当遇到了之前出现过的字符，则把left跳转到该字符上次出现位置的下一个位置
4、用HashMap不断记录当前字符出现的位置
5、当新子串的长度大于之前记录的最大长度（maxLen）时，则更新maxLen的值，并记录当前的left
 */
+ (void)lengthOfLongestSubstring_3:(NSString *)string
{
    // 索引指针
    int left = 0;
    // 最大长度
    int maxLen = 0;
    int maxLoction = 0;
    
    // key:char   value:index
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < string.length; i++) {
        
        char ch = [string characterAtIndex:i];
        
        if ([dict.allKeys containsObject:@(ch)]) {
            
            int lastIndex = [[dict objectForKey:@(ch)] intValue];
            
            if (lastIndex >= left) {
                left = lastIndex + 1;
            }
        }
        
        maxLen = MAX(maxLen, (i + 1 - left));
        
        int subLen = i + 1 - left;
        if (maxLen < subLen) {
            maxLen = subLen;
            maxLoction = left;
        }
        
        
    }
    
    // 至此，得到最长无重复字符串的子串，
    // maxLoction 目标子串的起始索引。maxLen 目标子串的长度
    
}

@end
