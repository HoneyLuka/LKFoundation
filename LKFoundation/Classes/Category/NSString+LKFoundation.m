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

- (NSString *)lk_capitalizeFirstLetter
{
    if (!self.length) {
        return self;
    }
    
    NSString *firstChar = [[self substringToIndex:1] capitalizedString];
    return [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstChar];
}

@end
