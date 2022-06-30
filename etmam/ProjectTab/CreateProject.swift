//
//  CreateProject.swift
//  calenderSwift
//
//  Created by Danya T on 26/11/1443 AH.
//

import SwiftUI

struct CreateProject: View {
    @EnvironmentObject var dbProjects: projectDatabaseVM
    let userVM = userDatabaseVM()
    @State var projectName = ""
    @State var projectDesc = ""
    @State private var members: [String] = []
    @State var Deadline = Date()
    @State var projectNavBarTitle = "New Project"
    @State var colors = ["blue", "pink", "orange"]
    @State private var selectedColor  = "blue"
    @State var attachments = [""]
    @Binding var showCreateSheet: Bool
    
    let columns = Array(repeating: GridItem(.flexible(minimum: 1, maximum: 1), spacing: 35), count: 5)
    @State private var textHeight: CGFloat = 40
    @State private var maxTextHeight: CGFloat = 10000000
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        NavigationView{
            
            Form{
                
                Section{
                    
                    TextField( "Title", text: $projectName)
                    
                    
                    TextView(placeholderText: "Description", text: $projectDesc, minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                        .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                    
                }
                
                
                Section{
                    
                    HStack{
                        
                        Text("Deadline")
                        
                        DatePicker("",
                                   selection: $Deadline,
                                   displayedComponents: .date)
                        
                            .accentColor(Color("blue"))
                        
                    }
                    
                }
                
                Section{
                    
                    
                    
                    NavigationLink(destination: OrgUsers(selectedUsers: $members, navBarTitle: $projectNavBarTitle)){
                        
                        
                        
                        HStack{
                           
                            Image(systemName: "person.badge.plus").foregroundColor(Color("blue"))
                            Text("Members:")
                            Text("\(members.count)")
                        }
                        
                    }
                }
                Section{
                    
                    
                    HStack{
                        Text("Project Color")
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
                        Text("Files")
                        Spacer()
                        Image(systemName: "plus").foregroundColor(Color("blue"))
                    }
                    
                }
                
            }
        
            .navigationTitle("New Project")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    
                    Button(action:{
                        
                        if projectName != "" {
                            
                            dbProjects.addProject(Project(projectName: projectName, projectManager: userVM.currentUserID, projectDeadline: Deadline, projectMembers: members, projectDesc: projectDesc, projectAttachments: attachments, projectColor: selectedColor, orgID: userVM.currentOrgID))
                            
                            
                            showCreateSheet = false
                        }
                        
                    }) {
                        Text("Create").foregroundColor(projectName == "" ?.gray : Color("blue"))
                    }
                }
                ToolbarItem(placement: .cancellationAction){
                    Button(action:{
                        showCreateSheet = false
                    }){
                        Text("Cancel").foregroundColor(Color("blue"))
                    }
                    
                }
            }
        }
    }
    
}


struct CreateProject_Previews: PreviewProvider {
    static var previews: some View {
        CreateProject(showCreateSheet: .constant(true))
    }
}
