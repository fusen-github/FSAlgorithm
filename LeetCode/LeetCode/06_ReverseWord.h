//
//  06_ReverseWord.h
//  LeetCode
//
//  Created by 付森 on 2021/7/16.
//

/*
 151. 翻转字符串里的单词
 https://leetcode-cn.com/problems/reverse-words-in-a-string/
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 翻转字符串里的单词
@interface ReverseWord : NSObject

+ (NSString *)reverseSring:(NSString *)string;

+ (NSString *)reverseString_cpp:(NSString *)string;

+ (NSString *)reverseString_cpp_01:(NSString *)string;

+ (NSString *)reverseString_oc:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
