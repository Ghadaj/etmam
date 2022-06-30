//
//  taskDatabaseVM.swift
//  testFirebase
//
//  Created by Danya T on 02/11/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class taskDatabaseVM: ObservableObject {
    let dbTasks = Firestore.firestore()
    let userDBVM = userDatabaseVM()
    @Published  var userTasks = [Task]()
    
    @Published var tasks = [Task]()
    
    

    init(){
        loadData()
       // self.getTasks("123")
    }

//    func loadData(){
//        let orgCollectionName = "polaris"
//        let orgId = "S1dPA9sfRTpkqljIyGGj"
//        dbTasks.collection(orgCollectionName).document(orgId).collection("Tasks").addSnapshotListener { (querySnapshot, error) in
//            if let querySnapshot = querySnapshot {
//                self.tasks = querySnapshot.documents.compactMap { document in
//                    do{
//                        let x =  try document.data(as: Task.self)
//                        return x
//                    }
//                    catch {
//                        print(error)
//                    }
//                    return nil
//                }
//            }
//
//        }
//    }
//
//
    func loadData(){
        dbTasks.collection("Tasks").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.tasks = querySnapshot.documents.compactMap { document in
                    do{
                        let x =  try document.data(as: Task.self)
                        return x
                    }
                    catch {
                        print(error)
                    }
                    return nil
                }
            }

        }
    }

    
    func getTasks(_ projectID: String) -> [Task]{
       
        do{
            dbTasks.collection("Tasks").whereField("orgID", isEqualTo: "Cc23k5VM2n0YfcXnahAR").whereField("taskProjectId", isEqualTo: projectID).addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    print("here")
                    self.userTasks.append(contentsOf: (querySnapshot.documents.compactMap { document in
                        do{
                            print("document task: \(document)")
                            let x =  try document.data(as: Task.self)
                            print("document task: \(x.taskProjectId)")
                            return x
                        }
                        catch {
                            print(error)
                        }
                    return nil
                    }
                ))
                }
            }
            if (0 < self.userTasks.count){
            print("user Taskss:")
                print(self.userTasks[0].taskProjectId)}
            return self.userTasks
            }
            catch{
                print("Unable to get task: \(error.localizedDescription)")
            }
        }
    
    
    func getTask(_ taskID: String) -> DocumentReference{
        do{
            var taskDocument = try dbTasks.collection("Task").document(taskID)
            return taskDocument
        }
        catch{
            print("Unable to get task: \(error.localizedDescription)")
        }
    }
    
        
    
    func addTask(_ task: Task){
            do{
                var _ = try dbTasks.collection("Tasks").addDocument(from: task)
            }
            catch{
                print("Unable to add task: \(error.localizedDescription)")
            }

        }

    
//    func deleteTask(_ taskID: String){
//        do{
//
//            dbTasks.collection("Tasks").document(taskID).delete()
//        }
//        catch{
//            print("Unable to delete task: \(error.localizedDescription)")
//        }
//    }
    
    func deleteTask(_ task: Task) {
        guard let id = task.id else {return}
        var _  = dbTasks.collection("Tasks").document(id).delete() { err in
            if let err = err {
              print("Error removing document: \(err)")
            }
            else {
              print("Document successfully removed!")
            }
        }
    }
    
//    func updateTask(_ taskID: String,_ updatedField: String,_ updatedValue: String ){
//        do{
//           dbTasks.collection("Tasks").document(taskID).updateData([updatedField : updatedValue])
//        }
//        catch{
//            print("Unable to delete task: \(error.localizedDescription)")
//        }
//    }


    func updateTask(_ task:Task){
        do {
            guard let id = task.id else {return}
            try dbTasks.collection("test_tasks").document(id).setData(from: task)
        } catch {
            print("Unable to encode task: \(error.localizedDescription)")
        }


    }
    



func changeTaskStatusToDoing(_ task:Task){
    do {
        guard let id = task.id else {return}
      try dbTasks.collection("Tasks").document(id).setData(from: ["taskStatus": "Doing"],merge: true)
    } catch {
        print("Unable to encode task: \(error.localizedDescription)")
    }


}


func changeTaskStatusToDone(_ task:Task){
    do {
        guard let id = task.id else {return}
      try dbTasks.collection("Tasks").document(id).setData(from: ["taskStatus": "Done"],merge: true)
    } catch {
        print("Unable to encode task: \(error.localizedDescription)")
    }


}


func changeTaskStatusToToDo(_ task:Task){
    do {
        guard let id = task.id else {return}
      try dbTasks.collection("Tasks").document(id).setData(from: ["taskStatus": "To Do"],merge: true)
    } catch {
        print("Unable to encode task: \(error.localizedDescription)")
    }


}
}
