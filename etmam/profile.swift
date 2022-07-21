////
////  profile2.swift
////  testFirebase
////
////  Created by Haya Saleem Alhawiti on 20/11/1443 AH.
////
//
//import SwiftUI
//
//
//
//
//struct Package {
//
//    var packageType: String?
//    var packagePrice: String?
//    var packageDuration: String?
//
//}
//struct PackageChoices {
//
//    static var subscriptionPackge: [Package] = [Package(packageType: "Essential", packagePrice: "SAR 99.99", packageDuration: "billed monthly"),
//                                                Package(packageType: "Proffessional", packagePrice: "SAR 199.99", packageDuration: "billed monthly"),
//                                                Package(packageType: "Customized", packagePrice: "SAR 299.99", packageDuration: "billed monthly")]
//
//
//}
//
//struct manageSubscriptionSheet : View {
//    //  @Binding var selectedDate: Date
//    //for the text inputs
//    @State private var name: String = "Employee Name"
//    @State private var email: String = "Example@example.com"
//    @State private var choice = 0
//    @Binding var showSheetManageSubscriptionView: Bool
//    @State var selectedTypePackage : String = ""
//
//   // let TypePackage = ["Essential", "Proffessional", "Customized"]
//    @State var TypePackage : [Package] = PackageChoices.subscriptionPackge
//    var body : some View{
//        NavigationView{
//            VStack{
//
//                if choice == 0{
//
//                    ZStack{
//                        Color("BackgroundColor").ignoresSafeArea()
//                        VStack(spacing: 40){
//
//
//
//                        HStack(spacing:30
//                        ) {
//
//                            VStack(alignment:.center, spacing:15) {
//                                Image(systemName: "doc.text.image").font(.system(size: 40))
//                                    .foregroundColor(Color("Blue1"))
//                                    .padding(.top, 9.0)
//                                Text("Create Projects").font(.system(size: 12))
//                                    .foregroundColor(.black)
//                            }
//
//                            VStack(alignment:.center, spacing:15)  {
//                                Image(systemName: "calendar").font(.system(size: 40))
//                                    .foregroundColor(Color("Blue1"))
//                                    .padding(.top, 9.0)
//                                Text("Calender View").font(.system(size: 12))
//                                    .foregroundColor(.black)
//                            }
//
//                            VStack(alignment:.center, spacing:20)  {
//                                Image(systemName: "scale.3d").font(.system(size: 40))
//                                    .foregroundColor(Color("Blue1"))
//                                    .padding(.top, 20.0)
//                                VStack(spacing: 5) {
//                                Text("Organization").font(.system(size: 12))
//                                    .foregroundColor(.black).multilineTextAlignment(.center)
//                                Text("Structure").font(.system(size: 12))
//                                    .foregroundColor(.black)
//                                }
//                            }
//
//
//                        }
//
//                        HStack(spacing:30
//                        ) {
//
//                            VStack(alignment:.center, spacing:15) {
//                                Image(systemName: "bell").font(.system(size: 40))
//                                    .foregroundColor(Color("Blue1"))
//                                    .padding(.top, 9.0)
//                                Text("Notification").font(.system(size: 12))
//                                    .foregroundColor(.black)
//                            }
//
//                            VStack(alignment:.center, spacing:20)  {
//                                Image(systemName: "hand.point.up.left.fill").font(.system(size: 40))
//                                    .foregroundColor(Color(.lightGray))
//                                    .padding(.top, 9.0)
//                                Text("Attendance").font(.system(size: 12))
//                                    .foregroundColor(.black)
//                            }.padding(.leading,15)
//
//                            VStack(alignment:.center, spacing:10)  {
//                                Image(systemName: "pencil.and.outline").font(.system(size: 40))
//                                    .foregroundColor(Color(.lightGray))
//                                    .padding(.top, 15.0)
//                                Text("Organization").font(.system(size: 12))
//                                    .foregroundColor(.black).multilineTextAlignment(.center)
//
//                            }.padding(.leading,20)
//
//
//                        }.padding(.leading,20)
////                            ForEach(TypePackage, id:\.self){  item in
////                            HStack (spacing:16){
////
////                                Button(action: {Today()}) {
////                                    VStack(spacing:15) {
////
////                                        Text(item.packageType).foregroundColor(.black).font(.system(size: 12))
////                                        Text("SAR 99.99").foregroundColor(.black).font(.system(size: 16 , weight: .bold))
////                                        Text("billed monthly").foregroundColor(.black).font(.system(size: 12))
////                                    }
////                                }.padding(.top,-20)
////                                .frame(width: 110, height:142 )
////
////                                .background(
////                                            RoundedRectangle(cornerRadius: 8)
////                                                .fill(Color(.white))
////                                                .shadow(color: .gray, radius: 0.6, x: 0, y: 0.1)
////        //                                        .blur(radius: 1)
////                                    )
////
////
////
////                                Button(action: {}) {
////                                    VStack(spacing:15) {
////                                        Text("Proffessional").foregroundColor(.black).font(.system(size: 12))
////                                        Text("SAR 199.99").foregroundColor(.black).font(.system(size: 16 , weight: .bold))
////                                        Text("billed monthly").foregroundColor(.black).font(.system(size: 12))
////                                }
////                                }.padding(.top,-20)
////                                .frame(width: 110, height:142 )
////
////                                .background(
////                                            RoundedRectangle(cornerRadius: 8)
////                                                .fill(Color(.white))
////                                                .shadow(color: .gray, radius: 0.6, x: 0, y: 0.1)
////        //                                        .blur(radius: 1)
////                                    )
////
////                                Button(action: {Today()}) {
////                                    VStack(spacing:15) {
////
////                                        Text("Customized").foregroundColor(.black).font(.system(size: 12))
////                                        Text("SAR 299.99").foregroundColor(.black).font(.system(size: 16 , weight: .bold))
////                                        Text("billed monthly").foregroundColor(.black).font(.system(size: 12))
////                                    }
////                                }.padding(.top,-20)
////                                .frame(width: 110, height:142 )
////
////                                .background(
////                                            RoundedRectangle(cornerRadius: 8)
////                                                .fill(Color(.white))
////                                                .shadow(color: .gray, radius: 0.6, x: 0, y: 0.1)
////        //                                        .blur(radius: 1)
////                                    )
////                            }
////                            }//end of buttons HStack
//
//
//                    }//end of Vstack
//                    }
//
//
//                }
//                if choice == 1{
//                    ImportCsv(showSheetView: $showSheetManageSubscriptionView)
//
//
//                }
//                }
//
//            .navigationBarTitle("Add Members", displayMode: .inline)
//            .toolbar{
//                ToolbarItem(placement: .cancellationAction ){
//
//                        Button(action:{ showSheetManageSubscriptionView = false}) {
//                            Text("Cancel").foregroundColor(Color("Blue1"))
//                        }
//                }
//                ToolbarItem(placement: .principal){
//                        Picker(selection: self.$choice, label: Text("Pick One")) {
//                            Text("Monthly").tag(0).onTapGesture {
//                                choice = 0
//                            }
//                            Text("Annual").tag(1).onTapGesture {
//                                choice = 1
//                            }
//                        }
//
//                        .frame(width: 180,height: 40)
//                        .pickerStyle(SegmentedPickerStyle())
//
//                        }
//
//                }
//            }
//    }
//}
//
//
//
//
//
//
//
//struct ShowSheetAdmin : View {
//
//    //  @Binding var selectedDate: Date
//    //for the text inputs
//
//    @State private var choice = 0
//    @Binding var showSheetView: Bool
//
//    @State private var firstName: String = ""
//    @State private var lastName: String = ""
//    @State private var jobTitle: String = ""
//
//    @State var image: UIImage? = UIImage (named: "CEOPic")
//    @State var IsPickerShowing = false
//     @State var shouldShowImagePicker = false
//
//
//
//    var body : some View{
//        NavigationView{
//            VStack {
//
//
//                Form{
//
//
//                    Section{
//                            ZStack{
//                              Button {
//                                shouldShowImagePicker.toggle()
//                              } label: {
//                                VStack {
//                                  if let image = self.image {
//                                    Image(uiImage: image)
//                                      .resizable()
//                                      .scaledToFill()
//                                      .frame(width: 128, height: 128)
//                                      .cornerRadius(64)
//                                  } else {
//                                    Image("DefaultProfilePic")
//                                      .resizable()
//                                      .scaledToFill()
//                                      .frame(width: 128, height: 128)
//                                      .cornerRadius(64)
//                                  }
//                                }
//                                .overlay(RoundedRectangle(cornerRadius: 64)
//                                      .stroke(Color.black, lineWidth: 0)
//                                )
//                              }
//                              Circle()
//                                .trim(from:0.1 , to: 0.5).frame(width: 128, height: 128).rotationEffect(.degrees(-18))
//                                .opacity(0.5)
//                              Text("Edit Image").foregroundColor(.white).padding(.top, 100).padding(.bottom)
//                            }
//                          }.listRowInsets(.init())
//                        .listRowBackground(Color.clear).frame(maxWidth: .infinity, alignment:.center)
//
//
//                    Section {
//                    TextField("First Name", text: $firstName)
////                        .frame(width: 350, height: nil)
////                        .textFieldStyle(.roundedBorder)
////                        .background(Color.white)
////                        .cornerRadius(5)
////                        .padding(.vertical)
//                    }.listStyle(.plain)
//
//                    Section {
//                    TextField("Last Name", text: $lastName)
////                        .frame(width: 350, height: nil)
////                        .textFieldStyle(.roundedBorder)
////                        .background(Color.white)
////                        .cornerRadius(5)
////                        .padding(.vertical)
//                    }.listStyle(.plain)
//
//                    Section {
//
//                    TextField("Job Title ", text: $jobTitle)
////                        .frame(width: 350, height: nil)
////                        .textFieldStyle(.roundedBorder)
////                        .background(Color.white)
////                        .cornerRadius(5)
////                        .padding(.vertical)
//                    }.listStyle(.plain)
//
//
//                    Section(header: Text("Contact Info")){
//
//  VStack(spacing: 2){
//                            HStack(spacing:10){
//             Image(systemName: "envelope.circle.fill")
//                   .font(.system(size: 25.0))
//                   .foregroundColor(Color("Blue1"))
//                    Text("Email")
//                  // .padding()
//                    Text("IarenC@gmail.com")
//                        .padding()
//                       }//end H1
//                      Divider()
//                    .frame(width: 299)
//                        HStack{
//            Image(systemName: "phone.circle.fill")
//                   .font(.system(size: 25.0))
//                   .foregroundColor(Color("Blue1"))
//                    Text("Mobile")
//
//                    Text("+966 502266881")
//                    .foregroundColor(.blue)
//                    .padding()
//                        }//end H2
//                     .frame(width: 344, height: 52)
//                     .cornerRadius(10.0)
//
//                        }
//                    }
//
//
//
//
//
//                }
//
//                }
//            }
//        .navigationBarTitle("Add Members", displayMode: .inline)
//        .toolbar{
//            ToolbarItem(placement: .cancellationAction ){
//
//                    Button(action:{showSheetView = false}) {
//                        Text("Cancel").foregroundColor(Color("Blue1"))
//                    }
//            }
//
//            }
//        }
//    }
//
//
//
//
//
//
//struct profile: View {
//    @State private var showingStatusOptions = false
//    @State private var showingStatusOptions2 = false
//    @State private var locationState = "onsite"
//    @State private var locationState_icon = ""
//    @State private var accountState = "state"
//    @State private var accountState_icon = ""
//    @State var showSheetView = false
//    let userVM = userDatabaseVM()
//
//
//    @State var showSheetManageSubscriptionView = false
//    var body: some View {
//
//      //  VStack { when needed
//
//                ZStack{
//                    Color("BackgroundColor").ignoresSafeArea()
//                    ZStack{
//
//                        Image(uiImage: userVM.currentUserImg)
//                            .resizable()
//                            .frame(width: 89, height: 89)
//                            .clipShape(Circle())
//                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
//                        Circle()
//                            .stroke(Color.white, lineWidth: 1)
//                            .frame(width: 101, height: 101)
//                        Circle()
//                            .trim(from: 0.0, to: 0.1 )
//                            .stroke(Color("GreenColor"), lineWidth: 4)
//                            .frame(width: 106, height: 106, alignment: .leading)
//                            .rotationEffect(Angle(degrees: -60.88))
//                        Circle()
//                            .trim(from: 0.0, to: 0.1 )
//                            .stroke(Color("GreenColor"), lineWidth: 4)
//                            .frame(width: 106, height: 106, alignment: .leading)
//                            .rotationEffect(Angle(degrees: 120.88))
//
//
//                       // VStack(){
//
//                      //  } .padding(.top,-25)
//                    }.padding(.top,-360)
//
//
//                    let userName = "\(userVM.currentUserProfile.firstName!) \(userVM.currentUserProfile.lastName!)"
//
//                    VStack(spacing: 5){
//                        Text(userName).font(.system(size: 25)).fontWeight(.semibold)
//                        let jobTitle = userVM.currentUserProfile.userJobTitle
//                        Text (jobTitle!).font(.system(size: 20)).fontWeight(.light).foregroundColor(.gray)
//
//
//
//                    }.padding(.top,-245)
//                       //two buttons start
//
//                        HStack(spacing:16){
//                        //first button
//                        Button(action: {
//                            showingStatusOptions = true
//                        }){
//                        HStack {
//                            Image(systemName: locationState_icon).resizable().frame(width: 20, height: 20).padding(.leading, 8.0)
//                            Text(locationState).font(.system(size:16)).foregroundColor(Color.gray)
//                        }.frame(width: 100, height: 30, alignment: .leading).overlay(
//                            RoundedRectangle(cornerRadius: 18)
//                                .stroke(Color.gray, lineWidth: 0.1).shadow(color: Color.gray, radius: 0.5, x: 0, y: 0.1).blur(radius: 0.5))
//                        }.confirmationDialog("Location:", isPresented: $showingStatusOptions, titleVisibility: .visible) {
//
//                            Button("Onsite") {
//
//                                locationState = "Onsite"
//                                locationState_icon = "mappin.circle.fill"
//                            }
//                            Button("Online") {
//
//                                locationState = "Online"
//                                locationState_icon = "mappin.circle.fill"
//                            }
//                            Button("Cancel",role: .cancel) {
//
//                                locationState = "Location"
//                            }.foregroundColor(Color.red)
//                        }
//
//
//                        //second button
//                        Button(action: {
//                            showingStatusOptions2 = true
//                        }){
//                        HStack {
//
//                            Image(systemName: accountState_icon).resizable().frame(width: 20, height: 20).padding(.leading, 8.0)
//                            Text(accountState).font(.system(size:16)).foregroundColor(Color.gray)
//                        }.frame(width: 100, height: 30, alignment: .leading).overlay(
//                            RoundedRectangle(cornerRadius: 18)
//                                .stroke(Color.gray, lineWidth: 0.1).shadow(color: Color.gray, radius: 0.5, x: 0, y: 0.1).blur(radius: 0.5))
//                        }.confirmationDialog("Status", isPresented: $showingStatusOptions2, titleVisibility: .visible) {
//
//                            Button("Active") {
//
//                                accountState = "Active"
//                                accountState_icon = "checkmark.circle.fill"
//                            }
//                            Button("Offline") {
//
//                                accountState = "Offline"
//                                accountState_icon = "minus.circle.fill"
//                            }
//                            Button("Away") {
//
//                                accountState = "Away"
//                                accountState_icon = "clock.fill"
//                            }
//                            Button("Cancel",role: .cancel) {
//
//                                accountState = "Status"
//                            }.foregroundColor(Color.red)
//                        }
//
//
//
//                        //two buttons end
//
//
//
//
//                        }.padding(.top,-170)
//
//
//                    Button(action: { self.showSheetManageSubscriptionView.toggle() }) {
//
//                       // HStack(spacing:25){
//                            HStack(spacing:130){
//                                Text("Manage Subscription").foregroundColor(Color.black)
//
//                            Image(systemName: "chevron.forward")
//                            }
//
//                    // }
//                        .frame(width: 344, height:60 )
//
//                                            .background(
//                                                        RoundedRectangle(cornerRadius: 8)
//                                                            .fill(Color.white)
//                                                            .shadow(color: .gray, radius: 0.6, x: 0, y: 0.1)
//                                                            .blur(radius: 1)
//                                                )
//                    }.padding(.bottom,185)
//
//                    //}
//                    //______2 Buttons
//
//
//                    HStack (spacing:16){
//
//                        Button(action: {Today()}) {
//                            VStack(spacing:15) {
//                                Image(systemName: "scale.3d").font(.system(size: 40))
//                                    .foregroundColor(Color.white)
//                                    .padding(.top, 9.0)
//                                Text("Organization Structure").foregroundColor(.white)
//                            }
//                        }
//                        .frame(width: 164, height:126 )
//
//                        .background(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(Color("orange"))
//                                        .shadow(color: .gray, radius: 0.6, x: 0, y: 0.1)
////                                        .blur(radius: 1)
//                            )
//
//
//
//                        Button(action: {}) {
//                            VStack(spacing:15) {
//                                    Image(systemName: "clock.arrow.circlepath")
//                                    .font(.system(size: 40))
//                                    .padding(.init(top: 9, leading: 0, bottom: 0, trailing: 0))
//
//                                Text("History").foregroundColor(.white)
//                            }
//                        }
//                        .frame(width: 164, height:126 )
//                        .foregroundColor(Color.white)
//
//                        .background(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(Color("pink"))
//                                        .shadow(color: .gray, radius: 0.6, x: 0, y: 0.1)
////                                        .blur(radius: 1)
//                            )
//
//                    }.padding(.top,40)
//                    //------- end 2 buttons
//
//                    //_______________
//
//
//                    List{
//
//  VStack(spacing: 2){//remove it if you want a bigger space for the list
//                            HStack(spacing:10){
//             Image(systemName: "envelope.circle.fill")
//                   .font(.system(size: 25.0))
//                   .foregroundColor(Color("Blue1"))
//                    Text("Email")
//                  // .padding()
//                                let email = userVM.currentUserProfile.userEmail
//                    Text(email)
//                        .padding()
//                       }//end H1
//                      Divider()
//                    .frame(width: 299)
//                        HStack{
//            Image(systemName: "phone.circle.fill")
//                   .font(.system(size: 25.0))
//                   .foregroundColor(Color("Blue1"))
//                    Text("Mobile")
//                            let phone = userVM.currentUserProfile.userPhone
//                    Text(phone!)
//                    .foregroundColor(.blue)
//                    .padding()
//                        }//end H2
//                     .frame(width: 344, height: 52)
//                     .cornerRadius(10.0)
//
//                        }
//                    }
//                    .onAppear(perform: {
//                          UITableView.appearance().contentInset.top = -35
//                      })
//                        .padding(.init(top:470 , leading: 00, bottom: 00, trailing: 00))
//
//
//
//                    Button(action: { self.showSheetView.toggle()
//                       }){
//                           Text("Logout")
//                            .font(.headline)
//                            .foregroundColor(Color("pink"))
//                            .fontWeight(.regular)
//                            .padding()
//                            .frame(width: 344, height: 52)
//                            .background(.white)
//                           .cornerRadius(10.0) }
//                       .padding(.top,590)
//
//                }
//                .sheet(isPresented: $showSheetView) {
//                    ShowSheetAdmin(showSheetView: self.$showSheetView)
//                }
//                .sheet(isPresented: $showSheetManageSubscriptionView) {
//                    manageSubscriptionSheet(showSheetManageSubscriptionView: self.$showSheetManageSubscriptionView)
//                }
//       // }
//                .navigationBarTitle("", displayMode: .inline)
//
//                .toolbar{
//                  ToolbarItem(placement: .navigationBarTrailing ){
//                  HStack {
//                    Button(action:{self.showSheetView.toggle()}) {
//                      Text("Edit").foregroundColor(Color("Blue1"))
//                    }
//                  }
//                  }
//                }
//
//
//
//
//
//    }
//}
//
//struct profile_Previews: PreviewProvider {
//    static var previews: some View {
//        profile()
//    }
//}
