//
//  AppDelegate.swift
//  DentalYear
//
//  Created by Globizserve on 05/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import CoreData
import Updates
import PINCache
import Alamofire
import SwiftyJSON
import SwiftyStoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    fileprivate var noteAPI: NoteAPI!
//    fileprivate var localReplicator: LocalReplicator!
    fileprivate let runCountNamespace = "runCount"
    var window: UIWindow?
    
    lazy var datastoreCoordinator: DatastoreCoordinator = {
        return DatastoreCoordinator()
    }()

    lazy var contextManager: ContextManager = {
        return ContextManager()
    }()
    
    func sharedInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.enableDebugMode(false)
        self.noteAPI = NoteAPI.sharedInstance
//        self.localReplicator = LocalReplicator.sharedInstance
//        self.handleRunCount()
//        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        UIApplication.shared.setMinimumBackgroundFetchInterval(60)
        completeTransaction()
        MoveToSplash()
        return true
    }
    
    func completeTransaction(){
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                }
            }
        }
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        fetchVideoDataInBackground()
        fetchExhibitsDataInBackground()
        completionHandler(.newData)
    }
    
    func fetchFoodHolidayInBackground(){
        let url = APHandler.shared.baseUrl + "food?per_page=100"
        let apiHandler:APHandler = APHandler.init()
        apiHandler.makeGetAPIRequest(url: url)
        apiHandler.didFinishSuccessfullyCallback = { response in
            let responseObject = response as? AFDataResponse<Any>
            let foodHolidayObject = FoodHolidayBaseObject(json: JSON(responseObject?.data as Any))
            PINCache.shared().setObject(foodHolidayObject, forKey: "foodHoliday")
            
        }
    }
    
    func fetchVideoDataInBackground(){
        let url = APHandler.shared.baseUrl + "video?per_page=100"
        let apiHandler:APHandler = APHandler.init()
        apiHandler.makeGetAPIRequest(url: url)
        apiHandler.didFinishSuccessfullyCallback = { response in
            let responseObject = response as? AFDataResponse<Any>
            let videoObject = VideoBaseObject(json: JSON(responseObject?.data as Any))
            for videoObject in videoObject.dataArray!{
                print("Video Title : \(videoObject.videoTitle)")
            }
            PINCache.shared().setObject(videoObject, forKey: "video")
        }
    }
    
    func fetchExhibitsDataInBackground(){
        let url = APHandler.shared.baseUrl + "sponsor?per_page=100"
        let apiHandler:APHandler = APHandler.init()
        apiHandler.makeGetAPIRequest(url: url)
        apiHandler.didFinishSuccessfullyCallback = { response in
            let responseObject = response as? AFDataResponse<Any>
            let sponsorObject = SponsorBaseObject(json: JSON(responseObject?.data as Any))
            PINCache.shared().setObject(sponsorObject, forKey: "spnsors")
        }
    }
  
    func MoveToSplash()  {
        
        let storyBoard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)

        guard let splashViewController:SplashViewController = storyBoard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController else {return}
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window!.rootViewController = splashViewController
        window!.makeKeyAndVisible()
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        versionCheck()
    }
    
    func versionCheck(){
        Updates.checkForUpdates( notifying: .once) { (result) in
            UpdatesUI.promptToUpdate(result, presentingViewController: (self.window?.rootViewController)!)
        }
    }
    // MARK: UISceneSession Lifecycle

    


    // MARK: - Core Data stack

//    lazy var persistentContainer: NSPersistentContainer = {
//        /*
//         The persistent container for the application. This implementation
//         creates and returns a container, having loaded the store for the
//         application to it. This property is optional since there are legitimate
//         error conditions that could cause the creation of the store to fail.
//        */
//        let container = NSPersistentContainer(name: "DentalYear")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                /*
//                 Typical reasons for an error here include:
//                 * The parent directory does not exist, cannot be created, or disallows writing.
//                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                 * The device is out of space.
//                 * The store could not be migrated to the current model version.
//                 Check the error message to determine what the actual problem was.
//                 */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}

