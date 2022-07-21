//
//  Asignee_Projects.swift
//  calenderSwift
//
//  Created by Danya T on 19/11/1443 AH.
//

import SwiftUI

struct OrgUsers : View{
    @EnvironmentObject var dbUsers: userDatabaseVM
    @EnvironmentObject var dbOrgs: orgDatabaseVM
    @EnvironmentObject var dbProjects: projectDatabaseVM
   
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
    @State var searchingFor = ""
    @Binding var selectedUsers: [String]
    @Binding var navBarTitle: String
    @State var project: Project = Project(projectName: "", projectManager: "", projectDeadline: Date(), projectMembers: [], projectDesc: "", projectAttachments: [], projectColor: "", orgID: "")
    var body: some View {
        
        VStack{
            List {
                ForEach(results.indices, id: \.self) { index in
                    if let id = results[index].id {
                        var userName = "\(results[index].firstName as! String) \(results[index].lastName as! String)"
                        MultipleSelectionRow(title: userName ?? "", isSelected: self.selectedUsers.contains(id)) {
                            if self.selectedUsers.contains( id) {
                                self.selectedUsers.removeAll(where: { $0 == id })
                            }
                            else {
                                self.selectedUsers.append(id)
                            }
                        }
                    }
                }
                
            }.searchable(text: $searchingFor)
        }
        
        
        
        .navigationTitle(navBarTitle == "Add Task" || navBarTitle == "Task" ? "Assignee" : "Users")
        .toolbar{
       
            ToolbarItem(placement: .confirmationAction){
                if navBarTitle == "Project"{
                    Button(action:{ dbProjects.updateProjectMembers(project, members: selectedUsers)
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Save").foregroundColor(Color("blue"))
                        
                    }
                
            }
          }
        }
        
        
    }
    var results : [User] {
        
        if  searchingFor.isEmpty {
            return dbOrgs.orgMembers
        }else {
         //   var userNamer = "\($0.firstName) \($0.lastName)"
            return dbOrgs.orgMembers.filter { ($0.firstName!.contains(searchingFor)) as Bool }
        }
    }

    
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                
                Image(uiImage: imageWith(name: self.title)!).resizable().frame(width: 35, height: 35)
                Text(self.title).foregroundColor(Color("text"))
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}


struct Projects: View {
    @EnvironmentObject var dbProjects: projectDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    @Binding var selectedProject : String
    @Binding var selectedProjectName : String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        List{
               Button(action: {selectedProject = "Personal"
                 selectedProjectName = "Personal"
              }) {
                 HStack {
                   Text("Personal").foregroundColor(Color("text"))
                   if "Personal" == selectedProject {
                     Spacer()
                     Image(systemName: "checkmark")
                  }
                }
              }
               ForEach(dbUsers.projects.indices, id:\.self){ index in
                 if let id = dbUsers.projects[index].id{
                   Button(action: {selectedProject = id
                     selectedProjectName = dbUsers.projects[index].projectName ?? ""
                  }) {
                     HStack {
                       Text(dbUsers.projects[index].projectName ?? "").foregroundColor(Color("text"))
                       if id == selectedProject {
                         Spacer()
                         Image(systemName: "checkmark")
                      }
                    }
                  }
                }
              }
            }
        .navigationBarTitle("Projects",displayMode: .inline)
    }
}



func findProjectName(id: String, projects:[Project]) -> String{
  var name = ""
  if id == "Personal"{
    name = "Personal"
}
  else{
  for project in projects{
    if project.id == id{
      name = project.projectName ?? ""
    }
  }
  }
  return name
}

