//
//  notificationTab.swift
//  calenderSwift
//
//  Created by Danya T on 24/11/1443 AH.
//

import SwiftUI

struct notificationTab: View {
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Notifications")
                        .font(.largeTitle.bold())
                    Spacer()
                    NavigationLink {
                        UserProfile()
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .font(.largeTitle)
                            .foregroundColor(Color("blue"))
                        
                    }
                }
                Spacer()
            }.padding()
        }
        .navigationBarHidden(true)
    }
}


struct notificationTab_Previews: PreviewProvider {
    static var previews: some View {
        notificationTab()
    }
}
