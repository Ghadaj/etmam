//
//  Today.swift
//  calenderSwift
//
//  Created by Danya T on 24/11/1443 AH.
//


import SwiftUI
import UniformTypeIdentifiers
import Firebase

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
            .navigationBarTitle("Add Users".localized, displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .cancellationAction ){
                    Button(action:{showSheetView = false}) {
                        Text("Cancel".localized).foregroundColor(Color("blue"))
                    }
                }
                ToolbarItem(placement: .principal){
                    Picker(selection: self.$choice, label: Text("Pick One")) {
                        Text("Manual".localized).tag(0)
                        Text("Import".localized).tag(1)
                    }
                    .frame(width: 180,height: 40)
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
        }
    }
}


struct Today: View {
  //  @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbUser: userDatabaseVM

    
    @State private var showAddSheet = false
    @State private var taskProject = "Personal"
    @State private var meetingProject = "Personal"
    
  //  @State var privilage : [String] = ["Owner", "Admin", "Emplyee"]
    @State var privilage : [String] = ["Admin", "Emplyee"]

    @State var packages : [String] = ["Essentials", "Profissionals", "Customized"]
    
    @State var userType = "Admin"
    @State var userSubscription = "Profissionals"
    @State var showSheetView = false
    @State private var taskNavBarTitle = "Project"
    @State var assignee: [String] = []
    private let calendar = Calendar(identifier: .gregorian)
    
    
    var body: some View {
        ScrollView{
            
            VStack{
                HStack {
                    Text(greetingLogic().localized)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    NavigationLink {
                        UserProfile()
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .font(.largeTitle)
                            .foregroundColor(Color("blue"))
                    }
                    
                }.padding(.bottom, 8)
                
                //if____________________________________________________________________
                if userType == "Owner" || userType == "Admin" && userSubscription == "Essentials" {
                    HStack {
                        Button(action: {
                            self.showSheetView.toggle()
                        }) {
                            ZStack{
                                Rectangle().frame( height:109 )
                                    .foregroundColor(Color("blue"))
                                    .cornerRadius(8).shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
                                VStack {
                                    Image(systemName: "person.fill.badge.plus").padding(.top, 9.0).foregroundColor(.white)
                                    Text("Add Users".localized).foregroundColor(.white)
                                }
                            }
                        }
                        
                        
                        
                //        NavigationLink(destination: OrgUsers(selectedUsers: $assignee, navBarTitle: $taskNavBarTitle)) {
                        NavigationLink(destination: manageMembers()){
                            ZStack{
                                Rectangle().frame( height:109 )
                                    .foregroundColor(Color("pink"))
                                    .cornerRadius(8).shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
                                VStack {
                                    Image(systemName: "person.3.fill").padding(.top, 9.0).foregroundColor(.white)
                                    Text("Manage Users".localized)  .foregroundColor(.white)
                                }
                            }
                        }
                        
                    }//end of Hstack
                    
                }//end of condition 1
                
                
                
                
                //______________________________________________________________
                else if  userSubscription == "Profissionals" {
                    //Check in
//                    Button(action: {
//
//                    }) {
//                        ZStack{
//                            Rectangle()
//                                .foregroundColor(Color("tabBarColor"))
//                                .cornerRadius(8)
//                                .frame( height: 56)
//                                .shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
//                            HStack{
//                                ZStack{
//                                    Image(systemName: "hand.point.up")
//                                        .font(.system(size: 32, weight: .regular ))
//                                        .foregroundColor(Color("purple"))
//                                    Circle()
//                                        .foregroundColor(Color.white)
//                                        .frame(width: 19, height: 19)
//                                        .padding([.top, .leading], 20.0)
//                                    Image(systemName: "arrow.right.circle.fill")
//                                        .font(.system(size: 16, weight: .regular))
//                                        .foregroundColor(Color("blue"))
//                                        .padding([.top, .leading], 20.0)
//                                }
//                                NavigationLink(destination: CheckInView()){
//                                VStack(alignment: .leading){
//                                    Text("Check-in".localized)
//                                        .font(.system(size: 16))
//                                        .foregroundColor(Color("blue"))
//                                    Text("Tap here to check-out".localized)
//                                        .font(.system(size: 16))
//                                        .foregroundColor(Color.gray)
//                                }}
//                                Spacer()
//                            }.padding()
//                        }
//                    }
                    
                    
                    //end of condition 2
                    //_____________________________________________________________
                    if  userType == "Owner" || userType == "Admin"  {
                        HStack{
                            Button(action: {
                                self.showSheetView.toggle()
                            }) {
                                ZStack{
                                    Rectangle().frame( height:109 )
                                        .foregroundColor(Color("blue"))
                                        .cornerRadius(8).shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
                                    VStack(spacing:9) {
                                        Image(systemName: "person.fill.badge.plus").padding(.top, 9.0).foregroundColor(.white)
                                        Text("Add Users\n".localized).foregroundColor(.white)
                                    }
                                }
                            }
                            
                            
                            
                            NavigationLink(destination: manageMembers()) {
                                ZStack{
                                    Rectangle().frame( height:109 )
                                        .foregroundColor(Color("pink"))
                                        .cornerRadius(8).shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
                                    VStack(spacing:9) {
                                        Image(systemName: "person.3.fill").padding(.top, 9.0).foregroundColor(.white)

                                        Text("Manage\nUsers".localized).foregroundColor(.white)
                                    }
                                }
                            }
                            // Attendence
//                            Button(action: {
//                            }) {
//                                ZStack{
//                                    Rectangle().frame( height:109 )
//                                        .foregroundColor(Color("orange"))
//                                        .cornerRadius(8).shadow(color: .black.opacity(0.15) ,radius: 8, x: 0, y: 1)
//                                    VStack(spacing:9) {
//                                        Image(systemName: "text.badge.checkmark").padding(.top, 9.0).foregroundColor(.white)
//                                        Text("Attendance\n".localized).foregroundColor(.white)
//                                    }
//
//                                }
//
//                            }
                        }.padding(.top)
                    }
                }
                
                HStack{
                    Text("Today's Tasks".localized).fontWeight(.bold).font(.system(size: 22))
                    Spacer()
                    Button(action: {showAddSheet = true}){
                        Image(systemName: "plus.circle.fill").foregroundColor(Color("blue")).font(.title3)
                        Text("Add".localized).foregroundColor(Color("blue")).font(.title3)
                    }.padding(.leading)
                }.padding(.top, 10)
                    .sheet(isPresented: $showAddSheet, content: {
                        AddTaskMeetingSheet(showAddSheet: $showAddSheet, taskProject: taskProject, taskProjectName: taskProject, meetingProject: meetingProject, meetingProjectName: meetingProject)
                    })
                // for showing meetings cells for today
                ForEach(dbMeetings.meetings.indices, id: \.self) {index in
                    if calendar.isDateInToday( dbMeetings.meetings[index].meetingDate ?? Date()){
                        MakeMeetingCell(meeting: dbMeetings.meetings[index])
                    }
                }
                // for showing tasks cells for today
                ForEach(dbUser.tasks.indices, id: \.self) {index in
                    if dbUser.tasks[index].taskDeadline != nil && calendar.isDateInToday(dbUser.tasks[index].taskDeadline ?? Date())
                    {
                        MakeTaskCell(task: dbUser.tasks[index])
                    }
                }
                Spacer()
                Divider()
                HStack{
                    Text("Incomplete Tasks".localized).fontWeight(.bold).font(.system(size: 22))
                    Spacer()
                }
                ForEach(dbMeetings.meetings.indices, id: \.self) {index in
                    if !calendar.isDateInToday(dbMeetings.meetings[index].meetingDate ?? Date()) &&
                        dbMeetings.meetings[index].meetingDate ?? Date() < Date() && dbMeetings.meetings[index].meetingStatus != "Done"{
                        MakeMeetingCell(meeting: dbMeetings.meetings[index])
                    }
                }
                ForEach(dbUser.tasks.indices, id: \.self) {index in
                    if dbUser.tasks[index].taskDeadline == nil && dbUser.tasks[index].taskProjectId == "Personal" &&
                        dbUser.tasks[index].taskStatus != "Done" {
                        MakeTaskCell(task: dbUser.tasks[index])
                    }
                }
                //
                //      Spacer()
                //
                //
            }.padding()
            //    .padding(.leading, 5)
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
    var greetingText = "Hello" // Default greeting text
    
    
    switch hour {
    case NEW_DAY..<NOON:
        greetingText = "Good Morning"
    case NOON..<SUNSET:
        greetingText = "Good Afternoon"
    case SUNSET..<MIDNIGHT:
        greetingText = "Good Evening"
    default:
        _ = "Hello"
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
            VStack(spacing : 15){
                if useresArray.isEmpty{
                    Spacer().frame( height: 80 )
                    Image(systemName: "square.and.arrow.down.on.square.fill").font(.system(size: 100)).foregroundColor(Color("blue")).padding()
                    Text("Import .csv file containg User Name, and Email columns.".localized).font(.title2)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }else{
                    Form {
                        Section(header: Text("Users".localized),footer: Text("Send Emails".localized)){
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
                    ZStack{
                        Rectangle().frame( height:54 )
                            .foregroundColor(Color("blue"))
                        
                            .cornerRadius(8)
                        
                        HStack {
                            //            Image(systemName: "square.and.arrow.down.fill").foregroundColor(.white)
                            Text("Import".localized).foregroundColor(.white)
                        }
                    }
                } .padding(.bottom, 10)
            }.padding()
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
                    Text("Add".localized).foregroundColor(useresArray.isEmpty ? .gray: Color("blue"))
                }
            }
        }
    }
}
struct ImportMnual : View{
    @EnvironmentObject var dbUser: userDatabaseVM
    @EnvironmentObject var dbOrg: orgDatabaseVM

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var jobTitle: String = ""
    @State private var directManager: String = ""
    @State private var selectedMangerName: String = ""
    //  @State private var directManagerPic: Image = ""
    @State private var permissions: String = ""
    @Binding var showSheetView: Bool
    var body: some View{
        let y = dbOrg.getMembers()

        Form{
            Section(header: Text("User Information".localized)){
                TextField("Name".localized, text: $name)
                TextField("Email".localized, text: $email)
                TextField("Job Title".localized, text: $jobTitle)
            }
            Section(){
                NavigationLink(destination:Mangers(selectedManger: $directManager, selectedMangerName: $selectedMangerName)){
                    HStack{
                        Text("Direct Manager:".localized)
                        Text(selectedMangerName)
                        
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
                        showSheetView = false
                        let currentU = Auth.auth().currentUser
                        dbUser.addUser(User(firstName: name, lastName: name, userJobTitle: jobTitle, userPhone: "", userEmail: email, userPermession: 5, userProjects: [""], userTasks: [""], userMeetings: [""], userImage: "", userLineManger: directManager, userOrg: dbUser.currentOrgID), dbUser.generateRandomPassword())
                        Auth.auth().updateCurrentUser(currentU!, completion: nil)
                    }
                    
                }
                ) {
                    Text("Add".localized).foregroundColor( name != "" && email != "" ? Color("blue"): .gray)
                }
            }
        }
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}



struct Mangers: View {
    @Binding var selectedManger : String
    @Binding var selectedMangerName: String
    @EnvironmentObject var dbOrg: orgDatabaseVM

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        let y = dbOrg.getMembers()
        let mangers = dbOrg.getMembers()
        List{
            if (mangers.isEmpty){
              //  Text("Orgnaization have no members\(dbUser)")
                Text("Orgnaization have no members")

            }
            else {
            ForEach(mangers){ manger in
                Button(action: {selectedManger = manger.id ?? ""
                    selectedMangerName = "\(manger.firstName!) \(manger.lastName!)"
                }) {
                    HStack {
                        Image(systemName: "person.crop.circle").frame(width: 40, height:40)
                        Text("\(manger.firstName!) \(manger.lastName!)").foregroundColor(.black)
                        if manger.id == selectedManger {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }}
        }
        .navigationBarTitle("Managers".localized,displayMode: .inline)
    }
}
struct Permissions: View {
    @Binding var selectedPermission : String
    let permissions = ["Admin", "User"]
    let description = ["Admin","User"]
    @State var desc = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        List{
            Section(footer: Text(desc)){
                ForEach(0..<permissions.count, id:\.self){ i in
                    Button(action: {selectedPermission = permissions[i]
                        desc = description[i].localized
                    }) {
                        HStack {
                            Text(permissions[i].localized).foregroundColor(Color("text"))
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


