//
//  LKLogger.m
//  LKFoundation
//
//  Created by Selina on 28/12/2020.
//

#import "LKLogger.h"

static NSArray *sEnabledChannels = nil;

NSString * const LKLoggerForceLogEnabledArgument = @"-LKLoggerForceEnabled";

NSString * const LKLoggerGlobalChannel = @"Global";

#define LK_LOGGING_FUNCTION(lv)                                                                     \
    void LKLog##lv(NSString *channel, NSString *code, NSString *msg, ...) {                         \
        va_list args_ptr;                                                                           \
        va_start(args_ptr, msg);                                                                    \
        LKLogBasic(channel, LKLogLevel##lv, code, msg, args_ptr);                                   \
        va_end(args_ptr);                                                                           \
    }

LK_LOGGING_FUNCTION(Error)
LK_LOGGING_FUNCTION(Warning)
LK_LOGGING_FUNCTION(Info)
LK_LOGGING_FUNCTION(Debug)

void LKLog(NSString *format, ...) {
    va_list args_ptr;
    va_start(args_ptr, format);
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:args_ptr];
    va_end(args_ptr);
    LKLogDebug(LKLoggerGlobalChannel, nil, @"%@", msg);
}

#pragma mark - Private

static inline NSString *stringForLevel(LKLogLevel level) {
    switch (level) {
        case LKLogLevelError:
            return @"Error";
        case LKLogLevelWarning:
            return @"Warning";
        case LKLogLevelInfo:
            return @"Info";
        case LKLogLevelDebug:
            return @"Debug";
        default:
            return @"Unknown";
    }
}

BOOL canLog(NSString *channel, LKLogLevel level) {
    if ([sEnabledChannels containsObject:LKLoggerForceLogEnabledArgument]) {
        return YES;
    }
    
#if DEBUG
    if ([channel isEqualToString:LKLoggerGlobalChannel]) {
        return YES;
    }
#endif
    
    if (!channel.length) {
        return NO;
    }
    
    NSString *channelArgs = [NSString stringWithFormat:@"-%@", channel];
    if ([sEnabledChannels containsObject:channelArgs]) {
        return YES;
    }
    
    return NO;
}

void LKLogInit(void) {
    sEnabledChannels = [NSProcessInfo processInfo].arguments;
}

void LKLogBasic(NSString *channel, LKLogLevel level, NSString *code, NSString *msg, va_list args_ptr) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LKLogInit();
    });
    
    if (!channel.length) {
        channel = LKLoggerGlobalChannel;
    }
    
    if (!canLog(channel, level)) {
        return;
    }
    
    NSMutableString *final = [@"[LKLogger]" mutableCopy];
    [final appendFormat:@"[%@]", channel];
    [final appendFormat:@"[%@]", stringForLevel(level)];
    
    if (code.length) {
        [final appendFormat:@"[code: %@]", code];
    }
    
    NSString *logMsg;
    if (args_ptr == NULL) {
      logMsg = msg;
    } else {
      logMsg = [[NSString alloc] initWithFormat:msg arguments:args_ptr];
    }
    
    if (logMsg.length) {
        [final appendFormat:@" - %@", logMsg];
    }
    
    NSLog(@"%@", final);
}
