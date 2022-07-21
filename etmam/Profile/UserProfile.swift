//
//  UserProfile.swift
//  calenderSwift
//
//  Created by Sara AlMezeini on 07/12/1443 AH.
//

import SwiftUI


struct UserProfile: View {
    //@State private var isEditing = false
    @State var mobile = ""
    let userVM = userDatabaseVM()
    @EnvironmentObject var userAuthVM: UserAuthVM
    @State var showStack = false
    @State var firstName = ""
    @State var lastName = ""
    @State var userLM = User(firstName: "nil", lastName: "nil", userJobTitle: "nil", userPhone: "nil", userEmail: "nil", userPermession: 5, userProjects: ["nil"], userTasks: ["nil"], userMeetings: ["nil"], userImage: "nil", userLineManger: "nil", userOrg: "nil")
    func getLM(){
        if (userVM.currentUserProfile.userLineManger != ""){
    userVM.getUserName2(id: userVM.currentUserProfile.userLineManger!){
         (success) -> Void in
             if success {
                 getUser()
                 firstName = userVM.firstName
                 lastName = userVM.lastName
}
    }}}
    
    
    func getUser(){
    userVM.getUser2(userID: userVM.currentUserProfile.userLineManger!){
         (success) -> Void in
             if success {
                 showStack = true
                 userLM = userVM.user

}
    }}
    
