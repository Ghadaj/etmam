//
//  Packages.swift
//  testFirebase
//
//  Created by Haya Saleem Alhawiti on 24/11/1443 AH.
//


import SwiftUI
import WelcomeSheet

struct Onboarding: View {
    @State private var showSheet = true
    
    let pages = [
        WelcomeSheetPage(title: "Gettign Started in Workaday", rows: [
            WelcomeSheetPageRow(imageSystemName: "person.circle",
                                accentColor: Color("darkBlue"),
                                title: "Collaboration",
                                content: "Work with others at the same time on shared projects, meetings, and tasks on your iphone."),
            
            WelcomeSheetPageRow(imageSystemName: "doc.text.image",
                                accentColor: Color("darkBlue"),
                                title: "Apple - Designed Templates", content: "Quickly create beatiful projects, tasks, and more."),
            
            WelcomeSheetPageRow(imageSystemName: "calendar",
                                accentColor: Color("darkBlue"),
                                title: "Calender View",
                                content: "See your tasks, and meetings listed on a Calendar.")
        ], accentColor: Color("darkBlue"), optionalButtonTitle: "About privacy policy...", optionalButtonURL: URL(string: "https://github.com/MAJKFL/Welcome-Sheet"))
    ]
            

    var body: some View {
        Button("Show sheet") {
            showSheet.toggle()
        }
        .welcomeSheet(isPresented: $showSheet, onDismiss: { print("Sheet dismissed") }, isSlideToDismissDisabled: true, pages: pages)

    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
