//
//  NSDate+LKUtils.m
//  LKFoundation
//
//  Created by Selina on 25/12/2020.
//

#import "NSDate+LKFoundation.h"

@implementation NSDate (LKFoundation)

+ (NSTimeInterval)lk_ts_ms
{
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

+ (NSTimeInterval)lk_ts_s
{
    return [[NSDate date] timeIntervalSince1970];
}

@end