    var body: some View {
        let fName = "\(userVM.currentUserProfile.firstName!)"
        let lName = "\(userVM.currentUserProfile.lastName!)"

        let userName = "\(userVM.currentUserProfile.firstName!) \(userVM.currentUserProfile.lastName!)"
        let jobTitle = userVM.currentUserProfile.userJobTitle
        let email = userVM.currentUserProfile.userEmail
        let s = getLM()
        
//        ZStack{
//            Color("BackgroundColor")
//                .ignoresSafeArea()
//            VStack(spacing:10){
//                       ZStack{
//                         Image(uiImage: imageWith(name: "Sara Ahmed")!).resizable().frame(width: 90, height: 90).overlay(Circle().stroke(Color.white, lineWidth: 1))
//                         Image(systemName: "crown.fill").foregroundColor(.yellow).font(.system(size: 20)).padding(.trailing,50).padding(.top, 60)
//                      }
//                       Text(userName).foregroundColor(Color("text")).font(.system(size: 24).bold())
//                       Text(jobTitle ?? "").foregroundColor(.gray).font(.system(size: 20))
//                    }
//                Form{
//                    Section{
//                        HStack{
//                            Image(systemName: "envelope.fill").foregroundColor(Color("blue"))
//                            Text(email)
//                        }
//                        HStack{
//                            Image(systemName: "phone.fill").foregroundColor(Color("blue"))
//                            TextField("Mobile".localized, text: $mobile).disabled(!isEditing)
//                        }
//
//
//                        NavigationLink(destination: MyAccountView()) {
//                            HStack{
//                                Image(systemName: "line.3.horizontal").foregroundColor(Color("blue"))
//                                Text("My Account".localized)
//
//                            }
//                        }
//                        if (userVM.currentUserProfile.userLineManger != ""){
//                            let xx =  getLM()
//
//                    if showStack{
//                              NavigationLink(destination: OtherUsersProfile(user: userLM)) {
//                            HStack{
//                            Image(systemName: "person.fill").foregroundColor(Color("blue"))
//                            Text("Direct Manager".localized)
//                            Spacer()
//
//                                Text("\(firstName) \(lastName)").foregroundColor(.gray)
//                }
//
//                              }
//                        }
//
//                        }}
//                }.onAppear{
//                    mobile = userVM.currentUserProfile.userPhone ?? ""
//                }
//                .hasScrollEnabled(false)
//                    .frame(height:230)
//                HStack{
//                    Button{
//
//                    }label: {
//                        ZStack{
//                            Rectangle()
//                                .foregroundColor(Color("blue"))
//                                .frame(height: 126)
//                                .cornerRadius(10)
//                            VStack(spacing : 10){
//                                Image(systemName:"scale.3d").foregroundColor(.white)
//                                    .font(.system(size: 40))
//                                Text("Organization\nStructure".localized)
//                                    .foregroundColor(.white).font(.system(size: 20))
//                            }
//                        }
//                    }
//                    NavigationLink(destination: personalTasks()){
//                        ZStack{
//                            Rectangle()
//                                .foregroundColor(Color("pink"))
//                                .frame(height: 126)
//                                .cornerRadius(10)
//                            VStack(spacing : 10){
//                                Image(systemName:"clock.arrow.circlepath").foregroundColor(.white)
//                                    .font(.system(size: 40))
//                                Text("Personal\nTasks".localized).foregroundColor(.white).font(.system(size: 20))
//                            }
//                        }
//                    }
//                }.padding()
//
//                Spacer().frame(height:100 )
//                Image("logoSmall").resizable().frame(width:165,height:40).opacity(0.5)
//
//
//            }.navigationTitle("Profile".localized).navigationBarTitleDisplayMode(.inline)
//            .toolbar{
//                ToolbarItem(placement: isEditing ? .confirmationAction : .navigationBarTrailing ){
//                    Button(action: {isEditing.toggle()
//                        if !isEditing{
//                            userVM.currentUserProfile.userPhone = mobile
//                        }
//                    }){
//                        Text(isEditing ? " Done".localized : "Edit".localized).foregroundColor(Color("blue"))
//
//                    }
//                }
//
//            }
//
//        }
        ZStack{
                Color("BackgroundColor")
                    .ignoresSafeArea()
                VStack(spacing : -2){
                    VStack(spacing:10){
                        ZStack{
                            if (userVM.currentUserImg != nil) {
                                Image(uiImage: userVM.currentUserImg!).resizable().frame(width: 90, height: 90).overlay(Circle().stroke(Color.white, lineWidth: 1))}
                            else{
                           Image(uiImage: imageWith(name: userName)!).resizable().frame(width: 90, height: 90).overlay(Circle().stroke(Color.white, lineWidth: 1))}
                            Image(systemName: "crown.fill").foregroundColor(.yellow).font(.system(size: 20)).padding(.trailing,50).padding(.top, 60)
                        }
//                        Text(userName).foregroundColor(Color("text")).font(.system(size: 24).bold())
                        Text("\(fName) \(lName)").foregroundColor(Color("text")).font(.system(size: 24).bold())


                        Text(jobTitle ?? "").foregroundColor(.gray).font(.system(size: 20)).padding(.bottom)
                    }
                    Form{
                        Section{
                            HStack{
                                Image(systemName: "envelope.fill").foregroundColor(Color("blue"))
                                Text(email)
                            }
                            HStack{
                                Image(systemName: "phone.fill").foregroundColor(Color("blue"))
                                TextField("Phone Number".localized, text: $mobile).disabled(true)
                            }
                            
                            
                            NavigationLink(destination: MyAccountView( fName: fName, lName: lName, mobile: mobile)) {
                                HStack{
                                    Image(systemName: "line.3.horizontal").foregroundColor(Color("blue"))
                                    Text("My Account".localized)
                                    
                                }
                            }
                            
                            
                            if showStack{
             
                                NavigationLink(destination: OtherUsersProfile(user: userLM)) {
                                HStack{
                                    Image(systemName: "person.fill").foregroundColor(Color("blue"))
                                    Text("Direct Manager".localized)
                                    Spacer()
                                    Text("\(firstName) \(lastName)").foregroundColor(.gray)
                                }
                                }}
                            
                            
                        }
                    }.onAppear{
                        mobile = userVM.currentUserProfile.userPhone ?? ""
                    }
                    .hasScrollEnabled(false)
                    .frame(height:230)
                    HStack{
                        Button{
                            
                        }label: {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color("blue"))
                                    .frame(height: 126)
                                    .cornerRadius(10)
                                VStack(spacing : 10){
                                    Image(systemName:"scale.3d").foregroundColor(.white)
                                        .font(.system(size: 40))
                                    Text("Organization\nStructure".localized)
                                        .foregroundColor(.white).font(.system(size: 20))
                                }
                            }
                        }
                NavigationLink(destination: personalTasks()){

                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color("pink"))
                                    .frame(height: 126)
                                    .cornerRadius(10)
                                VStack(spacing : 10){
                                    Image(systemName:"clock.arrow.circlepath").foregroundColor(.white)
                                        .font(.system(size: 40))
                                    Text("Personal\nTasks".localized).foregroundColor(.white).font(.system(size: 20))
                                }
                            }
                        }
                    }.padding()
                    
                    Spacer().frame(height:100 )
                    Image("logoSmall").resizable().frame(width:165,height:40).opacity(0.5)
                    
                    
                }.navigationTitle("Profile".localized).navigationBarTitleDisplayMode(.inline)
