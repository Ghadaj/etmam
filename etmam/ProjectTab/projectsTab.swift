//
//  projectsTab.swift
//  calenderSwift
//
//  Created by Danya T on 24/11/1443 AH.
//

import SwiftUI

struct projectsTab: View {
    // var project : Project
//    @EnvironmentObject var dbProjects: projectDatabaseVM
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    @EnvironmentObject var dbOrg: orgDatabaseVM

    @State var totalForAll = 0
    @State  var barProgress: Double = 0.0
    private var barPercentage: Int { Int (barProgress * 100.0) }
    
    @State var showCreateSheet = false
    @State var text = ""
    @State private var isEditing = false
    let columns : [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment:nil),
        GridItem(.flexible(), spacing: nil, alignment:nil)
      ]
    var body: some View {
        
          ZStack{
           Color("BackgroundColor")
              .ignoresSafeArea()
            ScrollView{
              VStack {
                HStack {
                    Text("Projects".localized)
                    .font(.largeTitle.bold())
                  Spacer()
                  NavigationLink {
                    UserProfile()
                  } label: {
                    Image(systemName: "person.crop.circle")
                      .font(.largeTitle)
                      .foregroundColor(Color("blue"))
                  }
                }
                SearchBar(text: $text)
                Spacer()
                LazyVGrid(columns: columns, alignment: .center, spacing: 0){
                  Button{
                      showCreateSheet.toggle()
                  } label:{
                    ZStack{
                      Rectangle()
                        .foregroundColor(Color("tabBarColor"))
                        .frame(height: 186)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.15) ,radius: 4, x: 0, y: 1)
                      VStack{
                        Image(systemName: "plus")
                          .foregroundColor(Color("blue"))
                          .frame(width:32,height: 36)
                          Text("Create Project".localized)
                          .foregroundColor(Color("blue"))
                      }
                    }
                  }
                  .sheet(isPresented: $showCreateSheet) {
                    print("onDismiss")
                  } content: {
                    CreateProject(showCreateSheet: $showCreateSheet)
                  }
                    ForEach(dbUsers.projects.filter({($0.projectName?.lowercased().contains(text.lowercased()))! || text.isEmpty})){ p in
                    
                        makeProjectCell(p)
                    
                  }
                  }
              } .padding()
            }
           
            .navigationBarHidden(true)
          }
        
      }
    

        
   
    
    
    
    
    func makeProjectCell(_ p : Project) -> some View{
     
      
        
        NavigationLink(destination: ProjectCard(project: p, projectName: p.projectName ?? "", projectAttachments: p.projectAttachments ?? [""], projectDesc: p.projectDesc ?? "", members: p.projectMembers ?? [], Deadline: p.projectDeadline ?? Date() )){
          ZStack{
        Rectangle()
          .foregroundColor(Color("tabBarColor"))
          .frame( height: 186)
          .cornerRadius(8)
          .shadow(color: .black.opacity(0.15) ,radius: 4, x: -3, y: 0)
        VStack(alignment: .leading){
          VStack(alignment: .leading, spacing: 15){
            Text(p.projectName ?? "")
              .padding(.leading)
              .lineLimit(2)
              .font(.system(size: 16, weight: .semibold))
              .foregroundColor(Color("text"))
              .multilineTextAlignment(.leading)
            Text(p.projectDesc ?? "")
              .padding(.leading)
              .font(.system(size: 12, weight: .regular))
              .multilineTextAlignment(.leading)
              .lineSpacing(5)
              .lineLimit(2)
              .foregroundColor(.gray)
          }.padding(.top,20)
          Spacer()
          Spacer()
            membersCapsule(p.projectMembers ?? [""], bigArrayOfUsers: dbOrg.orgMembers).padding(.bottom, 5)
        }
        .padding(.trailing,45)
        ZStack{
          Rectangle().frame(height: 39).cornerRadius(8)
            .background(RoundedCornersShape(corners: [.bottomLeft, .bottomRight], radius: 15))
            .foregroundColor(Color(p.projectColor ?? "pink"))
          VStack(spacing : 0.8){
              let percentageAndTotal = percentageCalc(id: p.id ?? "", t: dbTasks.tasks, m: dbMeetings.meetings)
            HStack{
              Spacer()
               
                    Text("\(Int((percentageAndTotal[0])*100))%").font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
              
                  
            }.padding([.top, .leading, .trailing])
             
              ProgressView(value: percentageAndTotal[0])
                      .accentColor(.white)
                      .padding([.bottom,.horizontal])

          
              
          }
        }
        .padding(.top, 146)
      }
    }
}
    
    
    
    
    


    
}


