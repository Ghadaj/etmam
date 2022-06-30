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
   var meeting: Meeting
    @State var members : [String] = [""]
    @State var meetingMinutes : [String] = [""]
    @State var status = ["To Do","Done"]
    @State var selectedStatus = ""
    @State private var meetingMinuteArrayCheck = false

    
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
    @State private var textHeight: CGFloat = 40
    @State private var maxTextHeight: CGFloat = 10000000
    let columns = Array(repeating: GridItem(.flexible(minimum: 1, maximum: 1), spacing: 35), count: 5)
    
    
    
    
    @Environment(\.presentationMode) var presentationMode
    
    
    
    
    var body: some View {
        
        
        
        Form{
            
            
            
            Section{
                
                TextField( "Title", text: $meetingTitle)
                
                
                
                TextView(placeholderText: "Meeting Agenda", text: $meetingAgenda,minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
    
            }
            
            
            Section{
                
                
                
                HStack{
//
//                    Button(action: {isStartPickerVisible.toggle()}){
                        Text("Starts")
                        
//                    }
//                    if isStartPickerVisible{
                        DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                            .labelsHidden().padding(.horizontal)
                            .accentColor(Color("blue"))
//                    }
                    Spacer()
                    
                    Image(systemName: "hourglass.tophalf.filled").foregroundColor(Color("blue"))
                    
                    
                }
                
                HStack{
                    
//                    Button(action: {isEndPickerVisible.toggle()}){
                        Text("Ends  ")
//                    }
//                    if isEndPickerVisible{
                        DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                            .labelsHidden().padding(.horizontal)
                            .accentColor(Color("blue"))
//                    }
                    Spacer()
                    Image(systemName: "hourglass.bottomhalf.filled").foregroundColor(Color("blue"))
                }
                HStack{
                    Text("Status")
                    Menu {
                        Picker(selection: $selectedStatus) {
                            ForEach(status, id:\.self) { value in
                                Text(value)
                                    .tag(value)
                                   
                            }
                        } label: {}
                    } label: {
                        HStack{
                            
                         Spacer()

                        statusIcon(status: selectedStatus)
                            Text(selectedStatus).font(.title3).foregroundColor(Color("blue"))
                        }
                    }
                    
                }
             
            
            }
            
            
            Section{
                
                
                NavigationLink(destination:
                                Projects(selectedProject: $meetingProject, selectedProjectName: $meetingProjectName)){
                    
                    
                    Text("Project: ")
                    
                    Text(meetingProjectName).foregroundColor(.gray)
                    
                }
                
                
                
                
                
                NavigationLink(destination:
                                CardCell()) {
                    HStack{
                        Image(systemName: "person").foregroundColor(Color("blue"))
                        Text("Creator:")
                        Spacer()
                        Image(uiImage: imageWith(name: "Salem Nasser")!).resizable().frame(width:25 , height: 25)
                        Text("Salem Nasser").foregroundColor(.gray)
                    }
                    
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
                    Button(action: {
                        isMeetingLinkVisible.toggle()}){
                            Toggle("", isOn: $isMeetingLinkVisible)
                        }
                }
                
                
                
                
                if isMeetingLinkVisible{
                    TextView(placeholderText: "Meeting Link", text: $meetingLink, minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                        .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                    
                    
                }
                
                HStack{
                    Image(systemName:"mappin.and.ellipse" ).foregroundColor(.gray)
                    TextField( "Meeting Room", text: $meetingRoom)
                }
                
            
                
                NavigationLink(destination: MeetingMinutes(meetingMinutes: $meetingMinutes))
                {
                    
                    
                   
                        Text("Meeting Minutes").onAppear{
                            
                            meetingMinutes = meetingMinutes.filter({ $0 != ""   })
                            if meetingMinutes.isEmpty{
                                meetingMinutes.append("")
                            }
                        }

                    
                }
                
                HStack{
                    Image(systemName: "paperclip").foregroundColor(.gray)
                    Text("Attachments")
                    Spacer()
                    Image(systemName: "plus").foregroundColor(Color("blue"))
                    
                }
                
                
            }
        }
        
        
            .navigationTitle("Meeting")
            .navigationBarTitleDisplayMode(.inline)
        
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button(action:{
                        if meetingTitle != "" {
                            meeting.meetingTitle = meetingTitle
                            meeting.meetingRoom = meetingRoom
                            meeting.meetingStartTime = startTime
                            meeting.meetingEndTime = endTime
                            meeting.meetingAgenda = meetingAgenda
                            meeting.meetingProjectId = meetingProject
                            meeting.meetingStatus = selectedStatus
                            meeting.meetingMembers = members
                            meeting.mom = meetingMinutes
                            meeting.zoomUrl = meetingLink
                            
                            dbMeetings.updateMeeting(meeting)
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                    }){
                        Text("Save").foregroundColor(meetingTitle != "" ? Color("blue"): .gray)
                        
                    }
                }
                
            }

        
    }
    
    
}
//struct MeetingCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetingCard(meeting: Meeting()
//    }
//}

struct MeetingMinutes: View{
    @Binding var meetingMinutes : [String]
    @State var callToOrder = ""
    @State private var textHeight: CGFloat = 40
    @State private var maxTextHeight: CGFloat = 100000000
    var body: some View{
        
        Form{
            
            
            TextView(placeholderText: "Call to order", text: $meetingMinutes[0], minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
            
            
            ForEach((1..<meetingMinutes.count), id: \.self) {i in
                
                TextView(placeholderText: "Title", text: $meetingMinutes[i], minHeight: self.textHeight,maxHeight: self.maxTextHeight, calculatedHeight: self.$textHeight)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
            }
            Button(action: {
                meetingMinutes.append("")
            }){
                HStack{
                    Image(systemName: "plus")
                    Text("Add")
                }
            }.foregroundColor(Color("blue"))
            
                .navigationTitle("Meeting Minutes")
            
        }
        
        
    }
    
}




