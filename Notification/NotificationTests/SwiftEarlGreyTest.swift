//
//  MyFirstEarlGreyTest.swift
//  Notification
//
//  Created by MarkChang on 2016/8/13.
//  Copyright © 2016年 MarkChang. All rights reserved.
//

import XCTest

class SwiftEarlGreyTest: XCTestCase {

	var downloadComplete = false

    override func setUp() {
        super.setUp()

		downloadComplete = false
    }
    
    override func tearDown() {
        super.tearDown()
    }

	func downloadFinished(notification: NSNotification) {
		downloadComplete = true
	}

	func testDownloadFinish() {
		EarlGrey().selectElementWithMatcher(grey_buttonTitle("Download")).performAction(grey_tap())

		EarlGrey().selectElementWithMatcher(grey_accessibilityID("download indicator")).assertWithMatcher(grey_notVisible())

		print("DONE!")
	}

    func testDownloadFinishByGrabNotification() {
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.downloadFinished(_:)), name:"finished", object: nil)

		EarlGrey().selectElementWithMatcher(grey_buttonTitle("Download")).performAction(grey_tap())

		while !downloadComplete && NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture()) {
		}

		print("DONE!")
    }
}
