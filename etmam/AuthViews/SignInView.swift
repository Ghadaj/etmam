//
//  SignView.swift
//  testFirebase
//
//  Created by Najla Alshehri on 06/06/2022.
//

import SwiftUI

struct SignInView : View{
    @EnvironmentObject var UserAuthVM: UserAuthVM
    @State private var showingSheet = false
    @State private var email = ""
    @State private var password = ""
    @StateObject private var formVM = SignInFormVM()
    
    var body: some View {
        
        Form{
            Section( header: Text("Account information"),footer:
                        VStack(alignment:.leading){
                if !formVM.PasswordinlineError.isEmpty{
                    Text(formVM.PasswordinlineError).foregroundColor(.red)
                }
                if !formVM.EmailinlineError.isEmpty{
                    Text(formVM.EmailinlineError).foregroundColor(.red)
                }
                
                if UserAuthVM.hasError{
                    Text("\(UserAuthVM.errorMsg)").foregroundColor(.red)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                UserAuthVM.errorMsg = ""
                            }
                        }
                }
            }
            ){
                TextField("Email", text: $formVM.email)
                SecureField("Password", text: $formVM.password )
            }
            Section(footer: Button("Forget Password?",
                                   action:{
                showingSheet.toggle()
            }).frame(maxWidth: .infinity, alignment:.center)
                        .sheet(isPresented: $showingSheet) {
                ResetPasswordView()
            }
            ){
                Button("Sign In", action:{
                    UserAuthVM.signIn(email: formVM.email, password: formVM.password)
                }).navigationTitle("Sign in").frame(maxWidth: .infinity, alignment:.center).disabled(disableForm)
            }
        }
    }
    var disableForm: Bool {
        (formVM.email.isEmpty || formVM.password.isEmpty)
        ||
        (!formVM.EmailinlineError.isEmpty || !formVM.PasswordinlineError.isEmpty )
    }
}
