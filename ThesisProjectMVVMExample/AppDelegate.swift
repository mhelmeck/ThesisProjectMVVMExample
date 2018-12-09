//
//  AppDelegate.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 09/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {
    // Properties
    public var window: UIWindow?

    lazy public var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ThesisProjectMVVMExample")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Error: \(error)")
            }
        }
        
        return container
    }()
    
    // Public methods
    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    public func applicationWillResignActive(_ application: UIApplication) {}

    public func applicationDidEnterBackground(_ application: UIApplication) {}

    public func applicationWillEnterForeground(_ application: UIApplication) {}

    public func applicationDidBecomeActive(_ application: UIApplication) {}

    public func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
