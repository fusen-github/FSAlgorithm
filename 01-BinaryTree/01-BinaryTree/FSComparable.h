//
//  FSComparable.h
//  01-BinaryTree
//
//  Created by 付森 on 2021/7/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol FSComparable <NSObject>

- (NSComparisonResult)doCompare:(id<FSComparable>)obj;

@end

NS_ASSUME_NONNULL_END
