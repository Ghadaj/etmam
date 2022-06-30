//
//  User.swift
//  testFirebase
//
//  Created by Danya T on 02/11/1443 AH.
//


import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class User: Codable, Identifiable {
  @DocumentID var id : String?
   
    var firstName: String?
    var lastName: String?
    var userJobTitle: String?
    var userPhone: String?
    var userEmail: String
    var userPermession: Int?
    var userProjects: [String]?
    var userTasks: [String]?
    var userMeetings: [String]?
    var userImage: String?
    var userLineManger: String?
    var userOrg: String?

    
    
    init(firstName: String, lastName: String, userJobTitle:String, userPhone:String, userEmail: String, userPermession: Int, userProjects:[String],userTasks:[String], userMeetings: [String], userImage: String, userLineManger:String, userOrg:String){
        self.firstName = firstName
        self.lastName = lastName
        self.userJobTitle = userJobTitle
        self.userPhone = userPhone
        self.userEmail = userEmail
        self.userPermession = userPermession
        self.userProjects = userProjects
        self.userTasks = userTasks
        self.userMeetings = userMeetings
        self.userImage = userImage
        self.userLineManger = userLineManger
        self.userOrg = userOrg
        
    }

    
    
}
