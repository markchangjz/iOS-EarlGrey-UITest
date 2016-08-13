//
//  MyFirstEarlGreyTest.swift
//  Notification
//
//  Created by MarkChang on 2016/8/13.
//  Copyright © 2016年 MarkChang. All rights reserved.
//

import XCTest

class SwiftEarlGreyTest: XCTestCase {

	var downloadCompleted = false

    override func setUp() {
        super.setUp()

		downloadCompleted = false
    }
    
    override func tearDown() {
        super.tearDown()
    }

	func downloadFinished(notification: NSNotification) {
		downloadCompleted = true
	}

	func testDownload() {
		EarlGrey().selectElementWithMatcher(grey_buttonTitle("Download")).performAction(grey_tap())

		EarlGrey().selectElementWithMatcher(grey_accessibilityID("download indicator")).assertWithMatcher(grey_notVisible())

		print("DONE!")
	}

    func testDownload_GrabNotification() {
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.downloadFinished(_:)), name:"finished", object: nil)

		EarlGrey().selectElementWithMatcher(grey_buttonTitle("Download")).performAction(grey_tap())

		while !downloadCompleted && NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture()) {
		}

		print("DONE!")
    }
}
