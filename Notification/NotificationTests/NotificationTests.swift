//
//  NotificationTests.swift
//  NotificationTests
//
//  Created by MarkChang on 2016/8/12.
//  Copyright © 2016年 MarkChang. All rights reserved.
//

import XCTest
@testable import Notification

class NotificationTests: XCTestCase {

	var vc: ViewController!
	var downloadComplete = false
    
    override func setUp() {
        super.setUp()

		let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
		vc = storyboard.instantiateInitialViewController() as! ViewController

		downloadComplete = false
	}

    override func tearDown() {
        super.tearDown()
    }

	func downloadFinished(notification: NSNotification) {
		downloadComplete = true
	}
    
    func testDownloadFinishByGrabNotification() {
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.downloadFinished(_:)), name:"finished", object: nil)

		let _ = vc.view
		vc.tapDownload(self)
		
		while !downloadComplete && NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture()) {
		}

		print("DONE!")
    }
}
