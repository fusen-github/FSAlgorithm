//
//  01-BubbleSort.h
//  02-Sort
//
//  Created by 付森 on 2021/7/10.
//

#ifndef _1_BubbleSort_h
#define _1_BubbleSort_h

static void bubbleSort_01()
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
        for (int j = 0; j < len - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int tmp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = tmp;
            }
        }
    }
    
    NSLog(@"排序后:");
    FSLogArray(arr, len);
    
}

static void bubbleSort_02()
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
        
        // 如果经历x轮后数组已经有序，则退出循环
        BOOL isSorted = YES;
        
        for (int j = 0; j < len - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int tmp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = tmp;
                isSorted = NO;
            }
        }
        
        if (isSorted) {
            break;
        }
    }
    
    NSLog(@"排序后:");
    FSLogArray(arr, len);
    
}

static void bubbleSort_03()
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
    
    // 外循环保证循环多少轮
    for (int end = len - 1; end > 0; end--) {
        
        int lastSortIndex = 0;
        for (int begin = 1; begin <= end; begin++) {
            
            if (arr[begin] < arr[begin - 1]) {
                
                int tmp = arr[begin];
                arr[begin] = arr[begin - 1];
                arr[begin - 1] = tmp;
                lastSortIndex = begin;
            }
        }
        end = lastSortIndex;
    }
    
    NSLog(@"排序后:");
    FSLogArray(arr, len);
}

static void bubbleSort_04()
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
        
    // 外循环保证循环多少轮
    for (int i = 0; i < len - 1; i++) {
        
        int lastExchangeIndex = 0;
        // 内循环负责交换
        for (int j = 0; j < len - 1 - i; j++) {
            
            if (arr[j] > arr[j+1]) {
                int tmp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = tmp;
                lastExchangeIndex = j + 1;
            }
        }
        i = len - 1 - lastExchangeIndex;
    }
    
    NSLog(@"排序后:");
    FSLogArray(arr, len);
}

#endif /* _1_BubbleSort_h */
