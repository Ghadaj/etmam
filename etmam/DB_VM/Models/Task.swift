//
//  Task.swift
//  testFirebase
//
//  Created by Danya T on 02/11/1443 AH.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift


class Task: Codable, Identifiable {
  @DocumentID var id : String?
    var taskTitle: String?
    var taskCreator: String?
    var taskMembers: [String]?
    var taskProjectId: String?
    var taskStartDate: Date?
    var taskDeadline: Date?
    var taskAttachments: [String]?
    var taskColor: String?
    var taskDesc: String?
    var taskStatus: String?

     
     init(taskTitle:String,taskDesc: String ,taskCreator: String,  taskMembers: [String], taskProjectId: String, taskStartDate: Date,taskDeadline: Date,taskAttachments: [String],taskColor: String, taskStatus: String ){

         self.taskTitle = taskTitle
         self.taskDesc = taskDesc
         self.taskCreator = taskCreator
         self.taskMembers = taskMembers
         self.taskProjectId = taskProjectId
         self.taskStartDate = taskStartDate
         self.taskDeadline = taskDeadline
         self.taskAttachments = taskAttachments
         self.taskColor = taskColor
         self.taskStatus = taskStatus
       

     }
     init(taskTitle:String, taskDesc: String,taskCreator: String,  taskMembers: [String], taskProjectId: String, taskStartDate: Date,taskAttachments: [String],taskColor: String,taskStatus: String ){

         self.taskTitle = taskTitle
         self.taskDesc = taskDesc
         self.taskCreator = taskCreator
         self.taskMembers = taskMembers
         self.taskProjectId = taskProjectId
         self.taskStartDate = taskStartDate
         self.taskAttachments = taskAttachments
         self.taskColor = taskColor
         self.taskStatus = taskStatus

     }
    
    
    class image{
        var i : Image
        init(i: Image){
            self.i = i
        }
    }

}