struct SearchBar : View {
  @Binding var text : String
  @State private var isEditing = false
  var body: some View{
    HStack{
        TextField("Search".localized, text: $text)
        .padding(5)
        .padding(.horizontal,35)
        .background(Color("tabBarColor"))
        .foregroundColor(.black)
        .cornerRadius(8)
        .overlay(
          HStack{
            Image(systemName: "magnifyingglass")
              .foregroundColor(.gray)
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
              .padding(.leading,15)
            if isEditing {
              Button(action: {
                self.text = ""
              }, label: {
                Image(systemName: "multiply.circle.fill")
                  .foregroundColor(.gray)
                  .padding(.trailing,8)
              })
            }
          }).onTapGesture {
            self.isEditing = true
          }
      if isEditing{
        Button(action: {
          self.isEditing = false
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }) {
            Text("Cancel".localized)
        }
        .padding(.trailing,10)
        .transition(.move(edge:.trailing))
        .animation(.default)
      }
    }
  }
}









func membersCapsule(_ mem : [String],  bigArrayOfUsers : [User]) -> some View{
  ZStack{
    Capsule()
          .fill(mem.isEmpty ? .clear : Color("capsule"))
      .frame(width: 78, height: 25)
    HStack{
      let members = numOfUsers(users: mem,  bigArrayOfUsers :  bigArrayOfUsers)
      HStack(spacing:-5){
        ForEach(members, id: \.self) { x in
          Image(uiImage: imageWith(name: x)!).resizable().frame(width: 19, height: 19).overlay(Circle().stroke(Color.white, lineWidth: 0.7))
        }
      }
      if ( mem.count > 3){
        HStack{
          Text("+\(mem.count-3)")
            .font(.system(size: 10, weight: .regular))
            .multilineTextAlignment(.trailing).foregroundColor(Color("blue"))
        }
      }
    }
  }
  .padding(.bottom,50)
  .padding(.leading)
}



func numOfUsers(users : [String] , bigArrayOfUsers : [User]) -> [String]{
    var newUsers : [String] = []

    
    for user in users {
        for allUser in bigArrayOfUsers{
            if user == allUser.id{
                var userName = "\(allUser.firstName!) \(allUser.lastName!)"
                newUsers.append(userName ?? "")
                break
        }
        
    }
            if newUsers.count == 3{
                break
            }
    
  
}
   return newUsers
}





func percentageCalc(id:String, t:[Task], m:[Meeting])-> [Double] {
    var per = 0.0
    let doneT = DoneTasks(id: id,t:t ).count
    let doneM = DoneMeetings(id: id,m:m).count
    let totalForAll = (doneT + toDoTasks(id: id, t :t).count + toDoMeetings(id: id ,m:m).count + DoingTasks(id: id,t:t ).count + doneM)
    if totalForAll != 0{
        per = Double(doneT + doneM) / Double(totalForAll)
    }
    return [per,Double(totalForAll)]
}

func toDoMeetings(id : String, m: [Meeting]) -> [Meeting]{
  
    var toDoMeetingsArray : [Meeting] = []
    

    for meeting in m{
        if meeting.meetingProjectId == id && meeting.meetingStatus == "To Do" {
            toDoMeetingsArray.append(meeting)
        }
        
    }
    
    return toDoMeetingsArray
}
    




func DoneMeetings(id : String, m:[Meeting]) -> [Meeting]{
    var DoneMeetingsArray : [Meeting] = []
    
    
    for meeting in m{
        if meeting.meetingProjectId == id && meeting.meetingStatus == "Done" {
            DoneMeetingsArray.append(meeting)
        }
        
    }
    
    return DoneMeetingsArray
}
    


func toDoTasks(id : String, t:[Task]) -> [Task]{
  
    var toDoTaskArray : [Task] = []
   
    
    for task in t{
        if task.taskProjectId == id && task.taskStatus == "To Do" {
            toDoTaskArray.append(task)
        }
        
    }
    return toDoTaskArray
 }




func DoingTasks(id : String, t:[Task]) -> [Task]{
   
    var DoingTaskArray : [Task] = []
   
    
    for task in t{
        if task.taskProjectId == id && task.taskStatus == "Doing" {
            DoingTaskArray.append(task)
        }
        
    }
    return DoingTaskArray
 }

func DoneTasks(id : String, t:[Task]) -> [Task]{
    
    var DoneTaskArray : [Task] = []
   
    
    for task in t{
        if task.taskProjectId == id && task.taskStatus == "Done" {
            DoneTaskArray.append(task)
        }
        
    }
    return DoneTaskArray
 }
