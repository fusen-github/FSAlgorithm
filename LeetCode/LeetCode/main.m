//
//  main.m
//  LeetCode
//
//  Created by 付森 on 2021/7/11.
//

#import <Foundation/Foundation.h>
#import "06_ReverseWord.h"


static void test06()
{
    // Alice does not even like bob
    NSString *aString = @"Alice does not even like bob";
    NSString *ans = [ReverseWord reverseString_cpp:aString];
    NSLog(@"%@", ans);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
        
        test06();
        
    }
    return 0;
}
