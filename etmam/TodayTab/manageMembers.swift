//
// ContentView.swift
// Searchable
//
// Created by Haya Saleem Alhawiti on 14/11/1443 AH.
//
import SwiftUI
struct manageMembers: View {
@EnvironmentObject var dbOrg: orgDatabaseVM
  @State var searchingFor = ""
  
  @State private var images = ["pic"]
  @State private var jobTitle = ["Ui/ Ux"]
  
  // @State private var currentNumber = 1
//  let member : User
 // let jobrole = ""
  var body: some View {
      let y = dbOrg.getMembers()

      List {
          if results.isEmpty{
             Text("The Orgnaization have no Users")
          }
          else {
          ForEach(results.indices, id: \.self) { index in
              if let id = results[index].id {
                  var userName = "\(results[index].firstName as! String) \(results[index].lastName as! String)"
                  HStack{
                  Image(uiImage: imageWith(name: userName)!).resizable().frame(width: 35, height: 35)
                  Text(userName).foregroundColor(Color("text"))
                  }
                  }
              }
          }}
      .searchable(text: $searchingFor)
      .navigationTitle("Manage Users").navigationBarTitleDisplayMode(.inline)
      .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            EditButton().foregroundColor(Color("blue"))
        }
   // .navigationBarHidden(true)
  }
    var results : [User] {

        if  searchingFor.isEmpty {
            
            return dbOrg.orgMembers
        }else {

            return dbOrg.orgMembers.filter { ($0.firstName?.contains(searchingFor))! as Bool }
        }
    }
//  func removeRows(at offsets: IndexSet) {
//    users.remove(atOffsets: offsets)
//  }
  }
struct manageMembers_Previews: PreviewProvider {
  static var previews: some View {
    manageMembers()
  }
}
