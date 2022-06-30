//
//  AddMeeting.swift
//  calenderSwift
//
//  Created by Danya T on 17/11/1443 AH.
//

import SwiftUI

struct AddMeeting: View {
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    
    @State private var members : [String] = []
    @Binding var selectedDate: Date
    @Binding var showAddSheet: Bool
    @State var isMeetingLinkVisible: Bool = false
    
//    @State var isStartPickerVisible: Bool = false
//    @State var isEndPickerVisible: Bool = false
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
        
        
        
        Form{
            
            Section{
                TextField( "Title", text: $meetingTitle)
                    
                  
                
                TextView(placeholderText: "Meeting Agenda", text: $meetingAgenda,  minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                    
            }
            
            
            Section{
                
                
                
                HStack{
                    
//                    Button(action: {isStartPickerVisible.toggle()}){
                Text("Starts").foregroundColor(.black)
//
//                }
                DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                          .labelsHidden().padding(.horizontal)
                          .accentColor(Color("blue"))
                    
                    Spacer()

                    Image(systemName: "hourglass.tophalf.filled").foregroundColor(Color("blue"))
                    
                
               }
                
                HStack{
                    
//                    Button(action: {isEndPickerVisible.toggle()}){
                    Text("Ends  ").foregroundColor(.black)
//                }
                 
                        DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                            .labelsHidden().padding(.horizontal)
                            .accentColor(Color("blue"))
                    
                    Spacer()
                    Image(systemName: "hourglass.bottomhalf.filled").foregroundColor(Color("blue"))
            }

                
        }
                
                
                Section{
                
                
                NavigationLink(destination:
                    Projects(selectedProject: $meetingProject, selectedProjectName: $meetingProjectName)
                    
                ) {
                    
                    Text("Project: ")
                   
                    Text(meetingProjectName).foregroundColor(.gray)
                    
                }
                
                
                    NavigationLink(destination: OrgUsers ( selectedUsers: $members, navBarTitle: $meetingNavBarTitle)) {
                    

                    HStack{
                        Image(systemName: "person.badge.plus").foregroundColor(Color("blue"))
                            Text("Members: ").foregroundColor(.black)
                                          
                        Text("\(members.count)").foregroundColor(.gray)
                       
                        
                    }
                    
                }
                    
            }
            
            Section{
                
                HStack{
                    Text("Meeting Link")
                    Button(action: {isMeetingLinkVisible.toggle()}){
                        Toggle("", isOn: $isMeetingLinkVisible)
                    }
                }
                
                
                if isMeetingLinkVisible {
                    TextView(placeholderText: "Meeting Link", text: $meetingLink,  minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                        .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                       
                
                }
                HStack{
                    Image(systemName:"mappin.and.ellipse" ).foregroundColor(.gray)
                    TextField( "Meeting Room", text: $meetingRoom)
                }
                
                
                
                HStack{
                    Image(systemName: "paperclip").foregroundColor(.gray)
                    Text("Attachments")
                    Spacer()
                    Image(systemName: "plus").foregroundColor(Color("blue"))
                }
                
            
                
            }
        }
 
        .toolbar{
            ToolbarItem(placement:.confirmationAction){
            
            Button(action:{
                if meetingTitle != "" {
                    dbMeetings.addMeeting(Meeting(meetingTitle: meetingTitle, meetingCreator: "", meetingMembers: members, meetingProjectId: meetingProject, meetingCreatedDate: selectedDate, meetingStartTime: startTime, meetingEndTime: endTime, meetingAttchments: [], meetingRoom: meetingRoom, meetingStatus:"To Do", meetingAgenda: meetingAgenda, mom: [], zoomUrl: meetingLink))
                    
                    
                    showAddSheet = false
                }
                
            }) {
                Text("Add").foregroundColor(meetingTitle == "" ?.gray : Color("blue"))
            }
        }
      }
    
   }
    
}




