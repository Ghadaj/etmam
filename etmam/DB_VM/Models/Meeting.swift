//
//  Meeting.swift
//  calenderSwift
//
//  Created by Danya T on 23/11/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

class Meeting: Codable, Identifiable {
    @DocumentID var id : String?
    var meetingTitle: String?
    var meetingCreator: String?
    var meetingMembers: [String]?
    var meetingProjectId: String?
    var meetingCreatedDate: Date?
    var meetingStartTime: Date?
    var meetingEndTime: Date?
    var meetingAttchments: [String]?
    var meetingAgenda: String?
    var meetingRoom: String?
    var meetingStatus: String?
    var mom: [String]?
    var zoomUrl: String?
  
    
    init(meetingTitle: String, meetingCreator: String, meetingMembers: [String], meetingProjectId: String,meetingCreatedDate: Date?, meetingStartTime: Date, meetingEndTime: Date, meetingAttchments: [String], meetingRoom: String, meetingStatus: String ,meetingAgenda: String, mom: [String], zoomUrl: String){
        self.meetingTitle = meetingTitle
        self.meetingCreator = meetingCreator
        self.meetingMembers = meetingMembers
        self.meetingProjectId = meetingProjectId
        self.meetingCreatedDate = meetingCreatedDate
        self.meetingStartTime = meetingStartTime
        self.meetingEndTime = meetingEndTime
        self.meetingAttchments = meetingAttchments
        self.meetingAgenda = meetingAgenda
        self.meetingRoom = meetingRoom
        self.meetingStatus = meetingStatus
        self.mom = mom
        self.zoomUrl = zoomUrl
        
        
    }
    
    
    
}
