import SwiftUI
import os
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth
import UIKit
import CoreLocation
import UserNotifications
@main
struct etmamApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @ObservedObject var dbOrgs: orgDatabaseVM
  @ObservedObject var dbProjects: projectDatabaseVM
  @ObservedObject var dbTasks: taskDatabaseVM
  @ObservedObject var dbMeetings: meetingDatabaseVM
  @ObservedObject var dbUsers: userDatabaseVM
  @StateObject var dbuserAuth = UserAuthVM.sharedauthVM
  @State var isSignedIn : Bool = false
  @State var userSignedOut : Bool = false

  init(){
    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "tabBarColor")
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 0.26, green: 0.77, blue: 0.84, alpha: 1.00)], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
    UITableView.appearance().backgroundColor = UIColor(named: "BackgroundColor")
    UINavigationBar.appearance().tintColor = UIColor(named: "blue")
    UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(named: "blue")
    FirebaseApp.configure()
    dbOrgs = orgDatabaseVM()
    dbTasks = taskDatabaseVM()
    dbProjects = projectDatabaseVM()
    dbMeetings = meetingDatabaseVM()
    dbUsers = userDatabaseVM()
    FirebaseApp.configure(name: "CreatingUsersApp", options: FirebaseApp.app()!.options)

  }
  var body: some Scene {
    WindowGroup {
      if (Auth.auth().currentUser?.uid != nil){
          SplashView(userSignedOut: $userSignedOut, isSignedIn: $isSignedIn)
          .environmentObject(dbTasks)
          .environmentObject(dbOrgs)
          .environmentObject(dbProjects)
          .environmentObject(dbMeetings)
          .environmentObject(dbUsers)
          .environmentObject(dbuserAuth)
      }
      else {
          SplashViewForSignIn(isSignedIn: $isSignedIn, userSignedOut: $userSignedOut)
          .environmentObject(dbTasks)
          .environmentObject(dbOrgs)
          .environmentObject(dbProjects)
          .environmentObject(dbMeetings)
          .environmentObject(dbUsers)
          .environmentObject(dbuserAuth)
      }
    }
  }
}
class RegionAlert: ObservableObject
{
  static let shared = RegionAlert()
  @Published var isInRegion = false
}
//*** Implement App delegate ***//
class AppDelegate: NSObject, UIApplicationDelegate,ObservableObject
{
  var window: UIWindow?
  var locationManager: CLLocationManager!
  var notificationCenter: UNUserNotificationCenter!
  var notifacationMsg = ""
  var regionAlert = RegionAlert.shared
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.locationManager = CLLocationManager()
    self.locationManager!.delegate = self
    // get the singleton object
    self.notificationCenter = UNUserNotificationCenter.current()
    // register as it's delegate
    notificationCenter.delegate = self
    // define what do you need permission to use
    let options: UNAuthorizationOptions = [.alert, .sound]
    // request permission
    notificationCenter.requestAuthorization(options: options) { (granted, error) in
      if !granted {
        print("Permission not granted")
      }
    }
    if launchOptions?[UIApplication.LaunchOptionsKey.location] != nil {
      print("I woke up thanks to geofencing")
    }
    return true
  }
  func handleEvent(forRegion region: CLRegion!) {
    let authVM = UserAuthVM.sharedauthVM
    if authVM.IsSignedIn {
      // customize your notification content
      let content = UNMutableNotificationContent()
      content.title = "Etmam"
      content.body = notifacationMsg
      content.sound = UNNotificationSound.default
      // when the notification will be triggered
      let timeInSeconds: TimeInterval = 3
      // the actual trigger object
      let trigger = UNTimeIntervalNotificationTrigger(
        timeInterval: timeInSeconds,
        repeats: false
      )
      // notification unique identifier, for this example, same as the region to avoid duplicate notifications
      let identifier = region.identifier
      // the notification request object
      let request = UNNotificationRequest(
        identifier: identifier,
        content: content,
        trigger: trigger
      )
      // trying to add the notification request to notification center
      notificationCenter.add(request, withCompletionHandler: { (error) in
        if error != nil {
          print("Error adding notification with identifier: \(identifier)")
        }
      })
    }
  }
}
extension AppDelegate: CLLocationManagerDelegate {
  // called when user Exits a monitored region
  func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    if region is CLCircularRegion {
      // Do what you want if this information
      notifacationMsg = "Dont forget to check-out"
      //isInRegion = false
      regionAlert.isInRegion = false
      self.handleEvent(forRegion: region)
    }
  }
  // called when user Enters a monitored region
  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    if region is CLCircularRegion {
      // Do what you want if this information
      notifacationMsg = "Dont forget to check-in"
      // isInRegion = true
      regionAlert.isInRegion = true
      self.handleEvent(forRegion: region)
    }
  }
}
extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    // when app is onpen and in foregroud
    completionHandler(.banner)
  }
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // get the notification identifier to respond accordingly
    let identifier = response.notification.request.identifier
    // do what you need to do
    print(identifier)
    // ...
  }
}


