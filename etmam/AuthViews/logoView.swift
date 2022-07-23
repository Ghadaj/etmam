//
//  logoView.swift
//  testFirebase
//
//  Created by raghda on 05/12/1443 AH.
//

import SwiftUI
import MapKit

struct logoView: View {
    @EnvironmentObject var userAuthVM: UserAuthVM
    @State private var showingSheet = false
    @State private var email = ""
    @State private var password = ""
    @StateObject private var formVM = SignInFormVM()
    var body: some View {
//        if (!userAuthVM.userSignedOut){
//           Onboarding()}
        NavigationView{
        ZStack{
            VStack{
                Spacer()
                        Image("logo")
                            .resizable().frame(width: 250, height: 250)
                
                VStack(spacing:10){

                NavigationLink(destination: LogIn()){
                    ZStack{
                    Rectangle()
                            .cornerRadius(8)
                            .frame(height: 50, alignment: .center)
                            .padding(.horizontal)
                                .foregroundColor(Color("pink"))
                        Text("Sign In".localized).bold().font(.system(size: 20))
                            .foregroundColor(Color.white)

                    }

                }
                NavigationLink(destination: SignUpView()){
                    ZStack{
                    Rectangle()
                            .cornerRadius(8)
                            .frame(height: 50, alignment: .center)
                            .padding(.horizontal)
                                .foregroundColor(Color("blue"))
                        Text("Create Organization".localized).bold().font(.system(size: 20))
                            .foregroundColor(Color.white)

                    }

                }

                }

                Spacer().frame(height: 200)
            }

            }
            
        }
       
    }
    var disableForm: Bool {
        (formVM.email.isEmpty || formVM.password.isEmpty)
        ||
        (!formVM.EmailinlineError.isEmpty || !formVM.PasswordinlineError.isEmpty )
    }
}







struct logoView_Previews: PreviewProvider {
    static var previews: some View {
        logoView()
    }
}



struct LogIn: View{
    @EnvironmentObject var userAuthVM: UserAuthVM
    @State private var showingSheet = false
    @State private var email = ""
    @State private var password = ""
    @StateObject private var formVM = SignInFormVM()
//    init(){
//           UITableView.appearance().backgroundColor = .clear
//       }
    @State var value = ""
    var body: some View{

        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack{
            VStack(alignment: .leading){
                HStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .padding(.bottom, -40)
                }
                .padding(.trailing)
                VStack(alignment: .leading){
                    Text("Welcome Back".localized)
                        .foregroundColor(Color("darkBlue"))
                        .font(.system(size: 30))
                        .bold()

                        
                    Text("Sign In To Continue".localized)
                        .foregroundColor(Color.gray)
                }
                .padding(.leading, 25)
                Form{

                    Section(footer:
                                
                                VStack(alignment:.leading){
                        Button("Forget Password?".localized,
                               action:{
                            showingSheet.toggle()
                        }).frame(maxWidth: .infinity, alignment:.leading).foregroundColor(Color("blue")).font(.system(size: 16))
                            .sheet(isPresented: $showingSheet) {
                                ResetPasswordView()
                            }
                        if !formVM.PasswordinlineError.isEmpty{
                            Text(formVM.PasswordinlineError).foregroundColor(.red)
                        }
                        if !formVM.EmailinlineError.isEmpty{
                            Text(formVM.EmailinlineError).foregroundColor(.red)
                        }
                        
//                        if userAuthVM.hasError{
//                            Text("\(userAuthVM.errorMsg)").foregroundColor(.red)
//                                .onAppear {
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                        userAuthVM.errorMsg = ""
//                                    }
//                                }
//                        }
                    }
                    )
                    
                    {
                        TextField("Email".localized, text: $formVM.email)
                        SecureField("Password".localized, text: $formVM.password )
                    }


                }.frame(height:205)
                
                Button{
                    userAuthVM.signIn(email: formVM.email, password: formVM.password)
                }label: {
                    ZStack{
                    Rectangle()
                        .cornerRadius(8)
                        .frame(height: 50, alignment: .center)
                        .padding(.horizontal)
                        .foregroundColor(Color("pink"))
                        Text("Sign In".localized).bold().font(.system(size: 20))
                        .foregroundColor(Color.white)
                }
                }
                

            }
                
                NavigationLink(destination: SignUpView()){
                    Text("Don't Have an Organization? Create One".localized).font(.system(size: 16))
                        .foregroundColor(.blue).padding(.horizontal).multilineTextAlignment(.center)
                }
            }
        }
        .navigationBarHidden(true)
     
    }
    var disableForm: Bool {
        (formVM.email.isEmpty || formVM.password.isEmpty)
        ||
        (!formVM.EmailinlineError.isEmpty || !formVM.PasswordinlineError.isEmpty )
    }
  
}
