//
//  ProjectsTasks.swift
//  calenderSwift
//
//  Created by Danya T on 29/11/1443 AH.
//

import SwiftUI

struct ProjectsTasks: View {
    
    @EnvironmentObject var dbProjects: projectDatabaseVM
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    @Environment(\.presentationMode) var presentationMode
    var project: Project
    @State var pickerTaskStatus = "To Do"
    @State var PName = ""
    @State var PId = ""
    @State var today = Date()
    @State private var showAddSheet = false
    @State var fromCalendar = false
    
    var body: some View {
        ZStack{
           
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack{
                Picker(selection: self.$pickerTaskStatus, label: Text("Pick One")) {
                    Text("To Do").tag("To Do")
                    Text("Doing").tag("Doing")
                    Text("Done").tag("Done")
                }
                .pickerStyle(.segmented)
                .padding([.top, .leading, .trailing])
                ScrollView{
                          VStack{
                            HStack{
                              Button(action: {showAddSheet = true}){
                                Image(systemName: "plus.circle.fill").foregroundColor(Color("blue")).font(.title3)
                                  Text("Add".localized).foregroundColor(Color("blue")).font(.title3)
                              }.padding(.leading)
                              Spacer()
                              }
                            if pickerTaskStatus == "To Do"{
                              let meeting = toDoMeetings(id: project.id ?? "", m: dbMeetings.meetings)
                              let tasks = toDoTasks(id: project.id ?? "", t: dbTasks.tasks)
                              ForEach(meeting.indices, id:\.self){ index in
                                MakeMeetingCell(meeting: meeting[index])
                              }
                              ForEach(tasks.indices, id:\.self){ index in
                                MakeTaskCell(task: tasks[index])
                              }
                            }
                            if pickerTaskStatus == "Doing"{
                              let tasks = DoingTasks(id: project.id ?? "", t: dbTasks.tasks)
                              ForEach(tasks.indices, id:\.self){ index in
                                MakeTaskCell(task: tasks[index])
                              }
                            }
                            if pickerTaskStatus == "Done"{
                              let meeting = DoneMeetings(id: project.id ?? "", m: dbMeetings.meetings)
                              let tasks = DoneTasks(id: project.id ?? "", t: dbTasks.tasks)
                              ForEach(meeting.indices, id:\.self){ index in
                                MakeMeetingCell(meeting: meeting[index])
                              }
                              ForEach(tasks.indices, id:\.self){ index in
                                MakeTaskCell(task: tasks[index])
                              }
                            }
                          }.padding()
                          .sheet(isPresented: $showAddSheet, content: {
                            AddTaskMeetingSheet(showAddSheet: $showAddSheet, taskProject: PId, taskProjectName: PName, meetingProject: PId, meetingProjectName: PName)
                          })
                      }


        }
        } .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
    
}
    
    

}
