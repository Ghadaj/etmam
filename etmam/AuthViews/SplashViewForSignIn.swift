//
//  SplashView.swift
//  testFirebase
//
//  Created by raghda on 07/12/1443 AH.
//

import SwiftUI

struct SplashViewForSignIn: View {
    @State var isActive : Bool = false
    @Binding var isSignedIn : Bool
    @Binding var userSignedOut : Bool
    var body: some View {
        if isActive || userSignedOut{
            logoView()
        }
        else {
            splashAnimation(isActive: $isActive).onAppear{
                isSignedIn = true
            }
            

        
        }
    }
}

struct splashAnimation: View {
    @Binding var isActive : Bool
    @State var size = 0.8
    @State var opacity = 0.5
    
    var body : some View{
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
                VStack{
                    Spacer()
                    VStack{
                        Image("logo")
                            .resizable().frame(width: 250, height: 250)
                        VStack(spacing:10){
                        Rectangle()
                                .cornerRadius(8)
                                .frame(height: 50, alignment: .center)
                                .padding(.horizontal).foregroundColor(.clear)
                        Rectangle()
                                .cornerRadius(8)
                                .frame(height: 50, alignment: .center)
                                .padding(.horizontal).foregroundColor(.clear)
                    }
                        
                    }   .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.linear(duration: 1.0)) {
                                self.size = 1
                                self.opacity = 1.00
                            }
                        }
                    
                    
                    
                    Spacer().frame(height: 200)
                    
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {

                            isActive = true

                        }
                    }
                }.onDisappear{
                 
}


        }
        
    }
}
