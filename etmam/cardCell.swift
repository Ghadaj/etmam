//
//  cardCell.swift
//  calenderSwift
//
//  Created by Danya T on 22/11/1443 AH.
//

import SwiftUI
 import SwipeableView

struct CardCell: View {
    struct TasksTest : Identifiable{
      var id: Int
      var name : String
      var project : String
      var status : String
      var color : String
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
    @State var testToggle = false
    @State var todayTask: [TasksTest] = [TasksTest(id: 1, name: "Test 1", project: "CSC", status: "To Do", color: "green"),TasksTest(id: 2, name: "play card", project: "Dunno", status: "To Do", color: "pink"),TasksTest(id: 3, name: "Ask", project: "Test", status: "Doing", color: "orange"),TasksTest(id: 4, name: "play card", project: "Dunno", status: "Doing", color: "blue"),TasksTest(id: 5, name: "play card", project: "Dunno", status: "Done", color: "pink"),TasksTest(id: 6, name: "play card", project: "Dunno", status: "Done", color: "orange")]
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
        VStack{
            Button(action:{testToggle.toggle()}){
                Text("press")
            }
            
        ForEach(todayTask.indices, id: \.self) { index in
            if todayTask[index].status == "Done" || testToggle {
                  SwipeableView(content: {
                      makeTaskCellView(task: todayTask[index])
                      
                 
        
                  },
                         leftActions:[
                          Action(title: "Delete", iconName: "trash.fill", bgColor: .red, action: {
                            
                            todayTask.remove(at: index)
                              return test(task:todayTask[index])
                            
                          })
                         ],
                         rightActions: [
                          Action(title: "To Do", iconName: "minus.circle.fill", bgColor: .gray, action: {
                            todayTask[index].status = changeToDoStatus(stat: todayTask[index].status)
                          }),
                          Action(title: "Doing", iconName: "arrow.triangle.2.circlepath.circle.fill", bgColor: .orange, action: {todayTask[index].status = changeInProgressStatus(stat: todayTask[index].status)}),
                          Action(title: "Done", iconName: "checkmark.circle.fill", bgColor: .green, action: {todayTask[index].status = changeCompletedStatus(stat: todayTask[index].status)})
                         ],
                         rounded: true
                  ).frame(height: 107)
                  }
        }
        }
        .padding(.leading, 8)

        }
      

    }
   
    func test(task:TasksTest){
        var x = 4
        print(x)
    }
func makeTaskCellView(task: TasksTest) -> some View{
    
    ZStack{
      Rectangle()
        .frame(width: 344, height: 105)
        .cornerRadius(8)
        .foregroundColor(.white)
      HStack{
        Rectangle()
          .frame(width: 12, height: 105)
          .cornerRadius(15)
          .background(RoundedCornersShape(corners: [.topLeft, .bottomLeft], radius: 15))
          .foregroundColor(Color(task.color))
         
        VStack(alignment: .leading, spacing: 10){
           
          Text("\(task.name)")
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
          Text("\(task.project)")
            .font(.system(size: 15, weight: .regular))
            .multilineTextAlignment(.leading)
        }
  
        Spacer()
        VStack(alignment: .leading) {

            HStack{
                
      statusIcon(status: task.status)
      
                Text(task.status)
             
               
                
                
            
         }.padding(.trailing,60)
           
//            if 1==2{
//                Text("\(Date(), style: .date)").foregroundColor(.red).font(.footnote)
//            }else{
//                Spacer().frame(height: 23)
//            }
            
        }
      }
    }
    .padding([.horizontal])
  
 
    
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
        statusIcon = "arrow.triangle.2.circlepath.circle.fill"
        statusIconColor = .green
    }
 return Image(systemName: statusIcon).resizable()
                     .frame(width: 15, height:15).foregroundColor(statusIconColor)
    
    
}


}
struct cardCell_Previews: PreviewProvider {
    static var previews: some View {
        CardCell()
    }
}


    
