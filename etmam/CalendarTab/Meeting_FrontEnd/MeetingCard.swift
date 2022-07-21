//
//  MeetingCard.swift
//  calenderSwift
//
//  Created by Danya T on 19/11/1443 AH.
//

import SwiftUI
import Foundation




struct MeetingCard: View {
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    @EnvironmentObject var dbOrg: orgDatabaseVM

   var meeting: Meeting
    @State var members : [String] = [""]
    @State var meetingMinutes : [String] = [""]
    @State var status = ["To Do","Done"]
    @State var selectedStatus = ""
    @State private var meetingMinuteArrayCheck = false
    @State var meetingDate = Date()
    
    @State var startTime = Date()
    @State var endTime = Date()
    @State private var meetingNavBarTitle = "Meeting"
    @State var meetingTitle = "Inverstors interview"
    @State var meetingAgenda = ""
    @State var meetingLink = ""
    @State var isMeetingLinkVisible: Bool = false
    @State var meetingProject = ""
    @State var meetingRoom = ""
    @State var meetingProjectName = ""
    @State var meetingCreator = ""
    @State private var textHeight: CGFloat = 40
    @State private var maxTextHeight: CGFloat = 10000000
    @State var firstName = ""
    @State var lastName = ""
    @State var user = User(firstName: "nil", lastName: "nil", userJobTitle: "nil", userPhone: "nil", userEmail: "nil", userPermession: 5, userProjects: ["nil"], userTasks: ["nil"], userMeetings: ["nil"], userImage: "nil", userLineManger: "nil", userOrg: "nil")
    let columns = Array(repeating: GridItem(.flexible(minimum: 1, maximum: 1), spacing: 35), count: 5)
    @State var showStack = false
    func getLM(){
            dbUsers.getUserName2(id: meeting.meetingCreator!){
         (success) -> Void in
             if success {
                 getUser()
                 firstName = dbUsers.firstName
                 lastName = dbUsers.lastName
        }}}
    
    
    func getUser(){
        dbUsers.getUser2(userID: meeting.meetingCreator!){
         (success) -> Void in
             if success {
                 showStack = true
                 user = dbUsers.user
}
    }}

    
    func getProjectName(projectId: String) -> String{
       return dbUsers.projects.first(where: { $0.id == projectId})?.projectName ?? "Personal"
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    
    
    
    var body: some View {
        let y = dbOrg.getMembers()

        let x = getLM()
        
        Form{
            
            
            
            Section{
                
                TextField( "Title".localized, text: $meetingTitle)
                
                
                
                TextView(placeholderText: "Meeting Agenda".localized, text: $meetingAgenda,minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
    
            }
            
            
            Section{
                
                
                
                HStack{
                    Image(systemName: "hourglass.tophalf.filled").foregroundColor(Color("blue"))
                    Text("Starts At ".localized)
                        
//                    }
//                    if isStartPickerVisible{
                        DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                            .labelsHidden().padding(.horizontal)
                            .accentColor(Color("blue"))

                    
                    
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
                               selection: $meetingDate,
                               displayedComponents: .date)
                    .padding(.horizontal)
                    .accentColor(Color("blue"))
                    Spacer().padding()

                  
                   
                }
                HStack{
                    Text("Status".localized)
                    Menu {
                        Picker(selection: $selectedStatus) {
                            ForEach(status, id:\.self) { value in
                                Text(value.localized)
                                    .tag(value)
                                   
                            }
                        } label: {}
                    } label: {
                        HStack{
                            
                         Spacer()

                        statusIcon(status: selectedStatus)
                            Text(selectedStatus.localized).foregroundColor(Color("blue"))
                        }
                    }
                    
                }
             
            
            }
            
            
            Section{
                
                
                NavigationLink(destination:
                                Projects(selectedProject: $meetingProject, selectedProjectName: $meetingProjectName)){
                    
                    
                    
                    HStack{
                    Image(systemName: "align.vertical.top.fill").foregroundColor(Color("blue"))
                    Text("Project: ".localized)
                   
                        Text(getProjectName(projectId: meetingProject).localized).foregroundColor(.gray)
                    
                }
                    
                }
                
                
                
                if showStack{

                NavigationLink(destination:
                                OtherUsersProfile(user: user)) {
                    HStack{
                        Image(systemName: "person.fill").foregroundColor(Color("blue"))
                        Text("Creator: ".localized)
                        Image(uiImage: imageWith(name: "\(firstName) \(lastName)")!).resizable().frame(width:25 , height: 25)

                        Text("\(firstName) \(lastName)").foregroundColor(.gray)
                    }

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
                
            
                
                NavigationLink(destination: MeetingMinutes(meetingMinutes: $meetingMinutes))
                {
                    
                    
                   Image(systemName: "pencil").foregroundColor(Color("blue"))
                    Text("Meeting Minutes".localized).onAppear{
                            
                            meetingMinutes = meetingMinutes.filter({ $0 != ""   })
                            if meetingMinutes.isEmpty{
                                meetingMinutes.append("")
                            }
                        }

                    
                }
                
                HStack{
                    Image(systemName: "paperclip").foregroundColor(Color("blue"))
                    Text("Attachments".localized)
                    Spacer()
                    Image(systemName: "plus").foregroundColor(Color("gray"))
                }
                
                
            }
        }
        
        
        .navigationTitle("Meeting".localized)
            .navigationBarTitleDisplayMode(.inline)
        
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button(action:{
                        if meetingTitle != "" {
                            meeting.meetingTitle = meetingTitle
                            meeting.meetingRoom = meetingRoom
                            meeting.meetingDate = meetingDate
                            meeting.meetingStartTime = startTime
                            meeting.meetingEndTime = endTime
                            meeting.meetingAgenda = meetingAgenda
                            meeting.meetingProjectId = meetingProject
                            meeting.meetingStatus = selectedStatus
                            meeting.meetingMembers = members
                            meeting.mom = meetingMinutes
                            meeting.zoomUrl = meetingLink
                           // meeting.meetingCreator = meetingCreator
                            dbMeetings.updateMeeting(meeting)
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                    }){
                        Text("Save".localized).foregroundColor(meetingTitle != "" ? Color("blue"): .gray)
                        
                    }
                }
                
            }

        
    }
    
    
}


struct MeetingMinutes: View{
    @Binding var meetingMinutes : [String]
    @State var callToOrder = ""
    @State private var textHeight: CGFloat = 40
    @State private var maxTextHeight: CGFloat = 100000000
    var body: some View{
        
        Form{
            
            
            TextView(placeholderText: "Title".localized, text: $meetingMinutes[0], minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
            
            
            ForEach((1..<meetingMinutes.count), id: \.self) {i in
                
                TextView(placeholderText: "Title".localized, text: $meetingMinutes[i], minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
            }
            Button(action: {
                meetingMinutes.append("")
            }){
                HStack{
                    Image(systemName: "plus")
                    Text("Add".localized)
                }
            }.foregroundColor(Color("blue"))
            
                .navigationTitle("Meeting Minutes".localized)
            
        }
        
        
    }
    
}




