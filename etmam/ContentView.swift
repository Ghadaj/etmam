////
////  ContentView.swift
////  testFirebase
////
////  Created by Danya T on 02/11/1443 AH.
////
//
//import Foundation
//import SwiftUI
//import Firebase
//import FirebaseFirestoreSwift
//import StoreKit
//struct ContentView: View {
//    
//    // الفاريبلز الي توصلنا للداتابيس
//    @EnvironmentObject var dbOrgs: orgDatabaseVM
//    @EnvironmentObject var dbTasks: taskDatabaseVM
//    @EnvironmentObject var dbProjects: projectDatabaseVM
//    @EnvironmentObject var dbMeetings: meetingDatabaseVM
//    @EnvironmentObject var dbUsers: userDatabaseVM
//    @EnvironmentObject var userAuthVM: UserAuthVM
//    //@Binding var projectID: String
//    @State var package = "no subscription"
//    @State var xx: String = "v"
//    
//    @State var purchased = false
//    @State var tx = "no users"
//    var body: some View {
//        
//        Text(tx)
//        Button("Users"){
//           let  txx = dbOrgs.getMembers()
//            if (0<txx.count){
//            tx = txx[0].firstName ?? "default value"
//            }
//            else{
//                tx = "\(txx.count)"
//            }
//        }
//        
//        
//        
//        
////        Text(tx)
////        Button("Tasks"){
////           let  txx = dbTasks.getTasks("123")
////            if (0<txx.count){
////            tx = txx[0].taskProjectId ?? "default value"
////            }
////            else{
////                tx = "\(txx.count)"
////            }
////        }
//     //  CheckInView()
////        if Auth.auth().currentUser?.uid != nil {
////            Text("user is logged in")
////            Button("Sign-out"){
////                userAuthVM.handleSignout()}
////                Button("Project"){
////
////                    dbProjects.getProject("cLnMtgNGMczTh5yGvAiP")
////                }
////
////
////            }else{
////               // Text("user is not logged in")
////                //SignUpView()
////                SignInView()
////             //user is not logged in
////            }
////        Text(dbUsers.userTasks[1].taskDeadline ?? "no deadline")
//
////        ScrollView{
////        Text("Projects:").padding()
////        ForEach(dbUsers.userProjects, content: makeProjectCellView)
////         //   Text(dbUsers.userProjects[0].projectName ??  "P")
////        }
////        
////        NavigationView{
////     //   BuyView(purchased: $purchased, package: package)
////        NavigationLink(destination: ProjectView(currentProject: dbProjects.getProject("cLnMtgNGMczTh5yGvAiP"))) {
////                           Text("Project")
////                            }
////        }
//        
////        NavigationView{
////     //   BuyView(purchased: $purchased, package: package)
////        NavigationLink(destination: SwiftUIView()) {
////                           Text("Project")
////                            }
////        }
//        
//     //   ProjectView(projectID: "cLnMtgNGMczTh5yGvAiP")
////        Button("update"){
////            dbProjects.updateProject("cLnMtgNGMczTh5yGvAiP", "projectManger.managerID","Test")
////        }
////       Text("Invite user:")
////                        Spacer()
////
////
////        TextField("Placeholder", text: $xx).background(Color.green)
////        Spacer()
////        Button("invite"){
////            let password = generateRandomPassword()
////            let user = User(userName: "", userJobTitle: "", userPhone: "", userEmail: xx, userPermession: 0, userProjects: [""], userTasks: [""], userMeetings: [""], userImage: "", userLineManger: "")
////            dbUsers.addUser(user,password)
////            sendEmail(xx,password)
////        }
//        
////        Button("GetProjects"){
////            ProjectView()
////        }
//        
//    }
//
//    
//    func generateRandomPassword() -> String{
//        let len = 8
//        let pswdChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
//        let rndPswd = String((0..<len).compactMap{ _ in pswdChars.randomElement() })
//        return rndPswd
//    }
//    func sendEmail(_ email: String, _ password: String)  {
//         sleep(1)
//        // prepare json data
//        
//        
//      
//        
//        
//        let json: [String: Any] = ["userEmail": email,
//                                   "userPassword": password,
//                                   "redirectUrl": "https://google.com"]
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        // create post request
//         let serverURL = URL(string: "https://polaris-a73da.web.app/send-custom-verification-email")!
//         var request = URLRequest(url: serverURL)
//         request.httpMethod = "POST"
//         request.httpBody = jsonData
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//         let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                print("send email:\(responseJSON)")
//            }
//        }
//
//        task.resume()
//    
//    }
//    func makeTaskCellView(_ task:  Task) -> some View {
//        //ال unwrapping بسأل عنه الاسبوع الجاي
//        // الmembers مفروض نخزن الids حقتهم جوا الاراي ومنها نجيب الاسماء
//        VStack{
//            
//            Text("Task title: \(task.taskTitle ?? "")")
//            Text("Task creator: \(task.taskCreator ?? "")")
//            Text("For Project: \(task.taskProjectId ?? "")")
//            
//            Text("Task Members:")
//            ForEach(task.taskMembers ?? [""] , id: \.self) { member in
//                Text(member)
//            }
//            
//         //   Text("Task StartDate : \(task.taskStartDate ?? "")")
////            Text("Task Deadline: \(task.taskDeadline ?? "")")
//            
//            Text("Task Attacments:")
//            ForEach(task.taskAttachments ?? [""] , id: \.self) { Attachment in
//                Text(Attachment)
//            }
//            Text("")
//        }
//        
//    }
//    
//    func makeProjectCellView(_ userProjects: Project) -> some View {
//        VStack{
//            Text("Project name: \(userProjects.projectName ?? "N")")
//           // Text("Project description: \(userProjects.projectDesc ?? "D")")
//        }
//    }
//    
//    func makeMeetingCellView(_ meeting: Meeting) -> some View {
//        VStack{
//            Text("Meeting title: \(meeting.meetingTitle ?? "")")
//            Text("Meeting Agenda: \(meeting.meetingAgenda ?? "")")
//            
//        }
//        
//    }
//    
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//
////struct BuyView: View {
////  @Binding var purchased: Bool
////  @State var package: String
////  @ObservedObject var products = ProductsDB.shared
////  var body: some View {
//////      Text("Packages")
//////        .onTapGesture {
//////          IAPManager.shared.getProducts()
//////        }
//////      List {
//////        ForEach((0 ..< self.products.items.count), id: \.self) { column in
//////          Text(self.products.items[column].localizedDescription)
//////            .onTapGesture {
//////              let _ = IAPManager.shared.purchase(product: self.products.items[column])
//////
//////            }
//////        }
//////      }
////      
////      
////      
////      Text("Packages")
////        .onTapGesture {
////            StoreKitManager.sharedInstance.getProducts()
////        }
////      List {
////        ForEach((0 ..< self.products.items.count), id: \.self) { column in
////          Text(self.products.items[column].localizedDescription)
////            .onTapGesture {
////      
////        //        verify(self.products.items[column])
////            let x = StoreKitManager.sharedInstance.purchase(product: self.products.items[column])
////                
////          //    print(products.items[column].productIdentifier)
////
////            }
////        }
////      }
////      
////  }
////}
//
////func verify(_ product: SKProduct) {
////
////    let result = try  StoreKitManager.sharedInstance.purchase(product: product)
////    switch result {
////    case .success(let verificationResult):
////        switch verificationResult {
////        case .verified(let transaction):
////            // Give the user access to purchased content.
////           // ...
////            print("verified")
////            // Complete the transaction after providing
////            // the user access to the content.
////            await transaction.finish()
////        case .unverified(let transaction, let verificationError):
////            // Handle unverified transactions based
////            // on your business model.
////            print ("unverified")
////         //   ...
////        }
////    case .pending:
////        // The purchase requires action from the customer.
////        // If the transaction completes,
////        // it's available through Transaction.updates.
////        print("pending")
////        break
////    case .userCancelled:
////        print("userCancelled")
////        // The user canceled the purchase.
////        break
////    @unknown default:
////        break
////    }}
