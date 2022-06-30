//
//  orgDatabaseVM.swift
//  testFirebase
//
//  Created by Danya T on 02/11/1443 AH.
//

import Foundation
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class orgDatabaseVM: ObservableObject {
    let dbOrgs = Firestore.firestore()
    let orgCollectionName = "Organizations"
    let orgID = "VIsdNKt60CZzGJTq3H5R"
    let userVM = userDatabaseVM()
    @Published var org = [Orgnization]()
    var orgMembers = [User]()
    

    init(){
        loadData()
        getMembers()
        print("UserID\(Auth.auth().currentUser?.uid )")
    }

    func loadData(){
       
        
        let orgDocument = dbOrgs.collection(orgCollectionName).document(orgID)

        orgDocument.getDocument { (document, error) in
            if let document = document, document.exists {
                let x = document.data().map(String.init(describing:)) ?? "nil"
            } else {
                print("Orgnaization Document does not exist")
            }
        }
    }
    
    
    func createOrg(_ org:Orgnization){
      
        //TO DO: if the info is valid register new org
       
         do{
            var _ = try dbOrgs.collection("Organizations").addDocument(from: org)

             DispatchQueue.main.async {
                 UserAuthVM.sharedauthVM.IsSignedIn = true
             }
            }
            catch{
              print("Unable to encode task: \(error.localizedDescription)")
            }
        }


    
    func getMembers() -> [User]{
        do{
            dbOrgs.collection("Users").whereField("userOrg", isEqualTo: userVM.currentOrgID).addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    
                    self.orgMembers = querySnapshot.documents.compactMap { document in
                        do{
                            print("document user: \(document)")
                            let x =  try document.data(as: User.self)
                            print("username\(x.firstName)")
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
            catch{
                print("Unable to get task: \(error.localizedDescription)")
            
            }
        print("users: \(orgMembers.count)")
        return self.orgMembers
        }

}


