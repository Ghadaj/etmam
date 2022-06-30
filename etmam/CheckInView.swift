//
//  CheckInView.swift
//  ImportSheet
//
//  Created by raghda on 21/11/1443 AH.
//

import SwiftUI
struct AddSheett : View {
    //  @Binding var selectedDate: Date
    //for the text inputs
    @State private var name: String = "Employee Name"
    @State private var email: String = "Example@example.com"
    @State private var choice = 0
    @Binding var showSheetView: Bool
   
    
    var body : some View{
        NavigationView{
            VStack{
                VStack(spacing: -20){
                Circle()
                        .trim(from: 0.59, to: 0.90)
                        .stroke(lineWidth: 5)
                        .frame(width: 50, height: 40)
                        .foregroundColor(Color("pink"))
                Circle()
                    .trim(from: 0.65, to: 0.84)
                    .stroke(lineWidth: 5)
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color("pink"))
                Circle()
                    .trim(from: 0.65, to: 0.85)
                    .stroke(lineWidth: 5)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("orange"))
                }
                Image(systemName: "hand.point.up")
                    .font(.system(size: 100, weight: .thin))
                    .foregroundColor(Color("blue"))
               Text("Hi")
                }
            
            .navigationBarTitle("", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading ){
                    
                        Button(action:{showSheetView = false}) {
                            Text("Cancel").foregroundColor(Color("blue"))
                        }
                }

                    
                }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:{
                        
                        //databse work(sending invitations)
                     
                        showSheetView = false }
                    ) {
                        Text("Done").foregroundColor(Color("blue"))
                        
                     
                    }
                }
            }
            }
      }
    }
struct CheckInView: View {
    @State private var showSheetView = false

    var body: some View {
        
        VStack{
            Button("Show Sheet") {
                showSheetView.toggle()
            }
            .sheet(isPresented: $showSheetView) {
                AddSheett(showSheetView: self.$showSheetView)
        }
     
        }

    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView()
    }
}

