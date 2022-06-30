//
//  ContentView.swift
//  testFirebase
//
//  Created by Danya T on 02/11/1443 AH.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import StoreKit
struct task: View {
    
    // الفاريبلز الي توصلنا للداتابيس
    @EnvironmentObject var dbOrgs: orgDatabaseVM
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbProjects: projectDatabaseVM
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    //@Binding var projectID: String
    @State var package = "no subscription"
    @State var xx: String = "v"
    
    @State var purchased = false

    var body: some View {
        
        Text(dbUsers.userTasks[0].taskDeadline ?? "no deadline")
     //   Text(dbUsers.userTasks[1].taskDeadline ?? "no deadline")
 
   
    }
  
}

struct task_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
