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
    @State private var textHeight: CGFloat = 40
    @State private var maxTextHeight: CGFloat = 10000000
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
                    
                    if isDatePickerVisible {
                        DatePicker("",
                                   selection: $Deadline,
                                   displayedComponents: .date)
                           
                            .accentColor(Color("blue"))
                    }
                    
                    
                    
                 
                    Button(action: {isDatePickerVisible.toggle()}){
                        Toggle("", isOn: $isDatePickerVisible)
                    }
                }
                HStack{
                    Text("Status")
                    
                    Spacer()
                    Menu {
                        Picker(selection: $selectedStatus) {
                            ForEach(status, id:\.self) { value in
                                Text(value)
                                    .tag(value)
                                   
                            }
                        } label: {}
                    } label: {
                        HStack{
                            
                         Spacer()

                        statusIcon(status: selectedStatus)
                            Text(selectedStatus).font(.title3).foregroundColor(Color("blue"))
                        }
                           
                    }
                    
                    
             
            }
            }
            Section{
                
                
                NavigationLink(destination:
                                Projects(selectedProject: $taskProject , selectedProjectName: $taskProjectName)){
                    
                    
                    Text("Project:")
                   
                    Text(taskProjectName).foregroundColor(.gray)
                    
                }
                
                
                
                

                NavigationLink(destination:
                                CardCell()) {
                    HStack{
                        Image(systemName: "person").foregroundColor(Color("blue"))
                        Text("Creator:")
                        Spacer()
                        Image(uiImage: imageWith(name: "Salem Nasser")!).resizable().frame(width:25 , height: 25)
                        Text("Salem Nasser").foregroundColor(.gray)
                    }

                }
                
                
                
                NavigationLink(destination: OrgUsers ( selectedUsers: $assignee, navBarTitle: $taskNavBarTitle)) {
                    
                    
                    HStack{
                    
                        Image(systemName: "person.badge.plus").foregroundColor(Color("blue"))
                            Text("Assignee: ")
                         
                        Text("\(assignee.count)").foregroundColor(.gray)
                        }
                        
                        
                        
                    }
                    
                }
                
            
            
            Section{
                
                HStack{
                    Image(systemName: "paperclip").foregroundColor(.gray)
                    Text("Attachments")
                    Spacer()
                    Image(systemName: "plus").foregroundColor(Color("blue"))
                }
                
             
                
            }
            
        
        }
        .navigationTitle("Task")
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
                Text("Save").foregroundColor(taskTitle != "" ? Color("blue") :.gray)
            }
        }
      }
    
    }
}

//struct TaskCard_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskCard()
//    }
//}
