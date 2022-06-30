// To be removed

import SwiftUI
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import StoreKit
struct SwiftUIView: View {
    
    @EnvironmentObject var dbOrgs: orgDatabaseVM
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbProjects: projectDatabaseVM
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM
    // Create Date
    //let date = Date()

   // let dateFormatter = DateFormatter()

    // Set Date Format

    // Convert Date to String

    var body: some View {
        
//        Text("Task 1")
//        if(dbUsers.userTasks[0].taskDeadline != nil){
//            DatePicker(selection: .constant(dbUsers.userTasks[0].taskDeadline!.dateValue()), label: { Text("Date") })
//
//        }
    //    else {
            Text("no Deadline")
    //    }
        
//        Text("Task 2")
//        if (dbUsers.checkdeadline(dbUsers.userTasks[1]))
//        {
//            DatePicker(selection: .constant(dbUsers.userTasks[1].taskDeadline!.dateValue()), label: { Text("Date") })
//        }
//
//        else {
//            Text("no Deadline")
//        }
        
       // Text("deadline\(dbUsers.checkdeadline(dbUsers.userTasks[0]))")
       // Text(dbUsers.checkdeadline(dbUsers.userTasks[0]))
        //do{
//           try  DatePicker(selection: .constant(dbUsers.userTasks[0].taskDeadline!.dateValue()), label: { Text("Date") })//}
//        do{
//        try  DatePicker(selection: .constant(dbUsers.userTasks[1].taskDeadline!.dateValue()), label: { Text("Date") })
//        }
//        catch let error{
//            Text("no")
//        }
        
//        catch{
//            Text("no deadline")
//        }
//        if((dbUsers.userTasks[0].){
//            DatePicker(selection: .constant(dbUsers.userTasks[0].taskDeadline!.dateValue()), label: { Text("Date") })}
//        else {
//            Text("no deadline")
//        }
       // dateFormatter.dateFormat = "YY/MM/dd"
//        if (dbUsers.userTasks[0].taskDeadline != nil){
//            Text("deadline\(dateFormatter.string(from:   dbUsers.userTasks[0].taskDeadline!.dateValue()))
//
//        }
    
    //    Text(String(dbUsers.userTasks[0].taskDeadline!.dateValue()))
        
        //Calendar.date(dbUsers.userTasks[0].taskDeadline!.dateValue())
                 
//        if (dbUsers.userTasks[0].taskDeadline != nil){
//            Text("deadline")
//            
//        }
//        if dbUsers.userTasks[0].contains("taskDeadline"){
//            Text("deadline")
//
//        }
     //   Text(dateFormatter.string(from:   dbUsers.userTasks[1].taskDeadline!.dateValue()) ?? "no deadline")
     //   Text(dbUsers.userTasks[1].taskDeadline ?? "no deadline")

    }
    
//    func checkdeadline(_ task: Task){
//
//   //     try  DatePicker(selection: .constant(dbUsers.userTasks[0].taskDeadline!.dateValue()), label: { Text("Date") })//}
//     do{
//     try  DatePicker(selection: .constant(dbUsers.userTasks[1].taskDeadline!.dateValue()), label: { Text("Date") })
//     }
//     catch let error{
//         Text("no")
//     }
//
//    }
    
}




struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
