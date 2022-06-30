//
//  TabBar.swift
//  calenderSwift
//
//  Created by Danya T on 24/11/1443 AH.
//

import SwiftUI
import FirebaseAuth
enum Tabs: String{
    case Today
    case Projects
    case Calendar
    case Notifications
    
}

struct TabBar: View {
    @State var selectedTab : Tabs = .Today
    init() {
//        do{
//            try Auth.auth().signOut()}
//        catch {
//          
//            print("")
//        }
        UITabBar.appearance().backgroundColor = UIColor(named: "tabBarColor")
    }
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedTab){
                
                Today()
                    .tabItem{
                        Image(systemName: "doc.text.image")
                        Text("Today")
                        
                    }.tag(Tabs.Today)
                
                projectsTab()
                    .tabItem{
                        Image(systemName: "align.vertical.top")
                        Text("Projects")
                        
                    }.tag(Tabs.Projects)
                
                calendarTab()
                    .tabItem{
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }.tag(Tabs.Calendar)
                
                notificationTab()
                
                    .tabItem{
                        Image(systemName: "bell")
                        Text("Notification")
                    }.tag(Tabs.Notifications)
            }
            .accentColor(Color("blue"))
            .navigationTitle(selectedTab.rawValue)
            
            
        }.navigationViewStyle(.stack)
    }
}


struct TabBar_Previews: PreviewProvider {
  static var previews: some View {
    TabBar()
  }
}

