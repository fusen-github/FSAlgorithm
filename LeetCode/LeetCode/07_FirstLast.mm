//
//  07_FirstLast.m
//  LeetCode
//
//  Created by 付森 on 2021/7/16.
//

#import "07_FirstLast.h"
#include <vector>

@implementation FirstLast

// vector<int>& nums

// 返回下标

static int findRange(std::vector<int> nums, int target, bool isLeft){
    
    int left = 0;
    int right = (int)nums.size() - 1;
    int ans = -1;
    
    while (left < right) {
        
    }
    
    return -1;
}

+ (void)findFirtLastMain
{
    std::vector<int> nums;
    int target;
    
    int leftIndex = findRange(nums, target, true);
    int rightIndex = findRange(nums, target, false);
    
    
    
}


@end
