import Foundation
import SwiftUI
import Firebase
import FirebaseStorage
import PDFKit
struct ProjectFilesView: View {
  @State var filesUrls : [String]
  @State var isShowingFileView: Bool = false
  @State var isShowingPDFView: Bool = false
  @State var selectedUrl: URL?
  @State var editMode: Bool = false
  @State var newUrls : [URL]
  @State var fileText = ""
  var body: some View {
    NavigationView{
    ScrollView(.vertical, showsIndicators: false) {
      SearchBar1(text: $fileText)
        .padding(.horizontal).padding(.bottom)
        .navigationTitle("Files")
        .onAppear(){
          Firestore.firestore().collection("Projects").document("IAIA0gx9JIrvsXfpYaGa").getDocument { doucment, error in
            if let error = error {
              print("error:\(error.localizedDescription)")
            } else {
              if let document = doucment {
                let data = (document.data()?["files"] as! Array<String>)
                for i in data{
                  self.filesUrls.append(i)
                }
                newUrls = castUrls(arr: filesUrls)
              }
            }
          }
        }
        .toolbar {
          ToolbarItem(placement: .primaryAction) {
            if editMode{
              Button {
                editMode=false
              } label: {
                Text("DONE")
              }
            }else
            {
              Menu {
                Section {
                  Button(action: {
                    editMode.toggle()
                  }) {
                    Label("Delete file", systemImage: "trash").foregroundColor(.red)
                  }.disabled(filesUrls.isEmpty)
                  Button(action: {
                    isShowingFileView.toggle()
                  }) {
                    Label("New File", systemImage: "folder")
                  }
                }
              }
            label: {
              Label("More", systemImage: "ellipsis.circle")
            }
            }
          }
        }
      LazyVGrid(columns: columns , spacing: 20) {
        ForEach(newUrls.filter({$0.lastPathComponent.lowercased().contains(fileText.lowercased()) || fileText.isEmpty}), id:\.self) { fileUrl in
          if editMode {
            Button(action: {
              selectedUrl = fileUrl
              isShowingPDFView.toggle()
            }, label: {
              VStack{
                Image(fileImage(extensionFile: fileUrl.pathExtension))
                  .resizable()
                  .scaledToFill()
                  .frame(width: 77, height: 99)
                Text(fileUrl.lastPathComponent).lineLimit(1)
                  .font(.system(size: 12, weight: .semibold, design: .rounded))
                  .fixedSize(horizontal: false, vertical: true)
                  .foregroundColor(.black)
                  .frame(width: 77)
              }
            })
              .overlay(
                Button(action: {
                  withAnimation {
                    if let deletedDoc = newUrls.firstIndex(of: fileUrl){
                      newUrls.remove(at: deletedDoc)
                    }
                  }
                }, label: {
                  Image(systemName: "xmark.circle")
                    .foregroundColor(.red)
                    .font(.system(size: 20))
                }).padding(.top, -12)
                  .padding(.trailing, -10)
                , alignment: .topTrailing
              )
              .padding()
              .padding(.horizontal, 18)
          }else{
            Button(action: {
              selectedUrl = fileUrl
              isShowingPDFView.toggle()
            }, label: {
              VStack{
                Image(fileImage(extensionFile: fileUrl.pathExtension))
                  .resizable()
                  .scaledToFill()
                  .frame(width: 77, height: 99)
                Text(fileUrl.lastPathComponent).lineLimit(1)
                  .font(.system(size: 12, weight: .semibold, design: .rounded))
                  .fixedSize(horizontal: false, vertical: true)
                  .foregroundColor(.black)
                  .frame(width: 77)
              }
            })
          }
        }
      }
    }.background(Color("BackgroundColor"))
        .fileImporter(isPresented: $isShowingFileView,
               allowedContentTypes: [.item, .pdf],
               allowsMultipleSelection: true) { result in
          switch result {
          case .success(let urls):
            for url in urls {
              newUrls.append(url)
              uploadFilesToStorage(fileUrlStrings: newUrls)
            }
          case .failure(let error):
            print("error while uploading url file, \(error)")
          }
        }.sheet(isPresented: $isShowingPDFView) {
          if let selectedUrl = selectedUrl {
            PDFKitRepresentedView(convertPDFToData(url: selectedUrl), singlePage: true)
          }
        }
    }
  }
  func fileImage(extensionFile: String) -> String {
    switch extensionFile {
    case "pdf":
      return "pdf"
    case "txt":
      return "txt"
    case "doc":
      return "word"
    case "mp3":
      return "audio"
    case "mp4":
      return "video"
    case "png", "jpeg" , "jpg":
      return "image"
    default:
      return "data"
    }
  }
  @State var columns = [
    GridItem.init(.flexible()),
    GridItem.init(.flexible()),
    GridItem.init(.flexible()),
  ]
  func convertPDFToData(url: URL) -> Data {
    do {
      return try Data(contentsOf: url)
    } catch {
      return Data()
    }
  }
}
struct SearchBar1 : View {
  @Binding var text : String
  @State private var isEditing = false
  var body: some View{
    HStack{
      TextField("Search here...", text: $text)
        .padding(5)
        .padding(.horizontal,35)
        .background(.white)
        .foregroundColor(.black)
        .cornerRadius(8)
        .overlay(
          HStack{
            Image(systemName: "magnifyingglass")
              .foregroundColor(.gray)
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
              .padding(.leading,15)
            if isEditing {
              Button(action: {
                self.text = ""
              }, label: {
                Image(systemName: "multiply.circle.fill")
                  .foregroundColor(.gray)
                  .padding(.trailing,8)
              })
            }
          }).onTapGesture {
            self.isEditing = true
          }
      if isEditing{
        Button(action: {
          self.isEditing = false
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }) {
          Text("Cancel")
        }
        .padding(.trailing,10)
        .transition(.move(edge:.trailing))
        .animation(.default)
      }
    }
  }
}
func castUrls(arr :[String]) -> [URL]{
  var urls :[URL] = []
  for i in arr{
    if let v = URL(string: i){
    urls.append(v)
    print("url : \(String(describing: v))")
    }
  }
  return urls
}
func deleteFile(){
  // delete from collection and storage
}
