//
//  NotificationUITests.swift
//  NotificationUITests
//
//  Created by MarkChang on 2016/8/12.
//  Copyright © 2016年 MarkChang. All rights reserved.
//

import XCTest

class NotificationUITests: XCTestCase {

	var downloadComplete = false
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()

		downloadComplete = false
    }
    
    override func tearDown() {
        super.tearDown()
    }

	func downloadFinished(notification: NSNotification) {
		downloadComplete = true
	}

	func testDownloadFinish() {
		XCUIApplication().buttons["Download"].tap()

		let indicator = XCUIApplication().activityIndicators["download indicator"]
		expectationForPredicate(NSPredicate(format: "hittable == false"), evaluatedWithObject: indicator, handler: nil)
		waitForExpectationsWithTimeout(10, handler: nil)

		print("DONE!")
	}


    func testDownloadFinishByGrabNotification() {
		// Cannot grab notification in XCUITest !!
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.downloadFinished(_:)), name:"finished", object: nil)

		XCUIApplication().buttons["Download"].tap()

//		while !downloadComplete {
//			// Will be infinite loop
//		}

		print("DONE!")
    }
}
