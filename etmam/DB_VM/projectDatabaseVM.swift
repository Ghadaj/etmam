//
//  projectDatabaseVM.swift
//  testFirebase
//
//  Created by Danya T on 04/11/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class projectDatabaseVM: ObservableObject {
    let dbProjects = Firestore.firestore()
    @Published var projects = [Project]()
    var userVM = userDatabaseVM()


    init(){
        loadData()
    }

    func loadData(){
        dbProjects.collection("Projects").whereField("orgID", isEqualTo: userVM.currentOrgID).addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.projects = querySnapshot.documents.compactMap { document in
                    do{
                        let x =  try document.data(as: Project.self)
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
    
    func getProject(_ projectID: String)  {
        
//        do{
//       // func getAddresses(at path: String, completion: @escaping (([Address]) -> ())) {
//            let data = dbProjects.collection("Projects")
//            data.getDocuments { (snapshot, error) in
//                do{
//                let dictionaries = snapshot?.documents.compactMap({$0.data()}) ?? []
//                let addresses = try dictionaries.compactMap({Project(from: $0 as! Decoder)})
//               // completion(addresses)
//            }
//                catch{
//                    print("")
//                }
//        }
//        catch{
//            print("error")
//        }
//
        
        
//
////
////        var xxx  = Project()
//        let e = dbProjects.collection("Projects").whereField("OrgID",  isEqualTo: userVM.currentOrgID).addSnapshotListener { (querySnapshot, error) in
//            if let querySnapshot = querySnapshot {
//                self.projects = querySnapshot.documents.compactMap { document in
//                    do{
//                        if (document.documentID == projectID){
//                            let x =  try document.data() as! Project
//
//
//                            print(self.ppp)
//                      //  return x
//                        }
//                    }
//                    catch {
//                        print(error)
//                    }
//                    return self.ppp
//                }
//            }
//
//        }
//
//        return ppp
        
//
//        db.collection("websites")
//            .addSnapshotListener { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    guard let documents = querySnapshot?.documents else {
//                        print("no documents")
//                        return
//                    }
//                    self.websites = documents
//                        .flatMap { document -> Website in
//                            return try! document.data(as: Website.self)
//                        }
//                }
//            }
//
        
//
//        dbProjects.collection("Projects").document(projectID).addSnapshotListener { (querySnapshot, err) in
//              do
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                  //  let dfetchedProject =  try querySnapshot.document.data(as: Project.self)
////                   guard let documents = querySnapshot?.documents else {
////                        print("no documents")
////                        return
////                    }
//                    let dfetchedProject =  try querySnapshot!.data() as Project
//
//                }
//                }
//
        
        
//       // getProjectDocument(projectID)
//        //let fetchedProject = Project
//        let docRef = db.collection("Projects").document(projectID)
//        docRef.getDocument(as: Project.self) {document in
//            // The Result type encapsulates deserialization errors or
//            // successful deserialization, and can be handled as follows:
//            //
//            //      Result
//            //        /\
//            //   Error  City
//           // switch result {
//           // case .success(let project):
//                // A `City` value was successfully initialized from the DocumentSnapshot.
//               print("project: \(document)")
//           // case .failure(let error):
//                // A `City` value could not be initialized from the DocumentSnapshot.
//             //   print("Error decoding city: \(error)")
//            }
        
       
    //    return docRef
        
//
//        var ss = dbProjects.collection("Projects").document(projectID)//.getDocument()
//
//        print ("Project\(ss.data())")
//            var fetchedDocument = try dbProjects.collection("Projects").document(projectID).getDocument{ (document, error) in
//
//                do {
//
////                if let document = document, document.exists {
////                    return   document = document.data()
////                   //  return x
//////                } else {
//////                   // return nil
//////                    print("Document does not exist")
//////                }
////                }}
//                    print("Document")
//                  //  return document?.data() as! Project}
//
//
//        }
//        catch{
//            print("Unable to get project: \(error.localizedDescription)")
//        }
//
//            } //as! Project
//
       // return fetchedDocument
    }
    
    func getProjectDocument(_ projectID: String){
        
        
        
  
        
        
//
//        do{
//            var fetchedDocument = try dbProjects.collection("Projects").document(projectID).getDocument{ (document, error) in
//               // if let document = document, document.exists {
//                fetchedProject =  try document!.data(as: Project.self)
//                   //  return x
////                } else {
////                   // return nil
////                    print("Document does not exist")
////                }
//            }
//            return fetchedProject
//        }
//        catch{
//            print("Unable to get project: \(error.localizedDescription)")
//        }
    }
    
        
    
    func addProject(_ project: Project){
            do{
                var _ = try dbProjects.collection("Projects").addDocument(from: project)
                print("project Added")
            }
            catch{
                print("Unable to add project: \(error.localizedDescription)")
            }

        }

    
//    func deleteProject(_ projectID: String){
//        do{
//
//            dbProjects.collection("Projects").document(projectID).delete()
//        }
//        catch{
//            print("Unable to delete project: \(error.localizedDescription)")
//        }
//    }
    
    func deleteProject(_ project :Project) {
        guard let id = project.id else {return}
        var _  = dbProjects.collection("Projects").document(id).delete() { err in
            if let err = err {
              print("Error removing document: \(err)")
            }
            else {
              print("Document successfully removed!")
            }
        }
    }
    
    func updateProjectInfo(_ project:Project , field :String, content: String){
        do {
            guard let id = project.id else {return}
            try dbProjects.collection("test_Projects").document(id).setData(from: [ field: content],merge: true)
        } catch {
            print("Unable to encode task: \(error.localizedDescription)")
        }


    }
    
    
     func updateProjectDeadline(_ project:Project , deadline :Date){
         do {
             guard let id = project.id else {return}
             try dbProjects.collection("test_Projects").document(id).setData(from: [ "projectDeadline": deadline],merge: true)
         } catch {
             print("Unable to encode task: \(error.localizedDescription)")
         }


     }
     func updateProjectMembers(_ project:Project , members: [String]){
         do {
             guard let id = project.id else {return}
             try dbProjects.collection("test_Projects").document(id).setData(from: [ "projectMembers": members],merge: true)
         } catch {
             print("Unable to encode task: \(error.localizedDescription)")
         }


     }
    
    
    func updateProject(_ projectID: String,_ updatedField: String,_ updatedValue: String ){
        do{
           dbProjects.collection("Projects").document(projectID).updateData([updatedField : updatedValue])
        }
        catch{
            print("Unable to delete project: \(error.localizedDescription)")
        }
    }
   

}