////
////  etmamApp.swift
////  etmam
////
////  Created by Ghada on 15/06/2022.
////
//
//import SwiftUI
//import os
//
//import Firebase
//import FirebaseFirestoreSwift
//import FirebaseAuth
//
//import UIKit
//import CoreLocation
//import UserNotifications
//
//@main
//struct etmamApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @ObservedObject var dbOrgs: orgDatabaseVM
//    @ObservedObject var dbProjects: projectDatabaseVM
//    @ObservedObject var dbTasks: taskDatabaseVM
//    @ObservedObject var dbMeetings: meetingDatabaseVM
//    @ObservedObject var dbUsers: userDatabaseVM
//    @ObservedObject var userAuthVM: UserAuthVM
//    @StateObject var dbuserAuth = UserAuthVM.sharedauthVM
//
//
//    init(){
//
//        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "tabBarColor")
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 0.26, green: 0.77, blue: 0.84, alpha: 1.00)], for: .selected)
//            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
//            UITableView.appearance().backgroundColor = UIColor(named: "BackgroundColor")
//            UINavigationBar.appearance().tintColor = UIColor(named: "blue")
//          UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(named: "blue")
//
//
//
//
//        UITableView.appearance().backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
//        FirebaseApp.configure()
//        dbOrgs = orgDatabaseVM()
//        dbTasks = taskDatabaseVM()
//        dbProjects = projectDatabaseVM()
//        dbMeetings = meetingDatabaseVM()
//        dbUsers = userDatabaseVM()
//        userAuthVM = UserAuthVM()
//
//
//
//    }
//    var body: some Scene {
//        WindowGroup {
//
//
//            if (Auth.auth().currentUser?.uid != nil){
//                TabBar()
//                    .environmentObject(dbTasks)
//                    .environmentObject(dbOrgs)
//                    .environmentObject(dbProjects)
//                    .environmentObject(dbMeetings)
//                    .environmentObject(dbUsers)
//                    .environmentObject(dbuserAuth)
//                    .environmentObject(userAuthVM)
//            }
//            else {
//                AuthView()
//                    .environmentObject(dbTasks)
//                    .environmentObject(dbOrgs)
//                    .environmentObject(dbProjects)
//                    .environmentObject(dbMeetings)
//                    .environmentObject(dbUsers)
//                    .environmentObject(dbuserAuth)
//                    .environmentObject(userAuthVM)
//
//            }
//
//
//
//        }
//    }
//}
//
//
//class RegionAlert: ObservableObject
//{
//    static let shared = RegionAlert()
//    @Published var isInRegion = false
//}
//
////*** Implement App delegate ***//
//
//class AppDelegate: NSObject, UIApplicationDelegate,ObservableObject
//{
//
//
//    var window: UIWindow?
//    var locationManager: CLLocationManager!
//    var notificationCenter: UNUserNotificationCenter!
//    var notifacationMsg = ""
//
//
//
//
//
//    var regionAlert = RegionAlert.shared
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//
//        self.locationManager = CLLocationManager()
//        self.locationManager!.delegate = self
//
//        // get the singleton object
//        self.notificationCenter = UNUserNotificationCenter.current()
//
//        // register as it's delegate
//        notificationCenter.delegate = self
//
//        // define what do you need permission to use
//        let options: UNAuthorizationOptions = [.alert, .sound]
//
//        // request permission
//        notificationCenter.requestAuthorization(options: options) { (granted, error) in
//            if !granted {
//                print("Permission not granted")
//            }
//        }
//
//        if launchOptions?[UIApplication.LaunchOptionsKey.location] != nil {
//            print("I woke up thanks to geofencing")
//        }
//
//
//        return true
//    }
//
//    func handleEvent(forRegion region: CLRegion!) {
//        let authVM = UserAuthVM.sharedauthVM
//        if authVM.IsSignedIn {
//        // customize your notification content
//        let content = UNMutableNotificationContent()
//        content.title = "Etmam"
//        content.body = notifacationMsg
//        content.sound = UNNotificationSound.default
//
//        // when the notification will be triggered
//        let timeInSeconds: TimeInterval = 3
//        // the actual trigger object
//        let trigger = UNTimeIntervalNotificationTrigger(
//            timeInterval: timeInSeconds,
//            repeats: false
//        )
//
//        // notification unique identifier, for this example, same as the region to avoid duplicate notifications
//        let identifier = region.identifier
//
//        // the notification request object
//        let request = UNNotificationRequest(
//            identifier: identifier,
//            content: content,
//            trigger: trigger
//        )
//
//        // trying to add the notification request to notification center
//        notificationCenter.add(request, withCompletionHandler: { (error) in
//            if error != nil {
//                print("Error adding notification with identifier: \(identifier)")
//            }
//        })
//    }
//    }
//}
//
//
//extension AppDelegate: CLLocationManagerDelegate {
//    // called when user Exits a monitored region
//    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//        if region is CLCircularRegion {
//            // Do what you want if this information
//            notifacationMsg = "Dont forget to check-out"
//            //isInRegion = false
//            regionAlert.isInRegion = false
//            self.handleEvent(forRegion: region)
//        }
//    }
//
//    // called when user Enters a monitored region
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        if region is CLCircularRegion {
//            // Do what you want if this information
//            notifacationMsg = "Dont forget to check-in"
//           // isInRegion = true
//            regionAlert.isInRegion = true
//            self.handleEvent(forRegion: region)
//        }
//    }
//}
//
//
//extension AppDelegate: UNUserNotificationCenterDelegate {
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        // when app is onpen and in foregroud
//        completionHandler(.banner)
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        // get the notification identifier to respond accordingly
//        let identifier = response.notification.request.identifier
//
//        // do what you need to do
//        print(identifier)
//        // ...
//    }
//}
//
