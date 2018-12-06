//
//  AppDelegate.swift
//  SwiftySlideshow
//
//  Created by Lacy Rhoades on 11/17/17.
//  Copyright © 2017 Lacy Rhoades. All rights reserved.
//

import UIKit

@UIApplicationMain
class DemoAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Controls the slides
    var slideshowController: SlideshowController?
    
    var mainVC: DemoViewController? {
        return (self.window?.rootViewController as? DemoViewController)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Will fetch data for slideshow from the Photo Library
        let slideshowDataSource = DemoDataSource()
        
        self.slideshowController = SlideshowController(
            dataSource: slideshowDataSource,
            defaultImage: UIImage(named: "default-slide")
        )
        
        // Optional, to show the screen info on the main VC
        self.slideshowController?.delegate = self.mainVC
        
        // To feed the table view with data
        self.mainVC?.slideshowDataSource = slideshowDataSource
        
        #if DEBUG
        SlideshowController.defaultSlideDuration = 1.0
        #endif
        
        return true
    }
    
    func resetExternalScreens(_ andThen: @escaping () -> ()) {
        self.slideshowController?.detachSlideshowController()
        self.slideshowController?.attachSlideshowController(toScreens: UIScreen.screens)
        andThen()
    }
}
