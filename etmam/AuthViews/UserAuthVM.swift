//
//  UserAuthVM.swift
//  testFirebase
//
//  Created by Najla Alshehri on 06/06/2022.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import SwiftUI

class UserAuthVM: ObservableObject {
    let auth = Auth.auth()
    static let sharedauthVM = UserAuthVM() //why do we need this
    @Published var IsSignedIn = false //must be false
    @Published var hasError = false
    @Published var errorMsg = ""
    @Published var resetErrorMsg = ""
    @Published var userSignedOut = false
    
    init(){
        if auth.currentUser?.uid != nil {
            self.IsSignedIn = true
        }
    }
  
    
    
    // handle user sign in
    func signIn(email:String , password: String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
                if let error = error as NSError?{
                self?.hasError = true
                self?.handelAuthErrors(error:error)
                
                
            }else{
                DispatchQueue.main.async {
                    self?.hasError = false
                    UserAuthVM.sharedauthVM.IsSignedIn = true
                }
            }
        }
    }
    
    
    // handle user sign up
    func signUp(email:String , password: String , completion: @escaping (_ success: Bool) -> Void) {
        auth.createUser(withEmail: email, password: password ){ [weak self] result, error in
            if let error = error as NSError? {
                self?.hasError = true
                self?.handelAuthErrors(error:error)
            }
            else{
                DispatchQueue.main.async {
                    self?.hasError = false
                    completion(true)
                    //TODO: create user doc

                }
            }
        }
    }
    

    
    // handle user sign out
    func handleSignout (){
        try? auth.signOut()
        self.IsSignedIn = false
        self.userSignedOut = true
     
    }
    
    func resetPassword(email: String , completion: @escaping (_ success: Bool) -> Void){
        auth.sendPasswordReset(withEmail: email) { [weak self]  error in
            if let error = error as NSError?{
                self?.hasError = true
                self?.resetErrorMsg = "\(error.localizedDescription)"
               // self?.handelAuthErrors(error:error)
               print(error.localizedDescription)
            }else{
                DispatchQueue.main.async {
                self?.hasError = false
                self?.resetErrorMsg = ""
                completion(true)
                }
            }
        }
    }
   
    // upload profile pic to firebase storge
    func uploadProfilePic(profileImage: UIImage , ImageName: String ){
        let storageRef = Storage.storage().reference()
        let imageData = profileImage.jpegData(compressionQuality: 0.8)
        let imagesRef = storageRef.child("images/\(ImageName).jpg")
        
        _ = imagesRef.putData( imageData! , metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                // dipaly error
                return
            }
        }
    }
    
    
    // handle user Authtication errors
    func handelAuthErrors(error:NSError){
        switch error.code {
        case AuthErrorCode.wrongPassword.rawValue:
            self.errorMsg = "wrong password"
        case AuthErrorCode.invalidEmail.rawValue:
            self.errorMsg = "invalid email"
        case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
            self.errorMsg = "the account already exists"
        case AuthErrorCode.weakPassword.rawValue:
            self.errorMsg = "weakPassword"
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            self.errorMsg = "Email is used by other account "
        default:
            self.errorMsg = "\(error.localizedDescription)"
        }
    }
}


