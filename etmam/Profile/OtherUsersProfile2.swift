//
//  OtherUsersProfile.swift
//  calenderSwift
//
//  Created by Sara AlMezeini on 07/12/1443 AH.
//

import SwiftUI

struct OtherUsersProfile2: View {
    @State var user: User
    @EnvironmentObject var dbUsers: userDatabaseVM
    @State var showStack = false
    func getLM(){
        dbUsers.getUserName2(id: user.userLineManger!){
         (success) -> Void in
             if success {
                 getUser()
}
    }}
    
    
    func getUser(){
        dbUsers.getUser2(userID: user.userLineManger!){
         (success) -> Void in
             if success {
                 showStack = true
}
    }}
    var body: some View {
        let x =  getLM()

        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack(spacing : -2){
                VStack(spacing:10){
                    Image(uiImage: imageWith(name: "\(user.firstName!) \(user.lastName!)")!).resizable().frame(width: 90, height: 90).overlay(Circle().stroke(Color.white, lineWidth: 1))
                    var name = "\(user.firstName!) \(user.lastName!)"
                    Text(name).foregroundColor(Color("text")).font(.system(size: 24).bold())
                    Text(user.userJobTitle ?? "").foregroundColor(.gray).font(.system(size: 20))
                }
                Form{
                    Section{
                        HStack{
                            Image(systemName: "envelope.fill").foregroundColor(Color("blue"))
                            Text(user.userEmail)
                        }
                        HStack{
                            Image(systemName: "phone.fill").foregroundColor(Color("blue"))
                            Text(user.userPhone ?? "")
                        }
                        if (user.userLineManger != ""){
                            if showStack{
                                NavigationLink(destination: OtherUsersProfile(user: dbUsers.user )) {
                            HStack{
                                Image(systemName: "person.fill").foregroundColor(Color("blue"))
                                Text("Direct Manager".localized)
                                Spacer()
                                var name = "\(dbUsers.firstName) \(dbUsers.lastName)"
                                Text(name).foregroundColor(.gray)
                            }
                        }

                        }
                        }}
                }.hasScrollEnabled2(false)
                    .frame(height: 180)

                HStack{
                    Button{

                    }label: {
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color("blue"))
                                .frame(height: 64)
                                .cornerRadius(10)
                            HStack(spacing : 10){
                                Image(systemName:"scale.3d").foregroundColor(.white).font(.system(size: 24))
                                Text("Organization Structure".localized)
                                    .foregroundColor(.white).font(.system(size: 24))
                            }
                        }
                    }
                }.padding()
                Spacer()



            }

        }
    }
}
//
//struct OtherUsersProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        OtherUsersProfile(user: User)
//    }
//}

extension View {
    
    func hasScrollEnabled2(_ value: Bool) -> some View {
        self.onAppear {
            UITableView.appearance().isScrollEnabled = value
        }
    }
}
