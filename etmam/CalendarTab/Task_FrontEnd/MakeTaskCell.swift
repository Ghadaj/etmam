import SwiftUI
import SwipeableView
struct MakeTaskCell: View{
    
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM

   // @EnvironmentObject var dbProjects: projectDatabaseVM
    var task : Task
    
    var body: some View{
        let left = [
            Action(title: "Delete".localized, iconName: "trash.fill", bgColor: Color("red"), action: {
                dbTasks.deleteTask(task)
            }) ]
        let right = [
            Action(title: "To Do".localized, iconName: "minus.circle.fill", bgColor: .gray, action: {
                dbTasks.changeTaskStatusToToDo(task)
            }),
            Action(title: "Doing".localized, iconName: "arrow.triangle.2.circlepath.circle.fill", bgColor: Color("orange"), action: {
                dbTasks.changeTaskStatusToDoing(task)
            }),
            Action(title: "Done".localized, iconName: "checkmark.circle.fill", bgColor: Color("green"), action: {
                dbTasks.changeTaskStatusToDone(task)
            })
        ]
        SwipeableView(content: {
            let taskProjectName = findProjectName(id: task.taskProjectId ?? "", projects: dbUsers.projects)
            NavigationLink(destination: TaskCard(task: task,assignee: task.taskMembers ?? [],selectedStatus: task.taskStatus ?? "To Do", isDatePickerVisible: task.taskDeadline != nil, Deadline: task.taskDeadline ?? Date(), taskTitle: task.taskTitle ?? "", taskDesc: task.taskDesc ?? "", taskProject: task.taskProjectId ?? "" , taskProjectName: taskProjectName)){
                ZStack{
                    Rectangle()
                        .frame(height: 105)
                        .cornerRadius(8)
                        .foregroundColor(Color("tabBarColor"))
                    HStack{
                        Rectangle()
                            .frame(width: 12, height: 105)
                            .cornerRadius(15)
                            .background(RoundedCornersShape(corners: NSLocale.current.languageCode == "ar" ? [.topRight, .bottomRight] : [.topLeft, .bottomLeft], radius: 15))
                            .foregroundColor(Color(task.taskColor ?? ""))
                        VStack(alignment: .leading, spacing: 10){
                            Text("\(task.taskTitle ?? "")")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color("text"))
                                .multilineTextAlignment(.leading)
                            Text(taskProjectName.localized).font(.system(size: 15, weight: .regular)).foregroundColor(Color("text"))
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            HStack{
                                statusIcon(status: task.taskStatus ?? "")
                                Text((task.taskStatus ?? "").localized).foregroundColor(Color("blue"))
                            }.padding(.trailing,35)
                            //      if isDeadlineToday{
                            //        Text("\(task.taskDeadline ?? Date(), style: .date)").font(.footnote).foregroundColor(.red).font(.footnote).padding(.trailing,10)
                            //      }else{
                            //        Text(" ").font(.footnote).padding(.trailing,10)
                            //      }
                        }
                    }
                }
            }
        },
                      leftActions: NSLocale.current.languageCode == "ar" ? right : left,
                      rightActions: NSLocale.current.languageCode == "ar" ? left : right,
                      rounded: true
        ).environment(\.layoutDirection, .leftToRight)
        .frame(height: 107)
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
