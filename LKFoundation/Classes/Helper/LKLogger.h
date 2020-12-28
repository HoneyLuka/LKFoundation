//
//  LKLogger.h
//  LKFoundation
//
//  Created by Selina on 28/12/2020.
//

#import <Foundation/Foundation.h>

/**
 * LKLogger
 * No log will be print as default (except global channel), you can add -ReplaceWithChannelName launch argument to enable log.
 * Add -LKLoggerForceEnabled launch argument to force enable all logs.
 */

FOUNDATION_EXPORT void LKLogDebug(NSString *channel, NSString *code, NSString *msg, ...) NS_FORMAT_FUNCTION(3, 4);
FOUNDATION_EXPORT void LKLogInfo(NSString *channel, NSString *code, NSString *msg, ...) NS_FORMAT_FUNCTION(3, 4);
FOUNDATION_EXPORT void LKLogWarning(NSString *channel, NSString *code, NSString *msg, ...) NS_FORMAT_FUNCTION(3, 4);
FOUNDATION_EXPORT void LKLogError(NSString *channel, NSString *code, NSString *msg, ...) NS_FORMAT_FUNCTION(3, 4);

/// Use it like NSLog(), it will log in Global Channel with Debug level
FOUNDATION_EXPORT void LKLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

typedef NS_ENUM(NSUInteger, LKLogLevel) {
    LKLogLevelError = 1,
    LKLogLevelWarning,
    LKLogLevelInfo,
    LKLogLevelDebug,
};

FOUNDATION_EXPORT void LKLogBasic(NSString *channel,
                                  LKLogLevel level,
                                  NSString *code,
                                  NSString *msg,
// On 64-bit simulators, va_list is not a pointer, so cannot be marked nullable
// See: http://stackoverflow.com/q/29095469
#if __LP64__ && TARGET_OS_SIMULATOR || TARGET_OS_OSX
                                  va_list args_ptr
#else
                                  va_list _Nullable args_ptr
#endif
);
