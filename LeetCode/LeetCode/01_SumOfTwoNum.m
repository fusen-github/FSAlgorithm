//
//  01_SumOfTwoNum.m
//  LeetCode
//
//  Created by 付森 on 2021/7/11.
//

#import "01_SumOfTwoNum.h"

@implementation SumOfTwoNum

+ (NSArray *)twoSum:(NSArray *)nums target:(int)target
{
    NSArray *ans;
    
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < nums.count; i++) {
        
        int v1 = [nums[i] intValue];
        
        if ([map.allKeys containsObject:@(target - v1)]) {
            id anotherIndex = [map objectForKey:@(target - v1)];
            ans = @[@(i), anotherIndex];
            break;
        }
        [map setObject:@(i) forKey:nums[i]];
    }
    
    return ans;
}



@end
