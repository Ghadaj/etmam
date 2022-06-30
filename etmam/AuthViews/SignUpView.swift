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
    var orgVM = orgDatabaseVM()
    var dbUsers = userDatabaseVM()
    @State private var coordinates = CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)
    @State private var showSheet = false
    @State private var isToggle : Bool = false
    @State var hasError = false
    @State var errorMsg = ""
    
    var body: some View {
        
        let locationManager = CLLocationManager()
        NavigationView{
        Form {

                //MARK: - owner info in signUpView
                      Section(header: Text("Owener Account"), footer:
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
                        TextField("First Name", text: $formVM.Fname)
                        TextField("Last Name", text: $formVM.Lname)
                        TextField("Email", text: $formVM.email)
                        SecureField("Password", text: $formVM.password )
                        SecureField("Conforim password", text: $formVM.passwordAgain)
                      }
 
            
            //MARK: -  Org info
            Section(header: Text("Orgnaization Information"),
                    footer:Text(formVM.OrgNameinlineError).foregroundColor(.red).frame(alignment: .leading)) {
                TextField("Org Name", text: $formVM.OrgName)
                
                //MARK: -  get org location
                Toggle(isOn: $isToggle){
                    Text("Oranaization Location")
                }
                if isToggle {
                    
                    if coordinates.longitude == 0.00{
                        HStack{
                            Text("No selected address").foregroundColor(.gray)
                            Spacer()
                            Button("Select location") {
                                self.showSheet.toggle()
                                locationManager.requestAlwaysAuthorization()
                            }
                        }
                    }else{
                        HStack{
                            Text("Riyadh, 1234") // TODO: make it dynamic
                            Spacer()
                            Button("Select location") {
                                self.showSheet.toggle()
                            }
                        }
                        
                    }
                }
            }

            Button("Sign up",  action:{

                let user = User(firstName: formVM.Fname, lastName: formVM.Lname, userJobTitle: "", userPhone: "", userEmail: formVM.email, userPermession: 0, userProjects: [""], userTasks: [""], userMeetings: [""], userImage: "", userLineManger: "",userOrg: "")

                let org = Orgnization(OrgName: formVM.OrgName , Package:"Package" , OrgOwner: "\(Auth.auth().currentUser?.uid)" ,OrgAdmins: [],OrgUsers: [],lat: coordinates.latitude, lng: coordinates.longitude)
                dbUsers.addUserAndOrg(user, formVM.password, org)
             //   UserAuthVM.sharedauthVM.IsSignedIn = true

 
                }
            ).frame(maxWidth: .infinity, alignment:.center).disabled(disableForm)
            
            }
        .navigationTitle("Sign Up")
        .navigationViewStyle(StackNavigationViewStyle())
        
        .sheet(isPresented: $showSheet) {
            NavigationView {
                LocationPicker(instructions: "Tap somewhere to select your coordinates", coordinates: $coordinates)                
                    .navigationTitle("Location Picker")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: Button(action: {
                        self.showSheet.toggle()
                    }, label: {
                        Text("Close").foregroundColor(.red)
                    }))
            }
        }
        }}
    
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
