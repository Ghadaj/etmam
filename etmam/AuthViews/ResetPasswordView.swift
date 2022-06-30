//
//  ResetPasswordView.swift
//  testFirebase
//
//  Created by Najla Alshehri on 20/06/2022.
//

import Foundation
import SwiftUI

struct ResetPasswordView : View{
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var UserAuthVM: UserAuthVM
    @StateObject private var formVM = SignInFormVM()
    @State private var email = ""
    @State private var showingAlert = false
    
  var body: some View {
      NavigationView{
      
      Form{
          Section(header: Text("Email"),footer:
                      VStack(alignment:.leading){
              
              if !formVM.EmailinlineError.isEmpty{
                  Text(formVM.EmailinlineError).foregroundColor(.red)
              }
              
              if !UserAuthVM.resetErrorMsg.isEmpty {
                  Text("\(UserAuthVM.resetErrorMsg)").foregroundColor(.red)
                      .onAppear {
                      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                          UserAuthVM.resetErrorMsg = ""
                      }
                  }
              }
          }
          ){
              
              TextField("Email", text: $formVM.email)
          }
          
          
          Button("Reset password") {
              UserAuthVM.resetPassword(email: formVM.email){
                  (success) -> Void in
                      if success {
                          showingAlert = true
                          UserAuthVM.hasError = false
                      }
              }
          }.disabled(disableForm).frame(maxWidth: .infinity, alignment:.center)
      }
      .navigationBarTitle(Text("Reset password"), displayMode: .inline)
      .navigationBarItems(trailing: Button(action: {
                        
          dismiss()
                     }) {
                         Text("close").bold()
                     }).alert("Check your email to reset your password", isPresented: $showingAlert) {
                         Button("OK", role: .cancel) {
                             dismiss()
                         }
                     }
      }
             
      
  }
    var disableForm: Bool {
        formVM.email.isEmpty || (!formVM.EmailinlineError.isEmpty)
    }
        
}
