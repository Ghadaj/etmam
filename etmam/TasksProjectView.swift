//
//  TasksProjectView.swift
//  PolarisNew
//
//  Created by raghda on 10/11/1443 AH.
//

import SwiftUI

struct SheetView: View {
  //  @Environment(\.dismiss) var dismiss
    var body: some View {
        Button("Press to dismiss") {
        //    dismiss()
        }
        .font(.title)
        .padding()
        .background(.black)
    }
}
struct TasksProjectView: View {
    @State private var choice = 0
    @State private var showingSheet = false
//@Binding var newTask = ""
    @State private var Tasks = [String]()
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
        VStack(alignment: .center, spacing: 16.0){
//            عنوان الصفحة
            HStack{
                Text("Tasks")
                    .font(.largeTitle.bold())
                Spacer()
                Button(action:{ showingSheet.toggle()} ) {  HStack{
                    Image(systemName: ("plus.circle.fill"))
                        .foregroundColor(Color("blue"))
                    Text("Add")
                        .foregroundColor(Color("blue"))
                }
                }  .sheet(isPresented: $showingSheet) {
                    SheetView()
                }
              
            }
//        البيكر
            Picker(selection: self.$choice, label: Text("Pick One")) {
                Text("To Do").tag(0).onTapGesture {
                    choice = 0
                }
                Text("In Progress").tag(1).onTapGesture {
                    choice = 1
                }
                Text("Completed").tag(2).onTapGesture {
                    choice = 2
                }
            }
            
            
//      الانتقال بينهم
            if choice == 0 {
    toDo()
            }
            if choice == 1 {
                inProgress()
            }
            if choice == 2 {
                Completed()
            }
        }
        .frame(width: 343,height: 40)
        .pickerStyle(SegmentedPickerStyle())
        
        }
    }
}
//صفحة التودو
struct toDo: View {
//    @State var projects = [Project]()
//    @EnvironmentObject var tasks = [Task]()
    var body: some View {
        VStack{
            Text(" ToDo")
    }
}
}
//صفحة ال ان بروجرس
struct inProgress: View {
    
    var body: some View {
        VStack{
        Text("in Progress")
    }
}
}
//صفحة الكومبليتد
struct Completed: View {
    
    var body: some View {
        VStack{
        Text("Completed")
    }
}
}


struct TasksProjectView_Previews: PreviewProvider {
    static var previews: some View {
        TasksProjectView()
    }
}


