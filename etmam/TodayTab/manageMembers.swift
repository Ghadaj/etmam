//
// ContentView.swift
// Searchable
//
// Created by Haya Saleem Alhawiti on 14/11/1443 AH.
//
import SwiftUI
struct manageMembers: View {
  @State var searchingFor = ""
  @State private var users = ["Karen Castillo", "Laren Castillo", "Lola Amber", "Sara Ahmed", "Jack Sparrow", "Tony Stark", "Masashi Kishimoto"]
  @State private var images = ["pic"]
  @State private var jobTitle = ["Ui/ Ux"]
  struct User {
    let imageName: String
    let name: String
    let position: String
  }
  let Users = [User(imageName: "pic", name: "Karen Castillo", position: "Ui/Ux")]
  // @State private var currentNumber = 1
//  let member : User
 // let jobrole = ""
  var body: some View {
    List {
      ForEach(results, id: \.self) { user in
        HStack{
          Image("proflePic")
            .resizable()
            .frame(width: 45, height: 45)
            .cornerRadius(100)
            .scaledToFit()
          VStack(alignment: .leading){
            Text(user)
              .bold()
            Text("job Title")
              .foregroundColor(Color.gray)
          }
        }
      }
      .onDelete(perform: removeRows)
    }.searchable(text: $searchingFor)
      .navigationTitle("Manage Members")
//      .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          EditButton()
        }
//    .navigationBarHidden(true)
  }
  var results : [String] {
    if searchingFor.isEmpty {
      return users
    }else {
      return users.filter { $0.contains(searchingFor) }
    }
    }
  func removeRows(at offsets: IndexSet) {
    users.remove(atOffsets: offsets)
  }
  }
struct manageMembers_Previews: PreviewProvider {
  static var previews: some View {
    manageMembers()
  }
}
