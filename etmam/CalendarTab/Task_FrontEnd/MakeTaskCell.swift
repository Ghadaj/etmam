//
//  SwiftUIView.swift
//  calenderSwift
//
//  Created by Danya T on 07/11/1443 AH.
//
import SwiftUI
 import SwipeableView

struct MakeTaskCell: View{
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbProjects: projectDatabaseVM
    
    var task : Task
    var isDeadlineToday =  false
   
    var body: some View{

    SwipeableView(content: {
        let taskProjectName = findProjectName(id: task.taskProjectId ?? "", projects: dbProjects.projects)
        NavigationLink(destination: TaskCard(task: task,assignee: task.taskMembers ?? [],selectedStatus: task.taskStatus ?? "To Do", isDatePickerVisible: task.taskDeadline != nil, Deadline: task.taskDeadline ?? Date() ,  taskTitle: task.taskTitle ?? "", taskDesc: task.taskDesc ?? "", taskProject: task.taskProjectId ?? "" , taskProjectName: taskProjectName)){
    ZStack{
      Rectangle()
        .frame(width: 344, height: 105)
        .cornerRadius(8)
        .foregroundColor(Color("tabBarColor"))
      HStack{
        Rectangle()
          .frame(width: 12, height: 105)
          .cornerRadius(15)
          .background(RoundedCornersShape(corners: [.topLeft, .bottomLeft], radius: 15))
          .foregroundColor(Color(task.taskColor ?? ""))
        
          
        VStack(alignment: .leading, spacing: 10){
           
            Text("\(task.taskTitle ?? "")")
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(Color("text"))
            .multilineTextAlignment(.leading)
          Text(taskProjectName)
                .font(.system(size: 15, weight: .regular)).foregroundColor(Color("text"))
            .multilineTextAlignment(.leading)
        }
  
        Spacer()
        VStack(alignment: .leading) {

            HStack{
                
      statusIcon(status: task.taskStatus ?? "")
      
                Text(task.taskStatus ?? "").foregroundColor(Color("text"))
               
                
                
            
         }.padding(.trailing,35)
            if isDeadlineToday{
                Text("\(task.taskDeadline ?? Date(), style: .date)").font(.footnote).foregroundColor(.red).font(.footnote).padding(.trailing,10)
            }else{
                Text(" ").font(.footnote).padding(.trailing,10)
            }
        }
      }
    }.padding([.horizontal])
    }
   },
           leftActions:[
            Action(title: "Delete", iconName: "trash.fill", bgColor: .red, action: {
               
                dbTasks.deleteTask(task)
               
            })
           ],
           rightActions: [
            Action(title: "To Do", iconName: "minus.circle.fill", bgColor: .gray, action: {
                // task.taskStatus = changeToDoStatus(stat:  task.taskStatus ?? "")
                dbTasks.changeTaskStatusToToDo(task)
            }),
            Action(title: "Doing", iconName: "arrow.triangle.2.circlepath.circle.fill", bgColor: .orange, action: {
                //task.taskStatus = changeInProgressStatus(stat:  task.taskStatus ?? "")
                dbTasks.changeTaskStatusToDoing(task)
            }),
            Action(title: "Done", iconName: "checkmark.circle.fill", bgColor: .green, action: {
               // task.taskStatus = changeCompletedStatus(stat:  task.taskStatus ?? "")
                dbTasks.changeTaskStatusToDone(task)
              
            })
           ],
           rounded: true
    ).frame(height: 107)
 
    }
    // end of function
}


    //end of struct


func statusIcon(status:String) -> some View {
    var statusIcon = "minus.circle.fill"
    var statusIconColor : Color = .gray
    
    if status == "Doing"{
        statusIcon = "arrow.triangle.2.circlepath.circle.fill"
         statusIconColor = .orange
    }
    if status == "Done"{
        statusIcon = "checkmark.circle.fill"
        statusIconColor = .green
    }
 return Image(systemName: statusIcon).resizable()
                     .frame(width: 15, height:15).foregroundColor(statusIconColor)
    
    
}

  

func changeToDoStatus (stat : String) -> String {
  var status = stat
  if status == "Doing" || status == "Done" {
    status = "To Do"
  }
   
  return status
}
func changeInProgressStatus (stat : String) -> String {
  var status = stat
  if status == "To Do" || status == "Done" {
    status = "Doing"
  }
  return status
}
func changeCompletedStatus (stat : String) -> String {
  var status = stat
  if status == "Doing" || status == "To Do" {
    status = "Done"
  }
  return status
}
struct RoundedCornersShape: Shape {
  let corners: UIRectCorner
  let radius: CGFloat
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}



 