//                    .toolbar{
//                        ToolbarItem(placement: isEditing ? .confirmationAction : .navigationBarTrailing ){
//                            Button(action: {isEditing.toggle()
//                                if !isEditing{
//                                    userVM.currentUserProfile.userPhone = mobile
//                                }
//                            }){
//                                Text(isEditing ? " Done".localized : "Edit".localized).foregroundColor(Color("blue"))
//
//                            }
//                        }
//
//                    }
                
            }
        }
    }



struct MyAccountView : View {
    let userVM = userDatabaseVM()
    @EnvironmentObject var userAuthVM: UserAuthVM
    @State private var viewModel: Bool = false
    @State var fName = ""
    @State var lName = ""
    @State var mobile = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack{
                Form{
                    Section(header: Text("Information")){
                                TextField("First Name".localized, text: $fName)
                                TextField("Last Name".localized, text: $lName)
                                TextField("Phone Number".localized, text: $mobile)
                    }
                        Section(header: Text("Account")){
                        NavigationLink(destination:  ResetPasswordView()) {
                 
                        Text("Update Password".localized)}
                        Text("Delete Account".localized)
                    }
                }
                .frame(height:380)
                ZStack{
                Button{
                    userAuthVM.handleSignout()
                    goHome()
                }label:{
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("red"))
                            .frame(height:55)
                            .cornerRadius(10)
                        Text("Log Out".localized).foregroundColor(.white).font(.system(size: 16).bold())
                    }
                }   }.padding()
                Spacer()
            
        
            }
        
    }.toolbar{
        ToolbarItem(placement:.confirmationAction){
          Button(action:{
            if fName != "" && lName != "" {
                userVM.currentUserProfile.firstName = fName
                userVM.currentUserProfile.lastName = lName
                userVM.currentUserProfile.userPhone = mobile
                //function call
            }
              presentationMode.wrappedValue.dismiss()
            }) {
              Text("Save".localized).foregroundColor(fName != "" && lName != "" ? Color("blue") :.gray)
          }
        }
       }
    }
}
func goHome() {
    if let window = UIApplication.shared.windows.first {
      //  window.rootViewController = UIHostingController(rootView: AuthView().environmentObject(UserAuthVM()).environmentObject(meetingDatabaseVM()).environmentObject(orgDatabaseVM()).environmentObject(projectDatabaseVM()).environmentObject(taskDatabaseVM()).environmentObject(userDatabaseVM()))
        window.makeKeyAndVisible()
    }
}

