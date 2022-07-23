//
//  MakeMeetingCell2.swift
//  calenderSwift
//
//  Created by Danya T on 29/11/1443 AH.
//


import SwiftUI
import SwipeableView

struct MakeMeetingCell2: View{
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbProjects: projectDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    @EnvironmentObject var dbOrg: orgDatabaseVM

    var meeting : Meeting
    let date = Date()
    
    
  
    var body: some View{
        let meetingProjectName = findProjectName(id: meeting.meetingProjectId ?? "", projects: dbProjects.projects)
    SwipeableView(content: {

        NavigationLink(destination: MeetingCard(meeting: meeting, members: meeting.meetingMembers ?? [""], meetingMinutes: meeting.mom ?? [""] ,selectedStatus: meeting.meetingStatus ?? "", startTime: meeting.meetingStartTime ?? Date(), endTime: meeting.meetingEndTime ?? Date(), meetingTitle: meeting.meetingTitle ?? "", meetingAgenda: meeting.meetingAgenda ?? "", meetingLink: meeting.zoomUrl ?? "", isMeetingLinkVisible: meeting.zoomUrl != "", meetingProject: meeting.meetingProjectId ?? "", meetingRoom: meeting.meetingRoom ?? "" , meetingProjectName: meetingProjectName)){
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
          .foregroundColor(Color("tabBarColor"))


        VStack(alignment: .leading, spacing: 10){
            HStack{
                Image(systemName: "clock").foregroundColor(.gray)

                Text("\(meeting.meetingStartTime ?? Date(), style: .time)-\(meeting.meetingEndTime ?? Date(), style: .time)").foregroundColor(Color("text"))
            }
            
            Text("\(meeting.meetingTitle ?? "")")
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            HStack{
                if meeting.meetingRoom != ""{
                    Image(systemName:"mappin.and.ellipse").foregroundColor(.gray)
                    
                }
            Text("\(meeting.meetingRoom ?? "")")
                .font(.system(size: 15, weight: .regular)).foregroundColor(Color("text"))
            .multilineTextAlignment(.leading)
                
               
                
            }
           
        }

        Spacer()
        
              
          membersCapsule(meeting.meetingMembers ?? [""], bigArrayOfUsers: dbOrg.orgMembers).padding()
          Spacer().frame(width: 30)
      }
        
    }
    }
   },
           leftActions:[
            Action(title: "Delete", iconName: "trash.fill", bgColor: .red, action: {

                dbMeetings.deleteMeeting(meeting)

            })
           ],
           rightActions: [
            Action(title: "To Do", iconName: "minus.circle.fill", bgColor: .gray, action: {
                
                dbMeetings.changeMeetingStatusToToDo(meeting)
            }),
         
            Action(title: "Done", iconName: "checkmark.circle.fill", bgColor: .green, action: {
                dbMeetings.changeMeetingStatusToDone(meeting)
            })
           ],
           rounded: true
    ).frame(height: 107)

    }
//     end of function
}



