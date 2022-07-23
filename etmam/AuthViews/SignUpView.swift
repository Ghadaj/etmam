//
//  SignUpView.swift
//  testFirebase
//
//  Created by Najla Alshehri on 20/06/2022.
//

import Foundation
import SwiftUI
import MapKit
import LocationPicker
import FirebaseStorage
import CoreLocation
import Firebase

struct SignUpView: View {
    @EnvironmentObject var UserAuthVM: UserAuthVM
    @StateObject private var formVM = SignUpFormVM()
    @EnvironmentObject var dbUsers: userDatabaseVM
    

    var orgVM = orgDatabaseVM()
   // var dbUsers = userDatabaseVM()
    @State private var coordinates = CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)
    @State private var showSheet = false
    @State private var isToggle : Bool = false
    @State var hasError = false
    @State var errorMsg = ""
    @State var jobTitle = ""
    var body: some View {
        
        let locationManager = CLLocationManager()
        //NavigationView{
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
                Text("Welcome To Workaday".localized)
                    .foregroundColor(Color("darkBlue"))
                    .font(.system(size: 30))
                    .bold()
                Text("Create your Organization".localized)
                    .foregroundColor(Color.gray)
            }
            .padding(.leading, 25)
        Form {

                //MARK: - owner info in signUpView
            Section(header: Text("Owner Account".localized), footer:
                            VStack(alignment: .leading){
                        if !formVM.EmailinlineError.isEmpty{
                          Text(formVM.EmailinlineError).foregroundColor(.red)
                        }
                        if !formVM.PasswordinlineError.isEmpty{
                          Text(formVM.PasswordinlineError).foregroundColor(.red)
                        }
                        if !formVM.FNameinlineError.isEmpty{
                          Text(formVM.FNameinlineError).foregroundColor(.red)
                        }
                        if !formVM.LNameinlineError.isEmpty{
                          Text(formVM.LNameinlineError).foregroundColor(.red)
                        }
                        if UserAuthVM.hasError{
                          Text("\(UserAuthVM.errorMsg)").foregroundColor(.red)
                            .onAppear {
                              DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                UserAuthVM.errorMsg = ""
                              }
                            }
                        }
                      }){
                          TextField("First Name".localized, text: $formVM.Fname)
                          TextField("Last Name".localized, text: $formVM.Lname)
                          TextField("Email".localized, text: $formVM.email)
                          SecureField("Password".localized, text: $formVM.password )
                          SecureField("Confirm Password".localized, text: $formVM.passwordAgain)
                          TextField("Job Title".localized, text: $jobTitle)
                      }
 
            
            //MARK: -  Org info
            Section(header: Text("Organization Information".localized),
                    footer:Text(formVM.OrgNameinlineError).foregroundColor(.red).frame(alignment: .leading)) {
                TextField("Organization Name".localized, text: $formVM.OrgName)
                
                //MARK: -  get org location
//                Toggle(isOn: $isToggle){
//                    Text("Organization Location".localized)
//                }
//                if isToggle {
//
//                    if coordinates.longitude == 0.00{
//                        HStack{
//                            Text("No selected address".localized).foregroundColor(.gray)
//                            Spacer()
//                            Button("Select location".localized) {
//                                self.showSheet.toggle()
//                                locationManager.requestAlwaysAuthorization()
//                            }
//                        }
//                    }else{
//                        HStack{
//                            Text("Lat: \(coordinates.latitude), Long: \(coordinates.longitude)") // TODO: make it dynamic
//                            Spacer()
//                            Button("Select location".localized) {
//                                self.showSheet.toggle()
//                            }
//                        }
//
//                    }
               // }
            }
            
        }.frame(height:480)
            Button{
                if (!formVM.Fname.isEmpty && !formVM.Lname.isEmpty && !formVM.email.isEmpty && !formVM.password.isEmpty && !formVM.passwordAgain.isEmpty && !formVM.OrgName.isEmpty){
                
                let user = User(firstName: formVM.Fname, lastName: formVM.Lname, userJobTitle: "", userPhone: "", userEmail: formVM.email, userPermession: 0, userProjects: [""], userTasks: [""], userMeetings: [""], userImage: "", userLineManger: "",userOrg: "")

                let org = Orgnization(OrgName: formVM.OrgName , Package:"Package" , OrgOwner: "" ,OrgAdmins: [],OrgUsers: [],lat: coordinates.latitude, lng: coordinates.longitude)
                CreateUserAndOrg(user: user, password: formVM.password, org: org)
             
                goAuth()
            }
              
            }label: {
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
                NavigationLink(destination:  LogIn()){
                    Text("Have an Organization? Sign In".localized).font(.system(size: 16))
                        .foregroundColor(.blue).padding(.horizontal).multilineTextAlignment(.center)
                
            }
                Spacer()
            }
            
        }.navigationBarHidden(true)
        .sheet(isPresented: $showSheet) {
            NavigationView {
                LocationPicker(instructions: "Tap somewhere to select your coordinates".localized, coordinates: $coordinates)
                    .navigationTitle("Location Picker")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: Button(action: {
                        self.showSheet.toggle()
                    }, label: {
                        Text("Close".localized).foregroundColor(.red)
                    }))
            }
        }
        //}
        
    }
    
    var disableForm: Bool {
        (formVM.email.isEmpty || formVM.password.isEmpty)
        ||
        (formVM.passwordAgain.isEmpty || formVM.OrgName.isEmpty)
        ||
        (coordinates.longitude == 0.0 && isToggle)
        ||
        (!formVM.EmailinlineError.isEmpty || !formVM.PasswordinlineError.isEmpty )
    }
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

func goAuth() {
   
  //  userDatabaseVM().currentUserID = Auth.auth().currentUser?.uid ??  "noUser"
//userVM.currentOrgID = org.documentID
    UserAuthVM.sharedauthVM.IsSignedIn = true

    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: AuthView().environmentObject(UserAuthVM()).environmentObject(meetingDatabaseVM()).environmentObject(orgDatabaseVM()).environmentObject(projectDatabaseVM()).environmentObject(taskDatabaseVM()).environmentObject(userDatabaseVM())
        )
        window.makeKeyAndVisible()
    }
    
//    if let window = UIApplication.shared.windows.first {
//        window.makeKeyAndVisible()
//    }
}

func CreateUserAndOrg(user: User, password: String, org: Orgnization){
    var dbUsers = userDatabaseVM()
    dbUsers.addUserAndOrg(user, password, org){
     (success) -> Void in
         if success {
             goAuth()

    }}
}
