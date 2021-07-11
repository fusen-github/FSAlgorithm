//
//  02-SelectSort.h
//  02-Sort
//
//  Created by 付森 on 2021/7/11.
//

#ifndef _2_SelectSort_h
#define _2_SelectSort_h

static void selectSort_1()
{
    int arr[15];
    int len = sizeof(arr) / sizeof(int);

    // 构造数据
    for (int i = 0; i < len; i++) {
        int value = arc4random_uniform(500);
        arr[i] = value;
    }
    
    NSLog(@"排序前:");
    FSLogArray(arr, len);
    
    for (int i = 0; i < len - 1; i++) {
        int maxIndex = 0;
        int lastIndex = 0;
        for (int j = 1; j < len - i; j++) {
            lastIndex = j;
            if (arr[maxIndex] < arr[j]) {
                maxIndex = j;
            }
        }
        int tmp = arr[lastIndex];
        arr[lastIndex] = arr[maxIndex];
        arr[maxIndex] = tmp;
    }
    
    NSLog(@"排序后:");
    FSLogArray(arr, len);
}



#endif /* _2_SelectSort_h */
