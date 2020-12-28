//
//  LKFoundationTests.m
//  LKFoundationTests
//
//  Created by Luka on 12/24/2020.
//  Copyright (c) 2020 Luka. All rights reserved.
//

@import XCTest;
#import <LKFoundation/LKFoundation.h>

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDebugLogWithSingleArgs
{
    LKLog(@"test %@ LogWithSingleArgs", @"debug");
}

- (void)testDebugLogWithoutArgs
{
    LKLog(@"testDebugLogWithoutArgs");
}

- (void)testErrorLog
{
    LKLogError(@"TestChannel", @"350", @"error msg %@", @"ok");
}

@end

