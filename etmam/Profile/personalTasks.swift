//
//  personalTasks.swift
//  etmam
//
//  Created by Ghada on 13/07/2022.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers


struct personalTasks: View {
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbUser: userDatabaseVM

    
    @State private var showAddSheet = false
    @State private var taskProject = "Personal"
    @State private var meetingProject = "Personal"
    
    @State var privilage : [String] = ["Admin", "Emplyee"]
    @State var packages : [String] = ["Essentials", "Profissionals", "Customized"]
    
    @State var userType = "Admin"
    @State var userSubscription = "Profissionals"
    @State var showSheetView = false
    @State private var taskNavBarTitle = "Project"
    @State var assignee: [String] = []
    private let calendar = Calendar(identifier: .gregorian)
    
    
    var body: some View {
        ScrollView{
VStack{

 
// for showing meetings cells for today
ForEach(dbMeetings.meetings.indices, id: \.self) {index in
  //  if calendar.isDateInToday( dbMeetings.meetings[index].meetingDate ?? Date()){
        MakeMeetingCell(meeting: dbMeetings.meetings[index])
   // }
}
// for showing tasks cells for today
ForEach(dbUser.tasks.indices, id: \.self) {index in
   // if dbTasks.tasks[index].taskDeadline != nil && calendar.isDateInToday(dbTasks.tasks[index].taskDeadline ?? //Date())
  //  {
        MakeTaskCell(task: dbUser.tasks[index])
   //}
}
    
}}.background(Color("BackgroundColor"))}}
