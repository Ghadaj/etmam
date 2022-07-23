//
//  TaskCard.swift
//  calenderSwift
//
//  Created by Danya T on 21/11/1443 AH.
//

import SwiftUI


struct TaskCard: View {
    var task : Task
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    @EnvironmentObject var dbOrg: orgDatabaseVM


    @State var assignee: [String] = []
    @State private var status = ["To Do","Doing","Done"]
    @State var selectedStatus = "To Do"
    @State var isDatePickerVisible: Bool = false
    @State var Deadline = Date()
    @State private var taskNavBarTitle = "Task"
    @State var taskTitle = ""
    @State var taskDesc = ""
    @State var taskProject = ""
    @State var taskProjectName = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var user = User(firstName: "nil", lastName: "nil", userJobTitle: "nil", userPhone: "nil", userEmail: "nil", userPermession: 5, userProjects: ["nil"], userTasks: ["nil"], userMeetings: ["nil"], userImage: "nil", userLineManger: "nil", userOrg: "nil")
    @State private var textHeight: CGFloat = 40
    @State private var maxTextHeight: CGFloat = 10000000
    let columns = Array(repeating: GridItem(.flexible(minimum: 1, maximum: 1), spacing: 35), count: 5)
    @State var showStack = false
    func getLM(){
        dbUsers.getUserName2(id: task.taskCreator!){
         (success) -> Void in
             if success {
                 getUser()
                 firstName = dbUsers.firstName
                 lastName = dbUsers.lastName

        }}
    }
    
    func getProjectName(projectId: String) -> String{
       return dbUsers.projects.first(where: { $0.id == projectId})?.projectName ?? "Personal"
    }
    func getUser() {
        dbUsers.getUser2(userID: task.taskCreator!){
         (success) -> Void in
             if success {
                 showStack = true
                 user = dbUsers.user
}
    }}
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {

        let x = dbOrg.getMembers()

        
        Form{
            
            Section{
               
                TextField( "Title".localized, text: $taskTitle)
                    
                
                
                TextView(placeholderText: "Description".localized, text: $taskDesc, minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
            }
            
            
            Section{
                
                HStack{
                    Text("Deadline".localized)
                    
                    if isDatePickerVisible {
                        DatePicker("",
                                   selection: $Deadline,
                                   displayedComponents: .date)
                           
                            .accentColor(Color("blue"))
                    }
                    
                    
                    Toggle("", isOn: $isDatePickerVisible)
                 
                  
                }
                HStack{
                    Text("Status".localized)
                    
                    Spacer()
                    Menu {
                        Picker(selection: $selectedStatus) {
                            ForEach(status, id:\.self) { value in
                                Text(value.localized)
                                    .tag(value)
                                   
                            }
                        } label: {}
                    } label: {
                        HStack{
                            
                         Spacer()

                        statusIcon(status: selectedStatus)
                            Text(selectedStatus.localized).foregroundColor(Color("blue"))
                        }
                           
                    }
                    
                    
             
            }
            }
            Section{
                
                NavigationLink(destination:
                                Projects(selectedProject: $taskProject , selectedProjectName: $taskProjectName)){
                    HStack{
                    Image(systemName: "align.vertical.top.fill").foregroundColor(Color("blue"))
                    Text("Project: ".localized)
                   
                    Text(getProjectName(projectId: taskProject).localized).foregroundColor(.gray)

                }
                }
                
                
                
                let x = getLM()

                NavigationLink(destination:
                                OtherUsersProfile(user: user)) {
                    HStack{
                        Image(systemName: "person.fill").foregroundColor(Color("blue"))
                        Text("Creator: ".localized)

                        Image(uiImage: imageWith(name: "\(firstName) \(lastName)")!).resizable().frame(width:25 , height: 25)

                        Text("\(firstName) \(lastName)").foregroundColor(.gray)
                    }
                    
                }
                
                
                
                NavigationLink(destination: OrgUsers ( selectedUsers: $assignee, navBarTitle: $taskNavBarTitle)) {
                    
                    
                    HStack{
                    
                        Image(systemName: "person.fill.badge.plus").foregroundColor(Color("blue"))
                        Text("Assignee: ".localized)
                         
                        membersCapsule(assignee, bigArrayOfUsers: dbOrg.orgMembers).padding(.bottom,-50)
                        }
                        
                        
                        
                    }
                    
                }
                
            
            
            Section{
                
                HStack{
                    Image(systemName: "paperclip").foregroundColor(Color("blue"))
                    Text("Attachments".localized)
                    Spacer()
                    Image(systemName: "plus").foregroundColor(Color("gray"))
                }
                
             
                
            }
            
        
        }
        .navigationTitle("Task".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
        ToolbarItem(placement:.confirmationAction){
            
            Button(action:{
                if taskTitle != "" {
                    if isDatePickerVisible{
                    task.taskTitle = taskTitle
                    task.taskDesc = taskDesc
                    task.taskStatus = selectedStatus
                    task.taskDeadline = Deadline
                    task.taskMembers = assignee
                    task.taskProjectId = taskProject
                        
                    dbTasks.updateTask(task)
                   
                    }else{
                      
                            task.taskTitle = taskTitle
                            task.taskDesc = taskDesc
                            task.taskDeadline = nil
                            task.taskStatus = selectedStatus
                            task.taskMembers = assignee
                            task.taskProjectId = taskProject
                            dbTasks.updateTask(task)
                    

                }
                    presentationMode.wrappedValue.dismiss()
                }}) {
                    Text("Save".localized).foregroundColor(taskTitle != "" ? Color("blue") :.gray)
            }
        }
      }
    
    }
}

