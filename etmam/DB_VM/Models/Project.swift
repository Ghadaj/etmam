////
////  Project.swift
////  testFirebase
////
////  Created by Danya T on 02/11/1443 AH.
////
//
//import Foundation
//import SwiftUI
//import Firebase
//import FirebaseFirestoreSwift
//
//class Project: Codable, Identifiable {
//   @DocumentID var id : String?
//    var projectName: String?
//    var projectManger: [String]?
//    var projectDeadline: Date?
//    var projectStartDate: Date?
//    var projectMembers: [String]?
//    var projectTasks: [String]?
//    var projectMeetings: [String]?
//    var projectDesc: String?
//    var projectProgress: Int?
//    var projectAttachments: [String]?
//    var projectColor: String?
//
//    enum projectStatus{
//        case inProgress
//        case completed
//    }
//
//
//    init(projectName: String,projectManger: [String],projectDeadline: Date,projectStartDate: Date?, projectMembers: [String], projectTasks: [String], projectMeetings: [String], projectDesc: String, projectProgress: Int, projectAttachments: [String], projectColor:String ){
//
//        self.projectName = projectName
//        self.projectManger = projectManger
//        self.projectDeadline = projectDeadline
//        self.projectStartDate = projectStartDate
//        self.projectMembers = projectMembers
//        self.projectTasks = projectTasks
//        self.projectMeetings = projectMeetings
//        self.projectDesc = projectDesc
//        self.projectProgress = projectProgress
//        self.projectAttachments = projectAttachments
//        self.projectColor = projectColor
//
//    }
//
//
//}
//
//




//
//  Project.swift
//  calenderSwift
//
//  Created by Danya T on 27/11/1443 AH.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class Project: Codable, Identifiable {
   @DocumentID var id : String?
    var projectName: String?
    var projectManger: String?
    var projectDeadline: Date?
    var projectMembers: [String]?
    var projectDesc: String?
    var projectAttachments: [String]?
    var projectColor: String?
    
   
    
    

    init(projectName: String,projectManger: String,projectDeadline: Date, projectMembers: [String], projectDesc: String,  projectAttachments: [String], projectColor:String ){

        self.projectName = projectName
        self.projectManger = projectManger
        self.projectDeadline = projectDeadline
        self.projectMembers = projectMembers
        self.projectDesc = projectDesc
        self.projectAttachments = projectAttachments
        self.projectColor = projectColor

    }
    
    
}

