//
//  NSString+LKFoundation.m
//  LKFoundation
//
//  Created by Selina on 25/12/2020.
//

#import "NSString+LKFoundation.h"
#import "NSData+LKFoundation.h"

@implementation NSString (LKFoundation)

- (NSString *)lk_md5String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lk_md5String];
}

@end
