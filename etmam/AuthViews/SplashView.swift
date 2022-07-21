//
//  SplashView.swift
//  testFirebase
//
//  Created by raghda on 07/12/1443 AH.
//

import SwiftUI

struct SplashView: View {
    @State var isActive : Bool = false
    @Binding var userSignedOut : Bool
    @Binding var isSignedIn : Bool

    
    var body: some View {
            
            if isActive || isSignedIn{
            TabBar()

        }
        else if (userSignedOut){
            logoView()


        
        }
        else {
            splashAnimation(isActive: $isActive)


        
        }
    }
}
