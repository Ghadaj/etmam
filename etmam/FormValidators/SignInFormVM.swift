//
//  SignInFormVM.swift
//  testFirebase
//
//  Created by Najla Alshehri on 16/06/2022.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Combine

class SignInFormVM: ObservableObject{
    let db = Firestore.firestore()
    
    @Published var email = ""
    @Published var password = ""
    @Published var PasswordinlineError = ""
    @Published var EmailinlineError = ""
    @Published var cancellables =  Set<AnyCancellable>()
    let emailCheck = NSPredicate(format: "SELF MATCHES %@",  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    

// No account with this email
// wrong password
// rest password
    
// invalid email format kkk
// add option to show password kkk
// short password kkk
  
    
    // vaild email
    private var IsEmailVaildFormatPublisher: AnyPublisher<Bool, Never>{
        $email.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                self.emailCheck.evaluate(with: $0)
            }.eraseToAnyPublisher()
    }
    
    // not empty email
    private var IsEmailEmptyPublisher: AnyPublisher<Bool, Never>{
        $email.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
   
    // not empty password
    private var IsPasswordEmptyPublisher: AnyPublisher<Bool, Never>{
        $password.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    
    // too short password
    private var IsPasswordvalidLengthPublisher: AnyPublisher<Bool, Never>{
        $password.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.count > 5
            }.eraseToAnyPublisher()
    }
    
    private var IsPasswordVaildPublisher: AnyPublisher<PasswordStatus, Never>{
        Publishers.CombineLatest(IsPasswordEmptyPublisher, IsPasswordvalidLengthPublisher)
            .map{
                if $0  { return PasswordStatus.empty }
                if !$1 { return PasswordStatus.tooShort }
                return PasswordStatus.valid
            }.eraseToAnyPublisher()
    }
    
 
    private var IsEmailVaildPublisher: AnyPublisher<EmailStatus, Never>{
        Publishers.CombineLatest(IsEmailVaildFormatPublisher, IsEmailEmptyPublisher)
            .map{
                if !$0 { return EmailStatus.wrongFormat }
                if $1  { return EmailStatus.empty }
                return EmailStatus.valid
            }.eraseToAnyPublisher()
    }
    
    init(){
        IsPasswordVaildPublisher
            .dropFirst()
            .receive(on: RunLoop.main )
            .map{
                PasswordStatus in
                switch PasswordStatus{
                case .empty:
                    return "Password cannot be empty"
                case .tooShort:
                    return "password is too Short"
                case .valid:
                    return ""
                }
            }.assign(to: \.PasswordinlineError , on: self )
            .store(in: &cancellables)
        
        IsEmailVaildPublisher
            .dropFirst()
            .receive(on: RunLoop.main )
            .map{
                EmailStatus in
                switch EmailStatus{
                case .empty:
                    return "Email cannot be empty"
                case .wrongFormat:
                    return "invalid email format"
                case .valid:
                    return ""
                }
            }.assign(to: \.EmailinlineError , on: self )
            .store(in: &cancellables)
    }
    
    
    //model
    enum PasswordStatus{
        case empty
        case tooShort
        case valid
    }
    
    enum EmailStatus{
        case empty
        case wrongFormat
        case valid
    }
 
    
}