struct Package {
    var packageType: String?
    var packagePrice: String?
    var packageDuration: String?
}
struct PackageChoices {
    static var subscriptionPackge: [Package] = [Package(packageType: "Essential", packagePrice: "SAR 99.99", packageDuration: "billed monthly"),
                                                Package(packageType: "Proffessional", packagePrice: "SAR 199.99", packageDuration: "billed monthly"),
                                                Package(packageType: "Customized", packagePrice: "SAR 299.99", packageDuration: "billed monthly")]
}
struct manageSubscriptionSheet : View {
  // @Binding var selectedDate: Date
  //for the text inputs
  @State private var name: String = "Employee Name"
  @State private var email: String = "Example@example.com"
  @State private var choice = 0
  @Binding var showSheetManageSubscriptionView: Bool
  @State var selectedTypePackage : String = ""
  // let TypePackage = ["Essential", "Proffessional", "Customized"]
  @State var TypePackage : [Package] = PackageChoices.subscriptionPackge
  var body : some View{
    NavigationView{
      VStack{
        if choice == 0{
          ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            VStack(spacing: 40){
            HStack(spacing:30
            ) {
              VStack(alignment:.center, spacing:15) {
                Image(systemName: "doc.text.image").font(.system(size: 40))
                  .foregroundColor(Color("Blue1"))
                  .padding(.top, 9.0)
                Text("Create Projects").font(.system(size: 12))
                  .foregroundColor(.black)
              }
              VStack(alignment:.center, spacing:15) {
                Image(systemName: "calendar").font(.system(size: 40))
                  .foregroundColor(Color("Blue1"))
                  .padding(.top, 9.0)
                Text("Calender View").font(.system(size: 12))
                  .foregroundColor(.black)
              }
              VStack(alignment:.center, spacing:20) {
                Image(systemName: "scale.3d").font(.system(size: 40))
                  .foregroundColor(Color("Blue1"))
                  .padding(.top, 20.0)
                VStack(spacing: 5) {
                Text("Organization").font(.system(size: 12))
                  .foregroundColor(.black).multilineTextAlignment(.center)
                Text("Structure").font(.system(size: 12))
                  .foregroundColor(.black)
                }
              }
            }
            HStack(spacing:30
            ) {
              VStack(alignment:.center, spacing:15) {
                Image(systemName: "bell").font(.system(size: 40))
                  .foregroundColor(Color("Blue1"))
                  .padding(.top, 9.0)
                Text("Notification").font(.system(size: 12))
                  .foregroundColor(.black)
              }
              VStack(alignment:.center, spacing:20) {
                Image(systemName: "hand.point.up.left.fill").font(.system(size: 40))
                  .foregroundColor(Color(.lightGray))
                  .padding(.top, 9.0)
                Text("Attendance").font(.system(size: 12))
                  .foregroundColor(.black)
              }.padding(.leading,15)
              VStack(alignment:.center, spacing:10) {
                Image(systemName: "pencil.and.outline").font(.system(size: 40))
                  .foregroundColor(Color(.lightGray))
                  .padding(.top, 15.0)
                Text("Organization").font(.system(size: 12))
                  .foregroundColor(.black).multilineTextAlignment(.center)
              }.padding(.leading,20)
            }.padding(.leading,20)
//              ForEach(TypePackage, id:\.self){ item in
//              HStack (spacing:16){
//
//                Button(action: {Today()}) {
//                  VStack(spacing:15) {
//
//                    Text(item.packageType).foregroundColor(.black).font(.system(size: 12))
//                    Text("SAR 99.99").foregroundColor(.black).font(.system(size: 16 , weight: .bold))
//                    Text("billed monthly").foregroundColor(.black).font(.system(size: 12))
//                  }
//                }.padding(.top,-20)
//                .frame(width: 110, height:142 )
//
//                .background(
//                      RoundedRectangle(cornerRadius: 8)
//                        .fill(Color(.white))
//                        .shadow(color: .gray, radius: 0.6, x: 0, y: 0.1)
//    //                    .blur(radius: 1)
//                  )
//
//
//
//                Button(action: {}) {
//                  VStack(spacing:15) {
//                    Text("Proffessional").foregroundColor(.black).font(.system(size: 12))
//                    Text("SAR 199.99").foregroundColor(.black).font(.system(size: 16 , weight: .bold))
//                    Text("billed monthly").foregroundColor(.black).font(.system(size: 12))
//                }
//                }.padding(.top,-20)
//                .frame(width: 110, height:142 )
//
//                .background(
//                      RoundedRectangle(cornerRadius: 8)
//                        .fill(Color(.white))
//                        .shadow(color: .gray, radius: 0.6, x: 0, y: 0.1)
//    //                    .blur(radius: 1)
//                  )
//
//                Button(action: {Today()}) {
//                  VStack(spacing:15) {
//
//                    Text("Customized").foregroundColor(.black).font(.system(size: 12))
//                    Text("SAR 299.99").foregroundColor(.black).font(.system(size: 16 , weight: .bold))
//                    Text("billed monthly").foregroundColor(.black).font(.system(size: 12))
//                  }
//                }.padding(.top,-20)
//                .frame(width: 110, height:142 )
//
//                .background(
//                      RoundedRectangle(cornerRadius: 8)
//                        .fill(Color(.white))
//                        .shadow(color: .gray, radius: 0.6, x: 0, y: 0.1)
//    //                    .blur(radius: 1)
//                  )
//              }
//              }//end of buttons HStack
          }//end of Vstack
          }
        }
        if choice == 1{
          ImportCsv(showSheetView: $showSheetManageSubscriptionView)
        }
        }
      .navigationBarTitle("Add Members", displayMode: .inline)
      .toolbar{
        ToolbarItem(placement: .cancellationAction ){
            Button(action:{ showSheetManageSubscriptionView = false}) {
              Text("Cancel").foregroundColor(Color("Blue1"))
            }
        }
        ToolbarItem(placement: .principal){
            Picker(selection: self.$choice, label: Text("Pick One")) {
              Text("Monthly").tag(0).onTapGesture {
                choice = 0
              }
              Text("Annual").tag(1).onTapGesture {
                choice = 1
              }
            }
            .frame(width: 180,height: 40)
            .pickerStyle(SegmentedPickerStyle())
            }
        }
      }
  }
}



struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile().environmentObject(UserAuthVM())
    }
}



