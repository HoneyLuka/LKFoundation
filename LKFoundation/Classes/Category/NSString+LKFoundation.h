//
//  NSString+LKFoundation.h
//  LKFoundation
//
//  Created by Selina on 25/12/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LKFoundation)

- (nullable NSString *)lk_md5String;
- (nullable NSString *)lk_capitalizeFirstLetter;

@end

NS_ASSUME_NONNULL_END
