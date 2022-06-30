//
//  Today.swift
//  calenderSwift
//
//  Created by Danya T on 24/11/1443 AH.
//

import SwiftUI
import UniformTypeIdentifiers

struct AddEmployeeSheet : View {
  // @Binding var selectedDate: Date
  //for the text inputs
  @State private var name: String = "Employee Name"
  @State private var email: String = "Example@example.com"
  @State private var choice = 0
  @Binding var showSheetView: Bool
  var body : some View{
    NavigationView{
      VStack{
        if choice == 0{
          ImportMnual(showSheetView: $showSheetView)
        }
        if choice == 1{
          ImportCsv(showSheetView: $showSheetView)
        }
        }
      .navigationBarTitle("Add Members", displayMode: .inline)
      .toolbar{
        ToolbarItem(placement: .cancellationAction ){
            Button(action:{showSheetView = false}) {
              Text("Cancel").foregroundColor(Color("blue"))
            }
        }
        ToolbarItem(placement: .principal){
            Picker(selection: self.$choice, label: Text("Pick One")) {
              Text("Manual").tag(0).onTapGesture {
                choice = 0
              }
              Text("Import").tag(1).onTapGesture {
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


struct Today: View {
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    
    @State var privilage : [String] = ["Owner", "Admin", "Emplyee"]
    @State var packages : [String] = ["Essentials", "Profissionals", "Customized"]
    
    @State var userType = "Admin"
    @State var userSubscription = "Essentials"
    @State var showSheetView = false
    
    private let calendar = Calendar(identifier: .gregorian)
    
    
    var body: some View {
       // ZStack{
           
            ScrollView{
//VStack
        VStack{
            
            //Header -> greeting + profile button
            
            
            HStack {
//                      VStack(spacing:5) {
            //              first phrase- should it be navigation title?
                                    Text(greetingLogic())
                                      .font(.largeTitle)
                                      .fontWeight(.bold)
//                                      .padding(.leading, -25.0)
                                    //2nd phrase
              Spacer()
                        
//                          .padding(.leading, -25.0)
//                      }//end of Vstack
                              Button(action: {
                                }) {
                                  NavigationLink(destination: calendarTab() ) {
                                    Image(systemName: "person.crop.circle") .font(.largeTitle)
                                      .foregroundColor(Color("blue"))                                  }
                                }.padding(.leading,30)
                      //
            }
//            .padding(.horizontal, 7)
            Spacer()
            //____________condtions for diff privilages begin from here
            
            
            //if____________________________________________________________________
                      if userType == "Owner" || userType == "Admin" && userSubscription == "Essentials" {
                      HStack {
                        Text("Permissions")
                          .font(.title2)
                          .fontWeight(.bold)
                          .padding(.trailing, 210.0)
                      }
                    HStack (spacing:16){
                      Button(action: {
            //            self.showSheetView.toggle()
                        self.showSheetView.toggle()
                      }) {
                        VStack(spacing:9) {
                          Image(systemName: "person.badge.plus").padding(.top, 9.0)
                          Text("Add member")
                        }
                      }
                      .frame(width: 164, height:109 )
                      .foregroundColor(.white)
                      .background(Color("orange"))
                      .cornerRadius(8).shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
                        
                      Button(action: {}) {
                        NavigationLink(destination: manageMembers()) {
                          VStack {
                            ZStack {
                              Image(systemName: "person.3").padding(.trailing, 0.0)
                              Image(systemName: "slider.horizontal.3") .padding(.init(top: 15, leading: 35, bottom: 0, trailing: 0))
                            }
                            Text("Manage member")
                          }
                        }
                      }
                      .frame(width: 164, height:109 )
                      .foregroundColor(.white)
                      //          .background(Color(red: 0.67, green: 0.196, blue: 0.214))
                      .background(Color("pink"))
                      .cornerRadius(8).shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
//                      Spacer()
//                      Spacer()
//                      Divider()
                    }//end of Hstack
                    
                    }//end of condition 1
            
            
            
            
            //______________________________________________________________
                       else if userType == "Owner" || userType == "Admin" && userSubscription == "Profissionals" {
                         Button(action: {
                           }) {
                         ZStack{
                              Rectangle()
                               .foregroundColor(Color.white)
                               .cornerRadius(8)
                               .frame(width: 344, height: 56)
                               .shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
                              HStack{
                               ZStack{
                                Image(systemName: "hand.point.up")
                                 .font(.system(size: 32, weight: .regular ))
                                 .foregroundColor(Color("purple"))
                                Circle()
                                 .foregroundColor(Color.white)
                                 .frame(width: 19, height: 19)
                                 .padding([.top, .leading], 20.0)
                                Image(systemName: "arrow.right.circle.fill")
                                 .font(.system(size: 16, weight: .regular))
                                 .foregroundColor(Color("blue"))
                                 .padding([.top, .leading], 20.0)
                               }
                               VStack(alignment: .leading){
                                Text("You must check-in before 08:00 am")
                                 .font(.system(size: 16))
                                 .foregroundColor(Color("blue"))
                                Text("Tap here to check-out")
                                 .font(.system(size: 16))
                                 .foregroundColor(Color.gray)
                               }
                              }
                             }
                           }
                         Spacer()
                         Spacer()
                         Spacer()
                         HStack {
                           Text("Permissions")
                             .font(.title2)
                             .fontWeight(.bold)
                             .padding(.trailing, 210.0)
                         }
                         HStack (spacing:16){
                         Button(action: {
                           self.showSheetView.toggle()
                         }) {
                           VStack(spacing:9) {
                             Image(systemName: "person.badge.plus").padding(.top, 9.0)
                             Text("Add member")
                           }
                         }
                         .frame(width: 109, height:109 )
                         .foregroundColor(.white)
                         .background(Color("orange"))
                         .cornerRadius(8).shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
                         Button(action: {}) {
                           NavigationLink(destination: manageMembers()) {
                             VStack {
                               ZStack {
                                 Image(systemName: "person.3").padding(.trailing, 0.0)
                                 Image(systemName: "slider.horizontal.3") .padding(.init(top: 15, leading: 35, bottom: 0, trailing: 0))
                               }
                               Text("Manage member")
                             }
                           }
                         }
                         .frame(width: 109, height:109 )
                         .foregroundColor(.white)
                         //          .background(Color(red: 0.67, green: 0.196, blue: 0.214))
                         .background(Color("pink"))
                         .cornerRadius(8).shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
                         Button(action: {
               //            self.showSheetView.toggle()
                         }) {
                           VStack(spacing:9) {
                             Image(systemName: "text.badge.checkmark").padding(.top, 9.0)
                             Text("Attendance")
                           }
                         }
                         .frame(width: 109, height:109 )
                         .foregroundColor(.white)
                         .background(Color("blue"))
                         .cornerRadius(8).shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
                       }//end of Hstack
                         
                       Spacer()
                       Spacer()
                       Divider()
                      }//end of condition 2
            //_____________________________________________________________
            else if  userType == "Owner" || userType == "Admin" &&  userSubscription == "Profissionals" {
            
                Button(action: {
                     }) {
                ZStack{
                          Rectangle()
                            .foregroundColor(Color.white)
                            .cornerRadius(8)
                            .frame(width: 344, height: 56)
                            .shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
                          HStack{
                            ZStack{
                              Image(systemName: "hand.point.up")
                                .font(.system(size: 32, weight: .regular ))
                                .foregroundColor(Color("purple"))
                              Circle()
                                .foregroundColor(Color.white)
                                .frame(width: 19, height: 19)
                                .padding([.top, .leading], 20.0)
                              Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color("blue"))
                                .padding([.top, .leading], 20.0)
                            }
                            VStack(alignment: .leading){
                              Text("You must check-in before 08:00 am")
                                .font(.system(size: 16))
                                .foregroundColor(Color("blue"))
                              Text("Tap here to check-out")
                                .font(.system(size: 16))
                                .foregroundColor(Color.gray)
                            }
                          }
                        }
                     }
                Spacer()
                Spacer()
            
            }
                      
                      else if userType == "Employee" || userType == "Admin" && userSubscription == "Essentials" {
                          Spacer()
                          Spacer()
                          Spacer()
                        //nothing for the normal employee
                      }
      //  }//upper part VStack
           //___________________________________________________
            
            
//            Divider()
           
            Text("Today's Tasks").fontWeight(.bold).font(.system(size: 22)).padding(.trailing, 200.0)
            
            // for showing meetings cells for today
            ForEach(dbMeetings.meetings.indices, id: \.self) {index in
                if  calendar.isDateInToday( dbMeetings.meetings[index].meetingCreatedDate ?? Date()){
                   
                        MakeMeetingCell2(meeting: dbMeetings.meetings[index])
                        
                        
                }
                
            }
            
            
            
            
            // for showing tasks cells for  today
            ForEach(dbTasks.tasks.indices, id: \.self) {index in
                if  dbTasks.tasks[index].taskDeadline != nil  &&  calendar.isDateInToday(dbTasks.tasks[index].taskDeadline ?? Date())  && dbTasks.tasks[index].taskStatus
                != "Done"{
                   
        
                        MakeTaskCell2(task: dbTasks.tasks[index], isDeadlineToday: true)
                        
                    
                    
                }else if calendar.isDateInToday(dbTasks.tasks[index].taskStartDate ?? Date()){
                  
                    
                    MakeTaskCell2(task: dbTasks.tasks[index])
                    
                }
                
            
            }
                Divider()
            Text("Incomplete Tasks").fontWeight(.bold).font(.system(size: 22)).padding(.trailing, 160.0)
            
            ForEach(dbMeetings.meetings.indices, id: \.self) {index in
                if !calendar.isDateInToday(dbMeetings.meetings[index].meetingCreatedDate ?? Date()) &&
                 dbMeetings.meetings[index].meetingCreatedDate ?? Date() < Date() &&  dbMeetings.meetings[index].meetingStatus != "Done"{
                   
                        MakeMeetingCell2(meeting: dbMeetings.meetings[index])
                        
                    }
                }
                
            
            ForEach(dbTasks.tasks.indices, id: \.self) {index in
                if !calendar.isDateInToday(dbTasks.tasks[index].taskStartDate ?? Date()) &&
                      dbTasks.tasks[index].taskStatus != "Done"  {
                    
                    if dbTasks.tasks[index].taskDeadline != nil  && calendar.isDateInToday(dbTasks.tasks[index].taskDeadline ?? Date()){
                        
                        
                    }else if  dbTasks.tasks[index].taskDeadline != nil  &&  dbTasks.tasks[index].taskDeadline ?? Date() < Date()
                              {
                                  MakeTaskCell2(task: dbTasks.tasks[index], isDeadlineToday: true)
                        
                    }
                    else if dbTasks.tasks[index].taskStartDate ?? Date() < Date(){
                        MakeTaskCell2(task: dbTasks.tasks[index])
                    }
                }
            }
            
            
            
//
//            Spacer()
//
//
            
            
            
        }.padding()
//        .padding(.leading, 5)
            }.background(Color("BackgroundColor"))
       // }
        .sheet(isPresented: $showSheetView) {
              AddEmployeeSheet(showSheetView: self.$showSheetView)
        }
        .navigationBarHidden(true)
    }
}


//________this fucntion is for the time based greeting_______________
func greetingLogic() -> String {
  let hour = Calendar.current.component(.hour, from: Date())
  let NEW_DAY = 0
  let NOON = 12
  let SUNSET = 18
  let MIDNIGHT = 24
  var greetingText = NSLocalizedString("Hello", comment: "c")// Default greeting text
  switch hour {
  case NEW_DAY..<NOON:
    greetingText = NSLocalizedString("Good Morning", comment: "")
  case NOON..<SUNSET:
    greetingText = NSLocalizedString("Good Afternoon", comment: "n")
  case SUNSET..<MIDNIGHT:
    greetingText = NSLocalizedString("Good Evening", comment: "n")
  default:
    _ = NSLocalizedString("Hello", comment: "c")
  }
  return greetingText
}

//_____Import structs_____

struct ImportCsv : View{
  @State private var document: CSVDocument = CSVDocument(contentOfFile: "")
  @State private var isImporting: Bool = false
  @State private var isExporting: Bool = false
  struct UserInfo: Hashable {
    var name : String
    var email : String
  }
  @State var useresArray : [UserInfo] = []
 @Binding var showSheetView: Bool
  var body: some View{
    ZStack{
      Color("BackgroundColor").ignoresSafeArea()
    VStack{
      if useresArray.isEmpty{
        Spacer().frame( height: 80 )
        Image("import").resizable().frame(width: 230, height: 200)
        Text("Import .csv file containg Member Name, and Email columns. ").font(.title2)
          .foregroundColor(.gray)
          .multilineTextAlignment(.center)
          .padding()
      }else{
        Form {
          Section(header: Text("Members"),footer: Text("send emails")){
          ForEach(self.useresArray, id: \.self){ user in
            VStack(alignment: .leading){
              Text(user.name)
              Text(user.email).foregroundColor(.gray).font(.callout)
            }
           }
         }
        }
       }
      Spacer()
      Button(action: { isImporting.toggle()}) {
        HStack {
          Image(systemName: "square.and.arrow.down.fill")
          Text("Import")
        }  .frame(width: 356, height:54 )
          .foregroundColor(.white)
          .background(Color("blue"))
          .cornerRadius(8)
          .padding(.bottom, 10)
       }
      }
      }.fileImporter(
        isPresented: $isImporting,
        allowedContentTypes: [UTType.content],
        allowsMultipleSelection: false
      ) { result in
        do {
          guard let selectedFile: URL = try result.get().first else { return }
          guard selectedFile.startAccessingSecurityScopedResource() else { return }
          let filePath = URL (fileURLWithPath: "\(NSHomeDirectory())/Documents/\(selectedFile.lastPathComponent)")
          try? FileManager.default.copyItem(at: selectedFile, to: filePath)
          guard let contentOfFile = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
          let rows = contentOfFile.components(separatedBy: "\n")
          for row in rows {
            let columns = row.components(separatedBy: ",")
            if columns.count >= 2{
            let userInfo = UserInfo(name: columns[0], email: columns[1])
            self.useresArray.append(userInfo)
            }
          }
          self.useresArray.remove(at: 0)
          print(self.useresArray)
          document.contentOfFile = contentOfFile
          selectedFile.stopAccessingSecurityScopedResource()
        } catch {
          Swift.print(error.localizedDescription)
        }
    }.toolbar{
      ToolbarItem(placement: .confirmationAction){
        Button(action:{
          //databse work(sending invitations)
          if !useresArray.isEmpty{
            showSheetView = false}}
        ) {
          Text("Add").foregroundColor(useresArray.isEmpty ? .gray: Color("blue"))
        }
      }
    }
  }
}
struct ImportMnual : View{
  @State private var name: String = ""
  @State private var email: String = ""
  @State private var jobTitle: String = ""
  @State private var directManager: String = ""
//  @State private var directManagerPic: Image = ""
  @State private var permissions: String = ""
  @Binding var showSheetView: Bool
  var body: some View{
    Form{
      Section(header: Text("Member Information")){
      TextField("Name", text: $name)
      TextField("Email", text: $email)
      TextField("Job Title", text: $jobTitle)
      }
      Section(){
        NavigationLink(destination:Mangers(selectedManger: $directManager)){
        HStack{
          Text("Direct Manager:")
//          Image("profilePic").resizable().frame(width: 36, height: 36).clipShape(Circle())
          Text(directManager)
//            .foregroundColor(Color("blue"))
        }
        }
      }
        Permissions(selectedPermission: $permissions)
      }
  .toolbar{
    ToolbarItem(placement: .confirmationAction){
      Button(action:{
        //databse work(sending invitations)
        if name != "" && email != ""{
          showSheetView = false}}
      ) {
        Text("Add").foregroundColor( name != "" && email != "" ? Color("blue"): .gray)
      }
    }
  }
  }
}
struct Mangers: View {
 @Binding var selectedManger : String
 let mangers = ["M s", "N D", "A S"]
 @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
 var body: some View {
  List{
   ForEach(mangers, id:\.self){ manger in
    Button(action: {selectedManger = manger}) {
     HStack {
       Image(systemName: "person.crop.circle").frame(width: 40, height:40)
      Text(manger).foregroundColor(.black)
      if manger == selectedManger {
       Spacer()
       Image(systemName: "checkmark")
      }
     }
    }
   }
  }
   .navigationBarTitle("Mangers",displayMode: .inline)
 }
}
struct Permissions: View {
 @Binding var selectedPermission : String
  let permissions = ["Owner", "Admin", "Employee"]
  let description = ["Owner..","Admin..","Employee.."]
  @State var desc = ""
 @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
 var body: some View {
  List{
    Section(header:Text("Permessions"),footer: Text(desc)){
      ForEach(0..<permissions.count, id:\.self){ i in
    Button(action: {selectedPermission = permissions[i]
             desc = description[i]
    }) {
     HStack {
      Text(permissions[i]).foregroundColor(.black)
      if permissions[i] == selectedPermission {
       Spacer()
       Image(systemName: "checkmark")
      }
     }
    }
   }
  }
 }
}
}


