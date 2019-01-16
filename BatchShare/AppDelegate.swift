//
//  AppDelegate.swift
//  BatchShare
//
//  Created by Cameron Milliken on 1/15/19.
//  Copyright © 2019 Cameron Milliken. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        
        return true
    }
}
