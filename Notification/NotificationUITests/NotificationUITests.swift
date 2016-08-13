//
//  NotificationUITests.swift
//  NotificationUITests
//
//  Created by MarkChang on 2016/8/12.
//  Copyright © 2016年 MarkChang. All rights reserved.
//

import XCTest

class NotificationUITests: XCTestCase {

	var downloadCompleted = false
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()

		downloadCompleted = false
    }
    
    override func tearDown() {
        super.tearDown()
    }

	func downloadFinished(notification: NSNotification) {
		downloadCompleted = true
	}

	func testDownload() {
		XCUIApplication().buttons["Download"].tap()

		let indicator = XCUIApplication().activityIndicators["download indicator"]
		expectationForPredicate(NSPredicate(format: "hittable == false"), evaluatedWithObject: indicator, handler: nil)
		waitForExpectationsWithTimeout(10, handler: nil)

		print("DONE!")
	}

    func testDownload_GrabNotification() {
		// Cannot grab notification in XCUITest!
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.downloadFinished(_:)), name:"finished", object: nil)

		XCUIApplication().buttons["Download"].tap()

//		while !downloadCompleted {
//			// Will be infinite loop
//		}

		print("DONE!")
    }
}
