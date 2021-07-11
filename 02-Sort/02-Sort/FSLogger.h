//
//  FSLogger.h
//  02-Sort
//
//  Created by 付森 on 2021/7/10.
//

#ifndef FSLogger_h
#define FSLogger_h

static inline void FSLogArray(int *arr, int len)
{
    if (arr == NULL || len <= 0) return;
    
    for (int i = 0; i < len; i++) {
        printf("%d, ", arr[i]);
    }
    printf("\n");
}

#endif /* FSLogger_h */
