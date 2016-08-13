//
//  MyFirstEarlGreyTest.m
//  Notification
//
//  Created by MarkChang on 2016/8/13.
//  Copyright © 2016年 MarkChang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EarlGrey/EarlGrey.h>

@interface ObjCEarlGreyTest : XCTestCase

@end

@implementation ObjCEarlGreyTest

bool downloadComplete = NO;

- (void)setUp {
    [super setUp];

	downloadComplete = NO;
}

- (void)tearDown {
    [super tearDown];
}

- (void)downloadFinished: (NSNotification *) notification {
	downloadComplete = YES;
}

- (void)testDownloadFinish {
	[[EarlGrey selectElementWithMatcher:grey_buttonTitle(@"Download")] performAction:grey_tap()];

	[[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"download indicator")] assertWithMatcher:grey_notVisible()];

	NSLog(@"DONE");
}

- (void)testDownloadFinishByGrabNotification {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished:) name:@"finished" object:nil];

	[[EarlGrey selectElementWithMatcher:grey_buttonTitle(@"Download")] performAction:grey_tap()];

	while (!downloadComplete && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);

	NSLog(@"DONE!");
}

@end
