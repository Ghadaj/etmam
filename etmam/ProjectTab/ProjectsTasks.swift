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
                .frame(width: 344)
                .padding([.top, .leading, .trailing])
                ScrollView{
                    VStack{
                        
                       
                        
                        if pickerTaskStatus == "To Do"{
                            let meeting = toDoMeetings(id: project.id ?? "", m: dbMeetings.meetings)
                            let tasks = toDoTasks(id: project.id ?? "", t: dbTasks.tasks)
                            ForEach(meeting.indices, id:\.self){ index in
                                MakeMeetingCell2(meeting: meeting[index])
                                
                            }
                            ForEach(tasks.indices, id:\.self){ index in
                                MakeTaskCell2(task: tasks[index])
                                
                            }
                            
                        }
                        if pickerTaskStatus == "Doing"{
                           
                            let tasks = DoingTasks(id: project.id ?? "", t: dbTasks.tasks)
                          
                            ForEach(tasks.indices, id:\.self){ index in
                                MakeTaskCell2(task: tasks[index])
                                
                            }
                            
                        }
                        
                        if pickerTaskStatus == "Done"{
                            let meeting = DoneMeetings(id: project.id ?? "", m: dbMeetings.meetings)
                            let tasks = DoneTasks(id: project.id ?? "", t: dbTasks.tasks)
                            ForEach(meeting.indices, id:\.self){ index in
                                MakeMeetingCell2(meeting: meeting[index])
                                
                            }
                            ForEach(tasks.indices, id:\.self){ index in
                                MakeTaskCell2(task: tasks[index])
                                
                            }
                            
                        }
                        
                      
                            
                    } .sheet(isPresented: $showAddSheet, content: {
                        AddTaskMeetingSheet(selectedDate: $today,showAddSheet: $showAddSheet, taskProject: PId, taskProjectName: PName, meetingProject: PId, meetingProjectName: PName)
                    })
                   
                    
            }
        }
        } .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
        
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                        Button(action:{showAddSheet = true }){
                            
                            Image(systemName: "plus").font(.system(size:15))
                                .foregroundColor(Color("blue"))
                            Text("Add").foregroundColor(Color("blue"))
                            
                        }
                       
                        
                    }
                    
                }
            }
    
}
    
    

}
