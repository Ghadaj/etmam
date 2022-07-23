//
//  AddTask.swift
//  calenderSwift
//
//  Created by Danya T on 09/11/1443 AH.
//

import SwiftUI


struct AddTask: View {
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    @EnvironmentObject var userVM: userDatabaseVM
    @EnvironmentObject var dbOrg: orgDatabaseVM

    @State  var assignee: [String] = []
    @Binding var showAddSheet: Bool
    @State var isDatePickerVisible: Bool = false
    @State var Deadline = Date()
    @State var taskNavBarTitle = "Add Task"
    @State var taskTitle = ""
    @State var taskDesc = ""
    @Binding var taskProject: String
    @Binding var taskProjectName : String
    @State private var textHeight: CGFloat = 40
    @State private var maxTextHeight: CGFloat = 10000000
    @State var colors = ["purple", "brown", "green", "red","yellow"]
    @State private var selectedColor  = "purple"
    
    
    let columns = Array(repeating: GridItem(.flexible(minimum: 1, maximum: 1), spacing: 35), count: 5)
    
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        let y = dbOrg.getMembers()

        
        Form{
            
            Section{
               
                TextField( "Title".localized, text: $taskTitle)
                    
                
                
                TextView(placeholderText: "Description".localized, text: $taskDesc, minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                   
            }
            
            
            Section{
                
                
                 
                  
                Toggle("Deadline".localized, isOn: $isDatePickerVisible)
                        
                    
                
                
                
                if isDatePickerVisible {
                    DatePicker("",
                               selection: $Deadline,
                               displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .accentColor(Color("blue"))
                }
                
                
            }
            
                Section{
                
                NavigationLink(destination:
                    Projects(selectedProject: $taskProject , selectedProjectName: $taskProjectName)) {

                    HStack{
                    Image(systemName: "align.vertical.top.fill").foregroundColor(Color("blue"))
                    Text("Project: ".localized)
                   
                    Text(taskProjectName.localized).foregroundColor(.gray)

                }
                }
                
                
                NavigationLink(destination: OrgUsers(selectedUsers: $assignee, navBarTitle: $taskNavBarTitle)){
                    
                    
                    
                    HStack{
                        Image(systemName: "person.fill.badge.plus").foregroundColor(Color("blue"))
                        Text("Assignee: ".localized)
                         
                        membersCapsule(assignee, bigArrayOfUsers: dbOrg.orgMembers).padding(.bottom,-50)
                         
                           
                       }
                    
                }
            }
            Section{
                
            
                HStack{
                    Text("Task Color".localized)
                    Spacer()
                    ForEach(colors, id:\.self){ color in
                        ZStack {
                            Circle()
                                .fill(Color(color)).frame(width:32, height:32 )
                            Circle()
                                .strokeBorder(color == selectedColor ? .white : .clear, lineWidth: 1.2).frame(width:30, height:30 )
                                
                            
                                
                            if color == selectedColor{
                            Image(systemName:
                            "checkmark").foregroundColor(.white)
                            }
                            
                        }
                        
                            .scaleEffect(color == selectedColor ? 1.15 : 1.0)
                            .onTapGesture {
                                selectedColor = color
                                
                            }
                        
                    }
                 }
                HStack{
                    Image(systemName: "paperclip").foregroundColor(Color("blue"))
                    Text("Attachments".localized)
                    Spacer()
                    Image(systemName: "plus").foregroundColor(Color("gray"))
                }
                
            }
            
        }
        .toolbar{
            ToolbarItem(placement: .confirmationAction){
            
            Button(action:{
                
                if taskTitle != "" {
                    if isDatePickerVisible{
                    dbTasks.addTask(Task(taskTitle: taskTitle, taskDesc: taskDesc, taskCreator: userVM.currentUserID, taskMembers: assignee, taskProjectId: taskProject, taskDeadline: Deadline, taskAttachments: [], taskColor: selectedColor,taskStatus: "To Do",taskOrgID: userVM.currentOrgID))
                    }else{
                      dbTasks.addTask(Task(taskTitle: taskTitle, taskDesc: taskDesc, taskCreator: userVM.currentUserID, taskMembers: assignee, taskProjectId: taskProject, taskAttachments: [], taskColor: selectedColor,taskStatus: "To Do",taskOrgID: userVM.currentOrgID))
                    }
                    showAddSheet = false
                  }
                
            }) {
                Text("Add").foregroundColor(taskTitle == "" ?.gray : Color("blue"))
            }
        }
      }
    }
    
}









struct AddTaskMeetingSheet : View {
    @State private var choice = 0
    @Binding var showAddSheet: Bool
    @State var taskProject = ""
    @State var taskProjectName = ""
    @State var meetingProject = ""
    @State var meetingProjectName = ""
    var body : some View{
        NavigationView{
            VStack {
                if choice == 0{
                    AddTask(showAddSheet: $showAddSheet, taskProject: $taskProject, taskProjectName:
                                $taskProjectName)
                }
                if choice == 1{
                    AddMeeting(showAddSheet: $showAddSheet, meetingProject: $meetingProject, meetingProjectName: $meetingProjectName)
                }
            }
            
         
        
           
            .navigationTitle(choice == 0 ? "Add Task".localized: "Add Meeting".localized)
            .navigationBarTitleDisplayMode(.inline)
           
            
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                   
                                        Button(action:{showAddSheet = false}) {
                                            Text("Cancel".localized).foregroundColor(Color("blue"))
                    
                                        }                }
                
                ToolbarItem(placement: .principal){
                    
                  
                    Picker(selection: self.$choice, label: Text("")) {
                        Text("Task".localized).tag(0)
                   
                        Text("Meeting".localized).tag(1)
                
                   
                                       }
                                           .frame(width: 180,height: 40)
                                           .pickerStyle(SegmentedPickerStyle())
                                           
                   
                
                }
                
            }
                      
        }
    }
}





