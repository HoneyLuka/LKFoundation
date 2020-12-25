//
//  LKFoundationDefines.h
//  LKFoundation
//
//  Created by Selina on 25/12/2020.
//

#import <Foundation/Foundation.h>

#pragma mark - Macros

#define LK_SAFE_BLOCK(BlockName, ...) ({ !BlockName ? nil : BlockName(__VA_ARGS__); })

#define LK_METHOD_DEPRECATED(desc) __attribute__((deprecated(desc)))

#pragma mark - Blocks

typedef void(^LKVoidBlock)(void);
typedef void(^LKNSDataBlock)(NSData *);
typedef void(^LKBOOLBlock)(BOOL);

#pragma mark - Methods

FOUNDATION_EXTERN void lk_sync_on_main_queue(LKVoidBlock block);
FOUNDATION_EXTERN void lk_async_on_main_queue(LKVoidBlock block);
FOUNDATION_EXTERN void lk_after(NSTimeInterval delay, LKVoidBlock block);

FOUNDATION_EXTERN void lk_async_on_background_queue(LKVoidBlock block);

typedef void(^LKDelayedBlockHandle)(BOOL cancel);
FOUNDATION_EXTERN LKDelayedBlockHandle lk_perform_block_after_delay(NSTimeInterval seconds, dispatch_block_t block);
FOUNDATION_EXTERN void lk_cancel_delayed_block(LKDelayedBlockHandle delayedHandle);
