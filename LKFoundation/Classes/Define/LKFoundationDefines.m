//
//  LKFoundationDefines.m
//  LKFoundation
//
//  Created by Selina on 25/12/2020.
//

#import "LKFoundationDefines.h"
#import <pthread/pthread.h>

void lk_sync_on_main_queue(LKVoidBlock block) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void lk_async_on_main_queue(LKVoidBlock block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

void lk_after(NSTimeInterval delay, LKVoidBlock block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

void lk_async_on_background_queue(LKVoidBlock block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

LKDelayedBlockHandle lk_perform_block_after_delay(NSTimeInterval seconds, dispatch_block_t block) {
    
    if (nil == block) {
        return nil;
    }
    
    // block is likely a literal defined on the stack, even though we are using __block to allow us to modify the variable
    // we still need to move the block to the heap with a copy
    __block dispatch_block_t blockToExecute = [block copy];
    __block LKDelayedBlockHandle delayHandleCopy = nil;
    
    LKDelayedBlockHandle delayHandle = ^(BOOL cancel){
        if (NO == cancel && nil != blockToExecute) {
            dispatch_async(dispatch_get_main_queue(), blockToExecute);
        }
        
        // Once the handle block is executed, canceled or not, we free blockToExecute and the handle.
        // Doing this here means that if the block is canceled, we aren't holding onto retained objects for any longer than necessary.
#if !__has_feature(objc_arc)
        [blockToExecute release];
#endif
        blockToExecute = nil;
        
#if !__has_feature(objc_arc)
        [delayHandleCopy release];
#endif
        delayHandleCopy = nil;
    };
        
    // delayHandle also needs to be moved to the heap.
    delayHandleCopy = [delayHandle copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (nil != delayHandleCopy) {
            delayHandleCopy(NO);
        }
    });

    return delayHandleCopy;
};

void lk_cancel_delayed_block(LKDelayedBlockHandle delayedHandle) {
    if (nil == delayedHandle) {
        return;
    }
    
    delayedHandle(YES);
}
