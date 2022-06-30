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


class userDatabaseVM: ObservableObject {
    let dbUsers = Firestore.firestore()
    @Published var projects = [Project]()
    @Published var userTasks = [Task]()
    @Published var userCreatedTasks = [Task]()
    @Published var users = [User]()
    @Published var currentUserID: String = ""
    @Published var currentOrgID: String = ""
    @Published var currentUserProfile: User = User(firstName: "nil", lastName: "nil", userJobTitle: "nil", userPhone: "nil", userEmail: "nil", userPermession: 5, userProjects: ["nil"], userTasks: ["nil"], userMeetings: ["nil"], userImage: "nil", userLineManger: "nil", userOrg: "nil")
    @EnvironmentObject var userAuthVM: UserAuthVM
    
    
    init(){
        getUserTasks()
        loadData()
        getUserProjects()
        getUserProfile()
     
    }
    
    func getUserProfile(){
        
       
          if (Auth.auth().currentUser?.uid != nil){
              var userDocument = try dbUsers.collection("Users").document(Auth.auth().currentUser!.uid).getDocument{ (document, error) in
                  if let document = document, document.exists {
                      do{
                          self.currentUserProfile = try document.data(as: User.self)}
                      catch{
                          print("Error retirving user profile")
                      }
      
                  } else {
                      print("Document does not exist")
                  }
              } }
          else {
              print("User not signed in ")
          }
    }

    func loadData(){

        if (Auth.auth().currentUser?.uid != nil){
            var userDocument = try dbUsers.collection("Users").document(Auth.auth().currentUser!.uid).getDocument{ (document, error) in
                if let document = document, document.exists {
                    self.currentUserID = document.documentID
                    self.currentOrgID = document.get("userOrg") as? String ?? ""
                    print("USer: \(self.currentUserID)")
                    print("Org: \(self.currentOrgID)")
                } else {
                    print("Document does not exist")
                }
            }
 }
        else {
            print("User not signed in ")
        }
    }
    func getUserProjects() {
        //Get projects: User is a memeber
        dbUsers.collection("Projects").whereField("orgID", isEqualTo: currentOrgID).whereField("projectMembers", arrayContains: currentUserID).addSnapshotListener { [self] (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.projects.append(contentsOf: (querySnapshot.documents.compactMap { document in
                    do{
                        let x =  try document.data(as: Project.self)
                       // self.userProjects.append(x)
                        print("project: \(x.projectName)")
                        return x
                    }
                    catch {
                        print(error)
                    }
                    return nil
                }))
            }

        }
        dbUsers.collection("Projects").whereField("orgID", isEqualTo: "123").whereField("projectManager", arrayContains: "8GSr8viArAFXo12pqnoR").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.projects.append(contentsOf: (querySnapshot.documents.compactMap { document in
                    do{
                        let x =  try document.data(as: Project.self)
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

   
    }

    
    func updateUser(_ userID: String,_ updatedField: String,_ updatedValue: String ){
        do{
           dbUsers.collection("Users").document(userID).updateData([updatedField : updatedValue])
        }
        catch{
            print("Unable to update user: \(error.localizedDescription)")
        }
    }
    
    func getUserTasks() {
     
           dbUsers.collection("Tasks").addSnapshotListener { [self] (querySnapshot, error) in
               if let querySnapshot = querySnapshot {
                   self.userTasks = querySnapshot.documents.compactMap { document in
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

    func addUser(_ user:User,_ password: String){
        //Add user to Auth
        do{
            Auth.auth().createUser(withEmail: user.userEmail, password: password){ authResult, error in
                do{
                    print("User Added to Auth:\(authResult)")
                    var _ = try self.dbUsers.collection("Users").document(Auth.auth().currentUser?.uid ?? "123123").setData(from: user)
                }
                catch {
                    print(error)
                }
            }
           // var _ = try dbUsers.collection("test_user").addDocument(from: user)
        }
        catch{
            print("Unable to encode user: \(error.localizedDescription)")
        }
        

    }
    
    
    func addUserAndOrg(_ user:User,_ password: String, _ org: Orgnization){
           //Add user to Auth
           do{
               Auth.auth().createUser(withEmail: user.userEmail, password: password){ authResult, error in
                   do{

                       var newOrg = org
                       newOrg.OrgOwner = Auth.auth().currentUser?.uid ?? "123123"
                       var org = try self.dbUsers.collection("Organizations").addDocument(from: newOrg)
                       var newUSer = user
                       newUSer.userOrg = org.documentID
                       var _ = try self.dbUsers.collection("Users").document(Auth.auth().currentUser?.uid ?? "123123").setData(from: newUSer)
                       UserAuthVM.sharedauthVM.IsSignedIn = true
                   }
                   catch {
                       print(error)
                   }
               }
              // var _ = try dbUsers.collection("test_user").addDocument(from: user)
           }
           catch{
               print("Unable to encode user: \(error.localizedDescription)")
           }
           

       }

}


