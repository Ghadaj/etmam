//
//  AddMeeting.swift
//  calenderSwift
//
//  Created by Danya T on 17/11/1443 AH.
//

import SwiftUI

struct AddMeeting: View {
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    @EnvironmentObject var userVM: userDatabaseVM
    @EnvironmentObject var dbOrg: orgDatabaseVM

    @State private var members : [String] = []
    @State var selectedDate: Date = Date()
    @Binding var showAddSheet: Bool
    @State var isMeetingLinkVisible: Bool = false
    

    @State var startTime = Date()
    @State var endTime = Date()
    @State var meetingNavBarTitle = "Add Meeting"
    @State var meetingTitle = ""
    @State var meetingAgenda = ""
    @State var meetingLink = ""
    @Binding var meetingProject : String
    @State var meetingRoom = ""
    @Binding var meetingProjectName : String
    @State private var textHeight: CGFloat = 40
    @State private var maxTextHeight: CGFloat = 10000000
    let columns = Array(repeating: GridItem(.flexible(minimum: 1, maximum: 1), spacing: 35), count: 5)
    
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        let y = dbOrg.getMembers()

        
        Form{
            
            Section{
                TextField( "Title".localized, text: $meetingTitle)
                    
                  
                
                TextView(placeholderText: "Meeting Agenda".localized, text: $meetingAgenda,  minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                    
            }
            
            
            Section{
                
                
                
                HStack{
                    
                    Image(systemName: "hourglass.tophalf.filled").foregroundColor(Color("blue"))
                    Text("Starts At ".localized)

                DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                          .labelsHidden().padding(.horizontal)
                          .accentColor(Color("blue"))
                    
                    Spacer()

                  
                    
                
               }
                
                HStack{
                    
                    Image(systemName: "hourglass.bottomhalf.filled").foregroundColor(Color("blue"))
                    Text("Ends At   ".localized)

                 
                        DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                            .labelsHidden().padding(.horizontal)
                            .accentColor(Color("blue"))

            }
                    HStack{
                        Image(systemName: "calendar").foregroundColor(Color("blue"))
                        Text("Date     ".localized)
                        DatePicker("",
                                   selection: $selectedDate,
                                   displayedComponents: .date)
                        .padding(.horizontal)
                        .accentColor(Color("blue"))
                        Spacer().padding()
                        
                    }
                

                
        }
                
                
                Section{
                
                
                NavigationLink(destination:
                    Projects(selectedProject: $meetingProject, selectedProjectName: $meetingProjectName)
                    
                ) {
                    
                    HStack{
                    Image(systemName: "align.vertical.top.fill").foregroundColor(Color("blue"))
                    Text("Project: ".localized)
                   
                    Text(meetingProjectName.localized).foregroundColor(.gray)
                    
                }
                }
                
                
                    NavigationLink(destination: OrgUsers ( selectedUsers: $members, navBarTitle: $meetingNavBarTitle)) {
                    

                    HStack{
                        Image(systemName: "person.fill.badge.plus").foregroundColor(Color("blue"))
                        Text("Users: ".localized)
                                          
                        membersCapsule(members, bigArrayOfUsers: dbOrg.orgMembers).padding(.bottom,-50)
                       
                        
                    }
                    
                }
                    
            }
            
            Section{
                
                HStack{
                    Image(systemName: "link").foregroundColor(Color("blue"))
                    Toggle("Meeting Link".localized, isOn: $isMeetingLinkVisible)
                }
                
                
                
                if isMeetingLinkVisible {
                    TextView(placeholderText: "Meeting Link".localized, text: $meetingLink,  minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                        .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                       
                
                }
                HStack{
                    Image(systemName:"mappin.and.ellipse" ).foregroundColor(.gray)
                    TextField( "Meeting Room".localized, text: $meetingRoom)
                }
                
                
                
                HStack{
                    Image(systemName: "paperclip").foregroundColor(Color("blue"))
                    Text("Attachments".localized)
                    Spacer()
                    Image(systemName: "plus").foregroundColor(Color("gray"))
                }
                
            
                
            }
        }
 
        .toolbar{
            ToolbarItem(placement:.confirmationAction){
            
            Button(action:{
                if meetingTitle != "" {
                    dbMeetings.addMeeting(Meeting(meetingTitle: meetingTitle, meetingCreator: dbUsers.currentUserID, meetingMembers: members, meetingProjectId: meetingProject, meetingDate: selectedDate, meetingStartTime: startTime, meetingEndTime: endTime, meetingAttchments: [], meetingRoom: meetingRoom, meetingStatus:"To Do", meetingAgenda: meetingAgenda, mom: [], zoomUrl: meetingLink, meetingOrgID: userVM.currentOrgID))
                    
                    
                    showAddSheet = false
                }
                
            }) {
                Text("Add").foregroundColor(meetingTitle == "" ?.gray : Color("blue"))
            }
        }
      }
    
   }
    
}




