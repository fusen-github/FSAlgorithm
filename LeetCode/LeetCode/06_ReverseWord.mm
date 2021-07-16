//
//  06_ReverseWord.m
//  LeetCode
//
//  Created by 付森 on 2021/7/16.
//

#import "06_ReverseWord.h"
#include <string>
#include <iostream>

using namespace std;

@implementation ReverseWord

// string = @"  are you  ok  " --> ""
+ (NSString *)reverseSring:(NSString *)string
{
    if (string.length == 0) {
        return nil;
    }
    
//    const char *charArray = [string UTF8String];
//    char ansChars[string.length];
    
    // 去掉多余空格后的字符串
//    NSMutableString *unspaceString = [NSMutableString string];
    
    // 保存去掉多余空格后的字符数组
    char tmpChars[string.length];
    for (int i = 0; i < string.length; i++) {
        tmpChars[i] = '\0';
    }
    // 新字符串的长度
    int newLen = 0;
    // 这个for循环结束后tmpChars里是去除多余空格的字符串，且charsIndex就是字符串的长度
    for (int i = 0; i < string.length; i++) {
        char ch = [string characterAtIndex:i];
        
        if (newLen == 0) {
            if (ch == ' ') {
                continue;
            }else {
                tmpChars[newLen++] = ch;
            }
        }
        else {
            if (ch == ' ') {
                // 取出当前tmpChars的最后一个字符
                char last = tmpChars[newLen - 1];
                
                // 判断最后一个字符是否是空格
                if (last != ' ') {
                    tmpChars[newLen++] = ch;
                }
                
            }else {
                tmpChars[newLen++] = ch;
            }
        }
    }
    
    // tmpChars的 newLen-1位可能是空格
    if (tmpChars[newLen - 1] == ' ') {
        newLen--;
    }
    
    NSString *midString = [NSString stringWithCString:tmpChars encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", midString);
    
    /*
     "are you ok"
     "ok you are"
     */
    
    int ansLen = 0;
    char ansString[newLen];
    
    // 无多余空格的字符串
    int right = newLen;
    for (int i = newLen - 1; i >= 0; i--) {
        char ch = tmpChars[i];
        if (ch == ' ' || i == 0) {
            
            if (i == 0) {
                i--;
            }
            
            if (ansLen > 0) {
                // 当ansLen大于0时，再拼接子字符串前需要先追加空格
                ansString[ansLen++] = ' ';
            }
            // 把(i, right]的子数组添加到新数组里
            for (int j = i + 1; j < right; j++) {
                ansString[ansLen++] = tmpChars[j];
            }
            right = i;
        }
    }
    
//    std::string result(ansString);
    
    NSString *result = [NSString stringWithUTF8String:ansString];
    
    return result;
}

// 有效
+ (NSString *)reverseString_cpp:(NSString *)string
{
    std::string str([string UTF8String]);
    
    // 去掉多余空格后的字符数组
    char trimChars[str.length()];
    
    // 新字符串的长度
    int trimLen = 0;
    
    for (int i = 0; i < str.length(); i++) {
        char ch = str.at(i);
        
        if (ch == ' ') {
            
            if (trimLen == 0) {
                continue;
            }
            // 取出当前tmpChars的最后一个字符
            char last = trimChars[trimLen - 1];
            // 判断最后一个字符是否是空格
            if (last != ' ') {
                trimChars[trimLen++] = ch;
            }
            
        }else {
            trimChars[trimLen++] = ch;
        }
    }
    
    // trimChars的newLen-1位可能是空格
    if (trimChars[trimLen - 1] == ' ') {
        trimLen--;
    }
    
    int ansLen = 0;
    char ansString[trimLen + 1];
    
    // 无多余空格的字符串
    int right = trimLen;
    for (int i = trimLen - 1; i >= 0; i--) {
        char ch = trimChars[i];
        if (ch == ' ' || i == 0) {
            
            if (i == 0) {
                i--;
            }
            
            if (ansLen > 0) {
                // 当ansLen大于0时，再拼接子字符串前需要先追加空格
                ansString[ansLen++] = ' ';
            }
            // 把(i, right]的子数组添加到新数组里
            for (int j = i + 1; j < right; j++) {
                ansString[ansLen++] = trimChars[j];
            }
            right = i;
        }
    }
    
    ansString[trimLen] = '\0';
    
    std::string ans(ansString);
    
    std::cout << "newString= \"" << ansString << "\"" << std::endl;
    
    NSString *ocString = [NSString stringWithCString:ansString encoding:NSUTF8StringEncoding];
    NSLog(@"oc-string='%@'", ocString);
    
    return ocString;
}

/**
 根据左右索引，翻转字符串
 */
void reverseStringBetweenLeftAndRight(std::string &string, int left, int right)
{
    while (left < right) {
        char ch = string[left];
        string[left] = string[right];
        string[right] = ch;
        left++;
        right--;
    }
}

+ (NSString *)reverseString_cpp_01:(NSString *)string
{
    std::string str([string UTF8String]);
    // 1.去除str字符串中多余的空格
    char trimChats[string.length + 1];
    int trimLen = 0;
    for (int i = 0; i < str.length(); i++) {
        char ch = str.at(i);
        if (ch == ' ') {
            if (trimLen == 0) {
                continue;
            }
            char last = trimChats[trimLen - 1];
            if (last != ' ') {
                trimChats[trimLen++] = ch;
            }
        }
        else {
            trimChats[trimLen++] = ch;
        }
    }
    
    if (trimChats[trimLen - 1] == ' ') {
        trimLen--;
    }
    
    // 去除多余空格后的std::string
    std::string trimString(trimChats, trimLen);
    std::cout << ">>" << trimString << "<<" << std::endl;
    
    // 2. 翻转trimString整个字符串
    reverseStringBetweenLeftAndRight(trimString, 0, trimLen-1);
    
    std::cout << ">>" << trimString << "<<" << std::endl;
    
    // 3. 再次翻转trimString中的每个单词
    int left = 0;
    for (int i = 0; i < trimLen + 1; i++) {
        if (i == trimLen || trimString.at(i) == ' ') {
            reverseStringBetweenLeftAndRight(trimString, left, i-1);
            std::cout << ">>" << trimString << "<<" << std::endl;
            left = i + 1;
        }
    }
    
    std::cout << ">>" << trimString << "<<" << std::endl;
    
    return @"";
}



+ (NSString *)reverseString_oc:(NSString *)string
{
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    
    NSString *tmpString = [string stringByTrimmingCharactersInSet:set];
    
    NSArray *tmpArray = [tmpString componentsSeparatedByCharactersInSet:set];
    
    return @"";
}

@end
