//
//  meetingDatabaseVM.swift
//  testFirebase
//
//  Created by Danya T on 04/11/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class meetingDatabaseVM: ObservableObject {
    let dbMeetings = Firestore.firestore()
    @Published var meetings = [Meeting]()
    let usersVM = userDatabaseVM()
    
    

    init(){
        loadData()
    }

    func loadData(){

        dbMeetings.collection("Meetings").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.meetings = querySnapshot.documents.compactMap { document in
                    do{
                        let x =  try document.data(as: Meeting.self)
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
   
    func addMeeting(_ meeting:Meeting){
        do{
            var _ = try dbMeetings.collection("test_meetings").addDocument(from: meeting)
        }
        catch{
            print("Unable to encode task: \(error.localizedDescription)")
        }

    }
    func deleteMeeting(_ meeting:Meeting) {
        guard let id = meeting.id else {return}
        var _  = dbMeetings.collection("test_meetings").document(id).delete() { err in
            if let err = err {
              print("Error removing document: \(err)")
            }
            else {
              print("Document successfully removed!")
            }
        }
    }

    
    
    func updateMeeting(_ meeting:Meeting){
        do {
            guard let id = meeting.id else {return}
            try dbMeetings.collection("test_meetings").document(id).setData(from: meeting)
        } catch {
            print("Unable to encode task: \(error.localizedDescription)")
        }


    }
   
    
    
    func changeMeetingStatusToToDo(_ meeting:Meeting){
        do {
            guard let id = meeting.id else {return}
          try dbMeetings.collection("test_meetings").document(id).setData(from: ["meetingStatus": "To Do"],merge: true)
        } catch {
            print("Unable to encode task: \(error.localizedDescription)")
        }


    }
    
    
    
    func changeMeetingStatusToDone(_ meeting:Meeting){
        do {
            guard let id = meeting.id else {return}
          try dbMeetings.collection("test_meetings").document(id).setData(from: ["meetingStatus": "Done"],merge: true)
        } catch {
            print("Unable to encode task: \(error.localizedDescription)")
        }


    }
    
    
    
    
}








