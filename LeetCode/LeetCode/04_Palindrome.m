//
//  04_Palindrome.m
//  LeetCode
//
//  Created by 付森 on 2021/7/11.
//

#import "04_Palindrome.h"

@implementation Palindrome

/**
 一、暴力解法
 1、两层for循环，获取一个字符串的所有子串
 2、再新函数中判断一个字符串是否是回文子串
 */
+ (void)longestPalindrome_1
{
    NSString *string = @"";
    
    // 最长回文子串的长度
    int maxLen = 1;
    // 最长回文子串的起始索引
    int beginIndex = 0;
    
    for (int i = 0; i < string.length - 1; i++) {
        
        for (int j = i + 1; j < string.length; j++) {
                        
            if (j - i + 1 <= maxLen) {
                continue;
            }
            
            int left = i;
            int right = j;
        
            while (left < right) {
                
                char charLeft = [string characterAtIndex:left];
                char charRight = [string characterAtIndex:right];
                
                if (charLeft != charRight) {
                    // 不是回文子串
                    break;
                } else {
                    left++;
                    right--;
                }
            }
            
            // 是回文
            if (left == right || left == right + 1) {
                beginIndex = i;
                maxLen = j - i + 1;
            }
        }
    }
    
    NSRange range = NSMakeRange(beginIndex, maxLen);
    NSString *sub = [string substringWithRange:range];
    
    /*
     3次循环
     时间复杂度: O(n三次方)
     空间复杂度: O(n)
     */
}

/**
 中心扩散法
 奇数子串：传入中心点一个索引，向两边扩散
 偶数子串：传入中心的两个树荫，向两边扩散
 */
+ (void)longestPalindrome_2:(NSString *)string
{
    int maxLen = 1;
    int begin = 0;
    
    for (int i = 1; i < string.length - 1; i++) {
        
        int len1 = [self centerExpand:string left:i right:i];
        int len2 = [self centerExpand:string left:i right:i+1];
        
        int tmpMax = MAX(len1, len2);
        
        if (maxLen < tmpMax) {
            maxLen = tmpMax;
            begin = i - (maxLen - 1) / 2;
        }
    }
    
    NSRange range = NSMakeRange(begin, maxLen);
    NSString *sub = [string substringWithRange:range];
    
    
    /**
     时间复杂度：O(n平方)
     */
}

/**
 中心扩散
 
 */
+ (int)centerExpand:(NSString *)string left:(int)left right:(int)right
{
    while (left >=0 && right < string.length) {
        
        char chLeft = [string characterAtIndex:left];
        char chRight = [string characterAtIndex:right];
        
        if (chLeft != chRight) {
            break;
        }
        else {
            left--;
            right++;
        }
    }
    
    // 得到回文子串的长度
    int len = right - left + 1 - 2;
    
    return len;
}


@end
