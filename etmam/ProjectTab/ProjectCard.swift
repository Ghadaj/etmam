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
    
    var project: Project
    @State var projectName = ""
    @State var projectDesc = ""
    @State var members: [String] = []
    @State var Deadline = Date()
    
    @State private var projectNavBarTitle = "Project"
    @State  var circleProgress = [0.0,0.0]
    //private var circlePercentage: Int { Int (circleProgress * 100.0) }
    @State private var textHeight: CGFloat = 100
   
    @State private var showDeleteAlert = false
    @State private var isEditing = false
    
    
 
    
    @State var numOfToDoTasks = 0
    @State var numOfDoingTasks = 0
    @State var numOfDoneTasks = 0
    
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
  
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(spacing: -2){
                HStack {
                    Text(projectName)
                        .font(.title.bold())
                    Spacer()
                    
                }.padding([.top, .leading, .trailing] )
                
                Form{
                    Section{
                   
                        HStack{
                            
                            VStack(spacing: 24){
                                HStack{
                                    statusIcon(status: "To Do")
                                    Text("To Do")
                                    
                                }
                                
                                HStack{
                                    statusIcon(status: "Doing")
                                    Text("Doing")
                                    
                                }
                                
                                HStack{
                                    statusIcon(status: "Done")
                                    Text("Done ")
                                    
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
                                    Text("Completed").font(.footnote)
                                    
                                }
                            }.padding([.leading,.bottom,.top])
                        }
                        HStack{
                            Text("Deadline")
                            
                            
                            DatePicker("",
                                       selection: $Deadline,
                                       displayedComponents: .date).disabled(!isEditing)
                            
                                .accentColor(Color("blue")).background().cornerRadius(8)
                            
                            
                        }
                        
                        
                    }
                    TextField("Title", text: $projectName).disabled(!isEditing)
                    
                    
                    TextView(placeholderText: "Description", text: self.$projectDesc, minHeight: self.textHeight,maxHeight: self.textHeight, calculatedHeight: self.$textHeight)
                        .frame(minHeight: self.textHeight, maxHeight: self.textHeight).disabled(!isEditing)
                    
                    
                    NavigationLink(destination:
                                    CardCell()) {
                        HStack{
                            Image(systemName: "person").foregroundColor(Color("blue"))
                            Text("PM:")
                            Spacer()
                            Image(uiImage: imageWith(name: "Salem Nasser")!).resizable().frame(width:25 , height: 25)
                            Text("Salem Nasser").foregroundColor(.gray)
                        }
                        
                    }
                    
                }.frame(height : 505).onAppear{
                    circleProgress = percentageCalc(id: project.id ?? "", t: dbTasks.tasks, m: dbMeetings.meetings)
                }
                
               
                HStack{
                    NavigationLink(destination: ProjectsTasks(project: project, PName: project.projectName ?? "", PId:project.id ?? "")) {
                        ZStack{
                            VStack(alignment: .center, spacing: 8){
                                Image(systemName: "list.bullet.rectangle.portrait")
                                    .font(Font.system(size: 20, weight: .medium))
                                    .foregroundColor(.white)
                                Text("Tasks")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                Text("\(Int(circleProgress[1]))")
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 110, height: 105)
                        .font(.system(size: 16))
                        .background(Color("orange"))
                        .cornerRadius(8)
                    }
                    NavigationLink(destination: OrgUsers(selectedUsers: $members, navBarTitle: $projectNavBarTitle, project: project)   ) {
                        ZStack{
                            VStack(alignment: .center, spacing: 8){
                                Image(systemName: "person.3.fill")
                                    .foregroundColor(.white)
                                Text("Members")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                Text("\(members.count)")
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 110, height: 105)
                        .font(.system(size: 16))
                        .background(Color("pink"))
                        .cornerRadius(8)
                        
                    }
                    NavigationLink(destination: CardCell()) {
                        ZStack{
                            VStack(alignment: .center, spacing: 8){
                                Image(systemName: "paperclip")
                                    .font(Font.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Files")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                Text("3")
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 110, height: 105)
                        .font(.system(size: 16))
                        .background(Color("blue"))
                        .cornerRadius(8)
                    }
                }.padding()
                Spacer()
                // && project manger
                if isEditing{
                    Button(action: {showDeleteAlert = true }){
                        ZStack{
                            Rectangle().frame(width: 350, height: 55).foregroundColor(Color("tabBarColor")).cornerRadius(8)
                            Text("Delete Project").foregroundColor(.red)
                        }
                    }.alert( isPresented: $showDeleteAlert) {
                        
                        Alert(
                            title: Text("Delete \(projectName) Projcet?"),
                            message: Text(""),
                            primaryButton: .destructive(Text("Delete"), action: {
                                dbProjects.deleteProject(project)
                            }),
                            secondaryButton: .cancel(Text("Cancel"), action: { // 1
                                
                                
                            })
                        )
                        
                    }
                }
                
            }
        }
        .navigationTitle("Project")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: isEditing ? .confirmationAction : .navigationBarTrailing ){
                Button(action: {isEditing.toggle()
                    if !isEditing && projectName == "" {
                        projectName = project.projectName ?? ""
                        dbProjects.updateProjectInfo(project, field: "projectDesc", content: projectDesc)
                        dbProjects.updateProjectDeadline(project, deadline: Deadline)
                       
                    }else if !isEditing{
                        dbProjects.updateProjectInfo(project, field: "projectName", content: projectName)
                        dbProjects.updateProjectInfo(project, field: "projectDesc", content: projectDesc)
                        dbProjects.updateProjectDeadline(project, deadline: Deadline)
                    }
                }){
                    Text(isEditing ? "Done" : "Edit").foregroundColor(Color("blue"))
                    
                }
            }
            
        }
        
    }
    
}


//struct EditProject_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectCard()
//    }
//}

