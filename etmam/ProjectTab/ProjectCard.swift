//
//  EditProject.swift
//  calenderSwift
//
//  Created by Danya T on 26/11/1443 AH.
//

import SwiftUI


struct ProjectCard: View {
    
    @EnvironmentObject var dbProjects: projectDatabaseVM
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    @EnvironmentObject var dbOrg: orgDatabaseVM

    var project: Project
    @State var projectName = ""
    @State var projectAttachments : [String]
    @State var projectDesc = ""
    @State var projectManager = ""
    @State var members: [String] = []
    @State var Deadline = Date()
    
    @State private var projectNavBarTitle = "Project"
    @State  var circleProgress = [0.0,0.0]
    //private var circlePercentage: Int { Int (circleProgress * 100.0) }
    @State private var textHeight: CGFloat = 100
    
    @State private var showDeleteAlert = false
    @State private var isEditing = false
    
    @State var firstName = ""
    @State var lastName = ""
    @State var user = User(firstName: "nil", lastName: "nil", userJobTitle: "nil", userPhone: "nil", userEmail: "nil", userPermession: 5, userProjects: ["nil"], userTasks: ["nil"], userMeetings: ["nil"], userImage: "nil", userLineManger: "nil", userOrg: "nil")
    
    
    
    @State var numOfToDoTasks = 0
    @State var numOfDoingTasks = 0
    @State var numOfDoneTasks = 0
    @State var showStack = false
    func getLM(){
        dbUsers.getUserName2(id: project.projectManager!){
         (success) -> Void in
             if success {
                 getUser()
                 firstName = dbUsers.firstName
                 lastName = dbUsers.lastName
}
    }}
    
    
    func getUser(){
        dbUsers.getUser2(userID: project.projectManager!){
         (success) -> Void in
             if success {
                 showStack = true
                 user = dbUsers.user

}
    }}
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
      let x =  getLM()
        let y = dbOrg.getMembers()

        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(spacing: -2){
                HStack {
                    Text(projectName)
                        .font(.title.bold())
                    Spacer()
                    
                }.padding([.top, .leading, .trailing] )
                
                Form {
                    Section{
                        
                        HStack{
                            
                            VStack(spacing: 24){
                                HStack{
                                    statusIcon(status: "To Do")
                                    Text("To Do".localized)
                                    
                                }
                                
                                HStack{
                                    statusIcon(status: "Doing")
                                    Text("Doing".localized)
                                    
                                }
                                
                                HStack{
                                    statusIcon(status: "Done")
                                    Text("Done ".localized)
                                    
                                }
                            }
                            VStack(spacing: 24){
                                Text("\(toDoMeetings(id:project.id ?? "", m:dbMeetings.meetings).count + toDoTasks(id: project.id ?? "", t: dbTasks.tasks).count)  ")
                                Text("\(DoingTasks(id: project.id ?? "", t: dbTasks.tasks).count)  ")
                                Text("\(DoneMeetings(id:project.id ?? "", m:dbMeetings.meetings).count + DoneTasks(id: project.id ?? "", t: dbTasks.tasks).count)  ")
                            }
                            
                            ZStack{
                                Circle().stroke(Color("gray"),
                                                style: StrokeStyle(lineWidth: 18,
                                                                   lineCap: CGLineCap.round)).frame(height: 130)
                                Circle()
                                    .trim(from: 0, to: circleProgress[0])
                                    .stroke(Color.green,
                                            style: StrokeStyle(lineWidth: 18,
                                                               lineCap: CGLineCap.round))
                                    . frame(height: 130)
                                    .rotationEffect(.degrees(-90)) // Start from top
                                
                                
                                
                                
                                VStack{
                                    Text(" \(Int(circleProgress[0]*100))%")
                                    
                                        .font(.title)
                                        .multilineTextAlignment(.center)
                                    Text("Completed".localized).font(.footnote)
                                    
                                }
                            }.padding([.leading,.bottom,.top])
                        }
                        HStack{
                            Text("Deadline".localized)
                            
                            
                            DatePicker("",
                                       selection: $Deadline,
                                       displayedComponents: .date).disabled(!isEditing)
                            
                                .accentColor(Color("blue"))
                            
                            
                        }
                        
                        
                    }
                    TextField("Title".localized, text: $projectName).disabled(!isEditing)
                    
                    
                    TextView(placeholderText: "Description".localized, text: self.$projectDesc, minHeight: self.textHeight,maxHeight: self.textHeight, calculatedHeight: self.$textHeight)
                        .frame(minHeight: self.textHeight, maxHeight: self.textHeight).disabled(!isEditing)
                    
                 //   var userPM = dbUsers.getUser(userID: project.projectManager ?? "")
                    if showStack {
                    NavigationLink(destination:
                                    OtherUsersProfile(user: user )
                    ) {
                        HStack{
                            Image(systemName: "person.fill").foregroundColor(Color("blue"))
                            Text("PM:".localized)
                            Spacer()
                            Image(uiImage: imageWith(name: "\(firstName) \(lastName)")!).resizable().frame(width:25 , height: 25)
                            Text("\(firstName) \(lastName)").foregroundColor(.gray)
                        }
                        
                    }}
                    
                }.frame(height : 505).onAppear{
                    circleProgress = percentageCalc(id: project.id ?? "", t: dbTasks.tasks, m: dbMeetings.meetings)
                }
                
                
                VStack{
                    HStack{
                        NavigationLink(destination: ProjectsTasks(project: project, PName: project.projectName ?? "", PId:project.id ?? "")) {
                            ZStack{
                                Rectangle().frame( height: 105).foregroundColor(Color("orange")).cornerRadius(8)
                                VStack(alignment: .center, spacing: 8){
                                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                                        .font(Font.system(size: 20, weight: .medium))
                                        .foregroundColor(.white)
                                    Text("Tasks".localized)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    Text("\(Int(circleProgress[1]))")
                                        .foregroundColor(.white)
                                }
                            }
                            
                            .font(.system(size: 16))
                            
                            
                            
                        }
                        NavigationLink(destination: OrgUsers(selectedUsers: $members, navBarTitle: $projectNavBarTitle, project: project)   ) {
                            ZStack{
                                Rectangle().frame( height: 105).foregroundColor(Color("pink")).cornerRadius(8)
                                VStack(alignment: .center, spacing: 8){
                                    Image(systemName: "person.3.fill")
                                        .foregroundColor(.white)
                                    Text("Users".localized)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    Text("\(members.count)")
                                        .foregroundColor(.white)
                                }
                            }
                            
                            .font(.system(size: 16))
                            
                            
                            
                        }
//                        NavigationLink(destination: ProjectFilesView(filesUrls: [], newUrls: [], projectID: project.id!)) {
                        NavigationLink(destination: ProjectFilesView(filesUrls: $projectAttachments )) {
                        
                            ZStack{
                                Rectangle().frame( height: 105).foregroundColor(Color("blue")).cornerRadius(8)
                                VStack(alignment: .center, spacing: 8){
                                    Image(systemName: "paperclip")
                                        .font(Font.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                    Text("Files".localized)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    Text("\(0)")
                                        .foregroundColor(.white)
                                }
                            }
                            
                            .font(.system(size: 16))
                            
                            
                        }
                    }
                    Spacer()
                    // && project manger
                    if isEditing{
                        Button(action: {showDeleteAlert = true }){
                            ZStack{
                                Rectangle().frame(height: 55).foregroundColor(Color("red")).cornerRadius(8)
                                Text("Delete Project").foregroundColor(.white)
                            }
                        }.alert( isPresented: $showDeleteAlert) {
                            
                            Alert(
                                title: Text("Delete \(projectName) Project?"),
                                message: Text(""),
                                primaryButton: .destructive(Text("Delete"), action: {
                                    dbProjects.deleteProject(project)
                                }),
                                secondaryButton: .cancel(Text("Cancel"), action: { // 1
                                    
                                    
                                })
                            )
                            
                        }
                    }
                }.padding()
            }
        }
        .navigationTitle("Project".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: isEditing ? .confirmationAction : .navigationBarTrailing ){
                Button(action: {isEditing.toggle()
                    if !isEditing && projectName == "" {
                        projectName = project.projectName ?? ""
                        dbProjects.updateProjectInfo(project, field: "projectDesc", content: projectDesc)
                        dbProjects.updateProjectDeadline(project, deadline: Deadline)
                        dbProjects.updateProjectAttachments(project, attachments: projectAttachments)

                        
                    }else if !isEditing{
                        dbProjects.updateProjectInfo(project, field: "projectName", content: projectName)
                        dbProjects.updateProjectInfo(project, field: "projectDesc", content: projectDesc)
                        dbProjects.updateProjectDeadline(project, deadline: Deadline)
                        dbProjects.updateProjectAttachments(project, attachments: projectAttachments)

                    }
                }){
                    Text(isEditing ? " Done".localized : "Edit".localized).foregroundColor(Color("blue"))
                    
                }
            }
            
        }
        
    }
    
}


