import SwiftUI
import SwipeableView
struct MakeMeetingCell: View{
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbProjects: projectDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    @EnvironmentObject var dbOrg: orgDatabaseVM

    var meeting : Meeting
    let date = Date()
    var body: some View{
        let left = [
            Action(title: "Delete".localized, iconName: "trash.fill", bgColor: Color("red"), action: {
                dbMeetings.deleteMeeting(meeting)
            })
        ]
        let right = [
            Action(title: "To Do".localized, iconName: "minus.circle.fill", bgColor: .gray, action: {
                dbMeetings.changeMeetingStatusToToDo(meeting)
            }),
            Action(title: "Done".localized, iconName: "checkmark.circle.fill", bgColor: Color("green"), action: {
                dbMeetings.changeMeetingStatusToDone(meeting)
            })
        ]
        let meetingProjectName = findProjectName(id: meeting.meetingProjectId ?? "", projects: dbProjects.projects)
        SwipeableView(content: {
            NavigationLink(destination: MeetingCard(meeting: meeting, members: meeting.meetingMembers ?? [""], meetingMinutes: meeting.mom ?? [""] ,selectedStatus: meeting.meetingStatus ?? "", meetingDate: meeting.meetingDate ?? Date(),startTime: meeting.meetingStartTime ?? Date(), endTime: meeting.meetingEndTime ?? Date(), meetingTitle: meeting.meetingTitle ?? "", meetingAgenda: meeting.meetingAgenda ?? "", meetingLink: meeting.zoomUrl ?? "", isMeetingLinkVisible: meeting.zoomUrl != "", meetingProject: meeting.meetingProjectId ?? "", meetingRoom: meeting.meetingRoom ?? "" )){
                ZStack{
                    Rectangle()
                        .frame( height: 105)
                        .cornerRadius(8)
                        .foregroundColor(Color("tabBarColor"))
                    HStack{
                        Rectangle()
                            .frame(width: 12, height: 105)
                            .cornerRadius(15)
                            .background(RoundedCornersShape(corners: NSLocale.current.languageCode == "ar" ? [.topRight, .bottomRight] : [.topLeft, .bottomLeft], radius: 15))
                            .foregroundColor(Color("meetingBlue"))
                        VStack(alignment: .leading, spacing: 10){
                            HStack{
                                Image(systemName: "clock").foregroundColor(.gray).font(.system(size: 14))
                                Text("\(meeting.meetingStartTime ?? Date(), style: .time)-\(meeting.meetingEndTime ?? Date(), style: .time)").foregroundColor(Color("text")).font(.system(size: 14))
                            }
                            Text("\(meeting.meetingTitle ?? "")")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color("text"))
                                .multilineTextAlignment(.leading)
                            HStack{
                                if meeting.meetingRoom != ""{
                                    Image(systemName:"mappin.and.ellipse").foregroundColor(.gray).font(.system(size: 14))
                                }
                                Text("\(meeting.meetingRoom ?? "")")
                                    .foregroundColor(Color("text")).font(.system(size: 14)).multilineTextAlignment(.leading)
                            }
                        }
                        Spacer()
                        membersCapsule(meeting.meetingMembers ?? [""], bigArrayOfUsers: dbOrg.orgMembers).padding(.trailing,28)
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
    //   end of function
}
