//
//  AddTask.swift
//  calenderSwift
//
//  Created by Danya T on 09/11/1443 AH.
//

import SwiftUI


struct AddTask: View {
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @State  var assignee: [String] = []
    @Binding var selectedDate: Date
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
        
        
        
        Form{
            
            Section{
               
                TextField( "Title", text: $taskTitle)
                    
                
                
                TextView(placeholderText: "Description", text: $taskDesc, minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                   
            }
            
            
            Section{
                
                HStack{
                    Text("Deadline")
                 
                    Button(action: {isDatePickerVisible.toggle()}){
                        Toggle("", isOn: $isDatePickerVisible)
                    }
                }
                
                
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

                    Text("Project: ")
                   
                    Text(taskProjectName).foregroundColor(.gray)

                }
                
                
                NavigationLink(destination: OrgUsers(selectedUsers: $assignee, navBarTitle: $taskNavBarTitle)){
                    
                    
                    
                    HStack{
                        Image(systemName: "person.badge.plus").foregroundColor(Color("blue"))
                            Text("Assignee: ")
                         
                        Text("\(assignee.count)").foregroundColor(.gray)
                         
                           
                       }
                    
                }
            }
            Section{
                
            
                HStack{
                    Text("Task Color")
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
                    Image(systemName: "paperclip").foregroundColor(.gray)
                    Text("Attachments")
                    Spacer()
                    Image(systemName: "plus").foregroundColor(Color("blue"))
                }
                
            }
            
        }
        .toolbar{
            ToolbarItem(placement: .confirmationAction){
            
            Button(action:{
                
                if taskTitle != "" {
                    if isDatePickerVisible{
                    dbTasks.addTask(Task(taskTitle: taskTitle, taskDesc: taskDesc, taskCreator: "", taskMembers: assignee, taskProjectId: taskProject, taskStartDate: selectedDate, taskDeadline: Deadline, taskAttachments: [], taskColor: selectedColor,taskStatus: "To Do"))
                    }else{
                        dbTasks.addTask(Task(taskTitle: taskTitle, taskDesc: taskDesc, taskCreator: "", taskMembers: assignee, taskProjectId: taskProject, taskStartDate: selectedDate, taskAttachments: [], taskColor: selectedColor,taskStatus: "To Do"))
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
    @Binding var selectedDate: Date
    @State private var choice = 0
    @Binding var showAddSheet: Bool
  
    @State  var taskProject = "No project"
    @State  var taskProjectName = "No project"
    @State  var meetingProject = "No project"
    @State  var meetingProjectName = "No project"
    

        
    
  var body : some View{
        
        NavigationView{
            
            VStack {
                if choice == 0{
                    AddTask(selectedDate: $selectedDate,showAddSheet: $showAddSheet, taskProject: $taskProject, taskProjectName:
                                $taskProjectName)
              
                    
                }
                if choice == 1{
                    AddMeeting(selectedDate: $selectedDate,showAddSheet: $showAddSheet, meetingProject: $meetingProject, meetingProjectName: $meetingProjectName)
              
                }
            }
            
         
        
           
            .navigationTitle(choice == 0 ? "Add Task": "Add Meeting")
            .navigationBarTitleDisplayMode(.inline)
           
            
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                   
                                        Button(action:{showAddSheet = false}) {
                                           Text("Cancel").foregroundColor(Color("blue"))
                    
                                        }                }
                
                ToolbarItem(placement: .principal){
                    
                  
                    Picker(selection: self.$choice, label: Text("")) {
                        Text("Task").tag(0)
                   
                        Text("Meeting").tag(1)
                
                   
                                       }
                                           .frame(width: 180,height: 40)
                                           .pickerStyle(SegmentedPickerStyle())
                                           
                   
                
                }
                
            }
                      
//            .toolbar{
//
//
//                ToolbarItem(placement: .navigationBarLeading ){
//
//
//                    Button(action:{showAddSheet = false}) {
//                        Text("Cancel").foregroundColor(Color("blue"))
//
//                    }
//                }
//
//
//                ToolbarItem{
//
//
//                        Picker(selection: self.$choice, label: Text("")) {
//                            Text("Task").tag(0).onTapGesture {
//                                choice = 0
//
//                            }
//
//                            Text("Meeting").tag(1).onTapGesture {
//                                choice = 1
//
//                            }
//
//                    }
//                        .frame(width: 180,height: 40)
//                        .pickerStyle(SegmentedPickerStyle())
//                        .padding(.horizontal, 50.0)
//
//                 }
//             }
        }
    }
}





