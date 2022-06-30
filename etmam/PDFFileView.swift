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
// For Firebase
func uploadFilesToStorage(fileUrlStrings: [URL]){
  // var currentUser = CurrentUser(documents:[""])
  // guard let userId = UserAuthVM.sharedauthVM.auth.currentUser?.uid
  //currentUser?.uid
  // else {return}
  for fileUrl in fileUrlStrings {
    let fileName: String = UUID().uuidString
    // TODO: replace file name with project id
    let ref = Storage.storage().reference(withPath: "projects" + "/" + fileName + "/" + fileUrl.lastPathComponent)
    ref.putFile(from: fileUrl) { storageMetadata, error in
      if let error = error {
        print("DEBUG: error while uploading image \(error)")
        return
      }
      ref.downloadURL { imageUrl, error in
        if let error = error {
          print("DEBUG: error while uploading image \(error)")
          return
        }
        guard let fileUtrString = imageUrl?.absoluteString else {return}
        print("DEBUG: Successfully uploaded profile \(fileUtrString)")
        //currentUser.documents.append(fileUtrString)
        // store file link in collection
        //try? db.collection("Your collection").document(userId).setData(from: currentUser)
      }
    }
  }
}









