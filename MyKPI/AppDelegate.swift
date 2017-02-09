//
//  AppDelegate.swift
//  MyKPI
//
//  Created by Zsolt Pete on 27/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var questions: [Question]?
    var results: [String]?
    var resultsDates: [String]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if (UserDefaults.standard.object(forKey: "FirstRun") == nil) {
            var kQuestions: [Question] = []
            kQuestions.append(Question(title: "Milyen hangulat?", type: Constants.QuestionTypes.Feeling))
            kQuestions.append(Question(title: "Milyen hangulat munka érkezésekor?", type: Constants.QuestionTypes.Feeling))
            kQuestions.append(Question(title: "Milyen hangulat munka végén?", type: Constants.QuestionTypes.Feeling))
            kQuestions.append(Question(title: "Taskok száma?", type: Constants.QuestionTypes.Point))
            kQuestions.append(Question(title: "Észre vett bugok száma?", type: Constants.QuestionTypes.Point, lower: "2"))
            kQuestions.append(Question(title: "Plus content hozzáadás?", type: Constants.QuestionTypes.TrueFalse))
            kQuestions.append(Question(title: "Reggeli kérdések száma?", type: Constants.QuestionTypes.Point, lower: "1"))
            kQuestions.append(Question(title: "Napközbeni kérdések száma?", type: Constants.QuestionTypes.Point, lower: "2"))
            kQuestions.append(Question(title: "Vélemény kikérés  száma?", type: Constants.QuestionTypes.Point, lower: "1"))
            kQuestions.append(Question(title: "Tényleges munkával töltött idők száma?", type: Constants.QuestionTypes.Time))
            kQuestions.append(Question(title: "Ügyfél visszajelzése?", type: Constants.QuestionTypes.Point))
            kQuestions.append(Question(title: "Volt-e csapatépítő?", type: Constants.QuestionTypes.TrueFalse))
            kQuestions.append(Question(title: "Volt-e közös/platform megbeszélés?", type: Constants.QuestionTypes.TrueFalse, lower: "1"))
            kQuestions.append(Question(title: "Volt-e Code review?", type: Constants.QuestionTypes.TrueFalse, lower: "1"))
            kQuestions.append(Question(title: "Visszadobott taskok száma?", type: Constants.QuestionTypes.Point, lower: "2"))
            kQuestions.append(Question(title: "Scrum pont száma?", type: Constants.QuestionTypes.Point))
            kQuestions.append(Question(title: "Projektben való részvétel száma?", type: Constants.QuestionTypes.Point, lower: "1"))
            kQuestions.append(Question(title: "Volt-e InfoDay?", type: Constants.QuestionTypes.TrueFalse))
            kQuestions.append(Question(title: "Irodában töltött idő?", type: Constants.QuestionTypes.Time))
            
            UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: kQuestions), forKey: "BaseQuestions")
            UserDefaults.standard.synchronize()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.questions = kQuestions
            UserDefaults.standard.set(true, forKey: "FirstRun")
            UserDefaults.standard.synchronize()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

