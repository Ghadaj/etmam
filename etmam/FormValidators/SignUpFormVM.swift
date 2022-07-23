//
//  SignUpFormVM.swift
//  testFirebase
//
//  Created by Najla Alshehri on 14/06/2022.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Combine



let db = Firestore.firestore()

class SignUpFormVM: ObservableObject{
    @Published var Fname = ""
    @Published var Lname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    @Published var OrgName = ""
    @Published var isValid = false
    @Published var PasswordinlineError = ""
    @Published var EmailinlineError = ""
    @Published var OrgNameinlineError = ""
    @Published var FNameinlineError = ""
    @Published var LNameinlineError = ""
    @Published var cancellables =  Set<AnyCancellable>()
    
   //password must contains characters and one special characters and is minimum six char long.
   // let passwordCheck = NSPredicate(format: "SELF MATCHES %@",  "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
    let passwordCheck = NSPredicate(format: "SELF MATCHES %@",  "^(?=.*[a-z]).{6,}$")

    let emailCheck = NSPredicate(format: "SELF MATCHES %@",  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    
    private var IsFNameEmptyPublisher: AnyPublisher<Bool, Never>{
        $Fname.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    
    private var IsLNameEmptyPublisher: AnyPublisher<Bool, Never>{
        $Lname.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    
    private var IsFNameValidLengthPublisher: AnyPublisher<Bool, Never>{
        $Fname.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.count > 2
            }.eraseToAnyPublisher()
    }
    
    private var IsLNameValidLengthPublisher: AnyPublisher<Bool, Never>{
        $Lname.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.count > 2
            }.eraseToAnyPublisher()
    }
    
    
    private var IsOrgNameEmptyPublisher: AnyPublisher<Bool, Never>{
        $OrgName.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    
    private var IsOrgNameValidLengthPublisher: AnyPublisher<Bool, Never>{
        $OrgName.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.count > 2
            }.eraseToAnyPublisher()
    }
  
    private var IsEmailVaildFormatPublisher: AnyPublisher<Bool, Never>{
        $email.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                self.emailCheck.evaluate(with: $0)
            }.eraseToAnyPublisher()
    }
    
    private var IsEmailEmptyPublisher: AnyPublisher<Bool, Never>{
        $email.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    
    private var IsPasswordEmptyPublisher: AnyPublisher<Bool, Never>{
        $password.debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates().map{
                $0.isEmpty
            }.eraseToAnyPublisher()
    }
    
    private var IsPasswordMatchPublisher: AnyPublisher<Bool, Never>{
        Publishers.CombineLatest($password , $passwordAgain)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map{ $0 == $1 }
            .eraseToAnyPublisher()
    }
    
    private var IsPasswordStrongPublisher: AnyPublisher<Bool, Never>{
        $password.debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{ self.passwordCheck.evaluate(with: $0) }
            .eraseToAnyPublisher()
    }
    
    private var IsPasswordVaildPublisher: AnyPublisher<PasswordStatus, Never>{
        Publishers.CombineLatest3(IsPasswordEmptyPublisher, IsPasswordStrongPublisher ,IsPasswordMatchPublisher)
            .map{
                if $0  { return PasswordStatus.empty }
                if !$1 { return PasswordStatus.weakPassword }
                if !$2 { return PasswordStatus.doesntMatch }
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
    
    private var IsOrgNameVaildPublisher: AnyPublisher<OrgNameStatus, Never>{
        Publishers.CombineLatest(IsOrgNameEmptyPublisher , IsOrgNameValidLengthPublisher)
            .map{
                if $0  { return OrgNameStatus.empty }
                if !$1 { return OrgNameStatus.tooShort }
                return OrgNameStatus.valid
            }.eraseToAnyPublisher()
    }
    
    private var IsFNameVaildPublisher: AnyPublisher<FNameStatus, Never>{
        Publishers.CombineLatest(IsFNameEmptyPublisher , IsFNameValidLengthPublisher)
            .map{
                if $0  { return FNameStatus.empty }
                if !$1 { return FNameStatus.tooShort }
                return FNameStatus.valid
            }.eraseToAnyPublisher()
    }
    
    private var IsLNameVaildPublisher: AnyPublisher<LNameStatus, Never>{
        Publishers.CombineLatest(IsLNameEmptyPublisher , IsLNameValidLengthPublisher)
            .map{
                if $0  { return LNameStatus.empty }
                if !$1 { return LNameStatus.tooShort }
                return LNameStatus.valid
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
                case .weakPassword:
                    return "password is too weak"
                case .doesntMatch:
                    return "password doesnt match"
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
        
        IsOrgNameVaildPublisher
            .dropFirst()
            .receive(on: RunLoop.main )
            .map{
                OrgNameStatus in
                switch OrgNameStatus{
                case .empty:
                    return "Orgnaization name cannot be empty"
                case .tooShort:
                    return "Org Name is too short"
                case .valid:
                    return ""
                }
            }.assign(to: \.OrgNameinlineError , on: self )
            .store(in: &cancellables)
        
        IsFNameVaildPublisher
            .dropFirst()
            .receive(on: RunLoop.main )
            .map{
                FNameStatus in
                switch FNameStatus{
                case .empty:
                    return "First Name cannot be empty"
                case .tooShort:
                    return "First Name is too short"
                case .valid:
                    return ""
                }
            }.assign(to: \.FNameinlineError , on: self )
            .store(in: &cancellables)
        
        IsLNameVaildPublisher
            .dropFirst()
            .receive(on: RunLoop.main )
            .map{
                LNameStatus in
                switch LNameStatus{
                case .empty:
                    return "Last Name cannot be empty"
                case .tooShort:
                    return "Last Name is too short"
                case .valid:
                    return ""
                }
            }.assign(to: \.LNameinlineError , on: self )
            .store(in: &cancellables)
    }
    
    //model
    enum PasswordStatus{
        case empty
        case weakPassword
        case doesntMatch
        case valid
    }
    
    enum EmailStatus{
        case empty
        case wrongFormat
        case valid
    }
    
    enum OrgNameStatus{
        case empty
        case tooShort
        case valid
    }
    
    enum FNameStatus{
        case empty
        case tooShort
        case valid
    }
    
    enum LNameStatus{
        case empty
        case tooShort
        case valid
    }

}
