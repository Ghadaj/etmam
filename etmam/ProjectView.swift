//
//  Project.swift
//  RaghdaP
//
//  Created by raghda on 07/11/1443 AH.
//

import SwiftUI


var projectData = projectDatabaseVM()

struct ProjectView : View{
    //    @EnvironmentObject var dbTasks: taskDatabaseVM
    //    @EnvironmentObject var dbProjects: projectDatabaseVM
    @State private var current_date = Date()
    @State var circleProgress: CGFloat = 0.03
  //  @State var currentProject: Project
    @EnvironmentObject var dbUsers: userDatabaseVM

   // @State
//    @State var projects = [Project]()
//    @State var tasks = [Task]()

    var TasksArray : [String] = [
        "task1", "task1", "task1", "task1"]
    
    var body: some View{
     //   self.loadData()
        ZStack{
            Color("Background").ignoresSafeArea()
            VStack(alignment: .center){
                HStack{
                    Text("Calender")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 40)
                    Spacer()
                }
//                Text(dbUsers.userTasks[0].taskDeadline ?? "no deadline")
//                Text(dbUsers.userProjects[1].projectName ?? "no deadline")
                
                //                بداية كود المربع الي فوق
                              
                HStack{
                    VStack(alignment: .leading, spacing: 20){
                        // description
                      //  Text(currentProject.projectDesc ?? "No Description").font(.system(size: 16))
                        //Total Tasks
//                        Text("Total Tasks: \(dbUsers.userProjects[index].projectTasks)")
//                            .foregroundColor(.white)
//                            .frame(width: 125, height: 25, alignment: .leading)
//                            .font(.system(size: 16))
//                            .padding(.leading, 10)
//                            .background(Color("blue"))
//                            .cornerRadius(4)
//                        //Deadline
                        HStack{
                            Text("Deadline")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                            //01-2-2022
                         //   Text(currentProject.projectDeadline ?? "01/01/2000")
                            
                        }
                        
                    }
                    .padding(.leading)
                    Spacer()
                    ZStack{
                        Circle()
                            .stroke(Color.black, lineWidth: 15)
                            .opacity(0.07)
                            .frame(width: 124, height: 124, alignment: .leading)
                            .padding(.trailing)
                        Circle()
                            .trim(from: 0.0, to: circleProgress )
                            .stroke(Color("green"), lineWidth: 15)
                            .frame(width: 124, height: 124, alignment: .leading)
                            .rotationEffect(Angle(degrees: -90))
                            .padding(.trailing)
                        //fun
                        Text("\(Int(self.circleProgress*100))%")
                            .font(.custom("HelveticaNeue", size: 20.0))
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 198)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.05) ,radius: 8, x: 0, y: 0))
//                .padding(.top, 10)

                //                }
                //                نهاية كود المربع الي فوق
                
                
                //بداية كود Project Manager
                VStack(alignment: .leading){
                    //Project Manager
                    Text("Project Manager")
                        .font(.system(size: 20))
                    Button {
                        print("Button pressed")
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .frame(height: 58)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.05) ,radius: 8, x: 0, y: 0)
                            HStack{
                                Image("profilePic")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                                
                                Text("Project Manager")
                                    .padding(.trailing, 10)
                                    .foregroundColor(.black)
                                
                                Image(systemName: "chevron.right")
                                    .padding(.leading, 70)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    
                }
                //               نهاية كود Project manager
                
                .padding(.top, 40)
                
                
                
                
                //                بداية السيتينق
                VStack(alignment: .leading){
                    Text("Settings")
                        .font(.system(size: 20))
                    HStack(spacing: 7){
                        NavigationLink(destination: TasksProjectView()) {
                            ZStack{
                                VStack(alignment: .center, spacing: 8){
                                    Image(systemName: "list.bullet.rectangle.portrait")
                                        .font(Font.system(size: 20, weight: .medium))
                                        .foregroundColor(.white)
                                    Text("Tasks")
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    Text("\(TasksArray.count)")
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width: 110, height: 105)
                            .font(.system(size: 16))
                            .background(Color("orange"))
                            .cornerRadius(8)
                        }
                        NavigationLink(destination: TasksProjectView()) {
                            ZStack{
                                VStack(alignment: .center, spacing: 8){
                                    Image(systemName: "person.3.fill")
                                        .foregroundColor(.white)
                                    Text("Members")
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    Text("\(TasksArray.count)")
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width: 110, height: 105)
                            .font(.system(size: 16))
                            .background(Color("pink"))
                            .cornerRadius(8)
                        }
                        
                        NavigationLink(destination: TasksProjectView()) {
                            ZStack{
                                VStack(alignment: .center, spacing: 8){
                                    Image(systemName: "paperclip")
                                        .font(Font.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                    Text("Files")
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                    Text("\(TasksArray.count)")
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width: 110, height: 105)
                            .font(.system(size: 16))
                            .background(Color("blue"))
                            .cornerRadius(8)
                        }
                        
                    }
                }
                .padding(.top, 10)
                //                نهاية السيتينق
                
            }
            .padding(.horizontal, 16.0)
            .padding(.top, -200)
        }
    }
    
}
//
//struct loadData: View {
//  //  @Binding var projectID: String
//    func trst(){
//
//    }
//    Text("er")
//  //  let projectDocument = projectData.getProject(projectID)
//    
//}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
