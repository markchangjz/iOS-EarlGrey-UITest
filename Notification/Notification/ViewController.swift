//
//  ViewController.swift
//  Notification
//
//  Created by MarkChang on 2016/8/12.
//  Copyright © 2016年 MarkChang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var downloadButton: UIButton!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	override func viewDidLoad() {
		super.viewDidLoad()

		activityIndicator.hidesWhenStopped = true
		activityIndicator.accessibilityIdentifier = "download indicator"
	}

	@IBAction func tapDownload(sender: AnyObject) {
		self.activityIndicator.startAnimating()
		self.downloadButton.enabled = false

		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

		dispatch_async(queue) { () -> Void in
			sleep(2) // downloading
			
			dispatch_async(dispatch_get_main_queue(), { () -> Void in

				NSNotificationCenter.defaultCenter().postNotificationName("finished", object: nil) // completed

				self.activityIndicator.stopAnimating()
				self.downloadButton.enabled = true
			})
		}
	}
}
