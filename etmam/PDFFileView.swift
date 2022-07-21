import SwiftUI
import Firebase
import FirebaseStorage
import PDFKit
struct PDFKitRepresentedView: UIViewRepresentable {
  typealias UIViewType = PDFView
  let data: Data
  let singlePage: Bool
  init(_ data: Data, singlePage: Bool = false) {
    self.data = data
    self.singlePage = singlePage
  }
  func makeUIView(context _: UIViewRepresentableContext<PDFKitRepresentedView>) -> UIViewType {
    // Create a `PDFView` and set its `PDFDocument`.
    let pdfView = PDFView()
    pdfView.document = PDFDocument(data: data)
    pdfView.autoScales = true
    if singlePage {
      pdfView.displayMode = .singlePageContinuous
    }
    return pdfView
  }
  func updateUIView(_ pdfView: UIViewType, context _: UIViewRepresentableContext<PDFKitRepresentedView>) {
    pdfView.document = PDFDocument(data: data)
    //uploadFilesToStorage(fileUrlStrings: filesUrls)
  }
}
//// For Firebase
//func uploadFilesToStorage(fileUrlStrings: [URL], completion: @escaping (_ success: Bool) -> Void) -> [String]{
//  // var currentUser = CurrentUser(documents:[""])
//  // guard let userId = UserAuthVM.sharedauthVM.auth.currentUser?.uid
//  //currentUser?.uid
//    var Urls: [String] = []
//  // else {return}
//  for fileUrl in fileUrlStrings {
//    let fileName: String = UUID().uuidString
//    // TODO: replace file name with project id
//    let ref = Storage.storage().reference(withPath: "projects" + "/" + fileName + "/" + fileUrl.lastPathComponent)
//    // ref.putFile(from: fileUrl)
//    ref.putFile(from: fileUrl) { storageMetadata, error in
//        if let error = error as NSError?{
//           print("Error Error ")
//        }else{
//            DispatchQueue.main.async {
//       
////      if let error = error {
////        print("DEBUG: error while uploading image \(error)")
////        return
////      }
//      ref.downloadURL { imageUrl, error in
//        if let error = error {
//          print("DEBUG: error while uploading image \(error)")
//          return
//        }
//        guard let fileUtrString = imageUrl?.absoluteString else {return}
//          Urls.append(fileUtrString)
//        print("DEBUG: Successfully uploaded profile \(fileUtrString)")
//        //currentUser.documents.append(fileUtrString)
//        // store file link in collection
//        //try? db.collection("Your collection").document(userId).setData(from: currentUser)
//      }
////        ref.downloadURL { imageUrl, error in
////          if let error = error {
////            print("DEBUG: error while uploading image \(error)")
////            return
////          }
////          guard let fileUtrString = imageUrl?.absoluteString else {return}
////          print("DEBUG: Successfully uploaded profile \(fileUtrString)")
////          //currentUser.documents.append(fileUtrString)
////          // store file link in collection
////          //try? db.collection("Your collection").document(userId).setData(from: currentUser)
////
//            }
//            }
//    }
//  }
//    return Urls
//}



//
//
//func addUserAndOrg(_ user:User,_ password: String, _ org: Orgnization, completion: @escaping (_ success: Bool) -> Void) {
//
//       //Add user to Auth
//       do{
//           Auth.auth().createUser(withEmail: user.userEmail, password: password){ authResult, error in
//               if let error = error as NSError?{
//                  print("Error Error ")
//               }else{
//                   DispatchQueue.main.async {
//                       do {
//                   var newOrg = org
//                   newOrg.OrgOwner = Auth.auth().currentUser?.uid ?? ""
//                   let org =  try self.dbUsers.collection("Organizations").addDocument(from: newOrg)
//                   let newUSer = user
//                   newUSer.userOrg = org.documentID
//                   var _ = try self.dbUsers.collection("Users").document(Auth.auth().currentUser?.uid ?? "").setData(from: newUSer)
//
//                    org.updateData([
//                       "OrgUsers": FieldValue.arrayUnion([Auth.auth().currentUser!.uid])
//                   ])
//                   self.currentUserID = Auth.auth().currentUser?.uid ??  "noUser"
//                   self.currentOrgID = org.documentID
//                //   self.loadData()
//                //   self.getUserProfile()
//                   completion(true)
//                //   UserAuthVM.sharedauthVM.IsSignedIn = true
//                       }
//                       catch {
//                           print("Error creating user")
//                       }
//               }
//
//
//           }
//       }
//        if (Auth.auth().currentUser?.uid != nil){
//        currentUserID = Auth.auth().currentUser!.uid
//        loadData()
//            getUserProfile()
//
//        }
  // }
//}





