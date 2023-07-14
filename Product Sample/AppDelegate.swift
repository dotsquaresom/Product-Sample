//
//  AppDelegate.swift
//  Product Sample
//
//  Created by OmPrakash Jangid on 13/07/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //MARK: - Application life cycle methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //MARK: - Splash screen witing time
        sleep(1)
        
        //MARK: - Set loader in center of screen
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //MARK: - Update navigation bar
        self.cutomiseNavigationBar()
        return true
    }
    
    func cutomiseNavigationBar(){
        //MARK: - Navigation Bar
        let Appearance = UINavigationBarAppearance()
        Appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavTextColor]
        Appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Config().AppNavTextColor]
        Appearance.backgroundColor = Config().AppNavColor
        
        UINavigationBar.appearance().tintColor = Config().AppNavTextColor//Back button and title color change
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().standardAppearance = Appearance
        UINavigationBar.appearance().scrollEdgeAppearance = Appearance
    }
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Product_Sample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
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

