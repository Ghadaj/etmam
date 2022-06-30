//
//  ContentView.swift
//  calenderSwift
//
//  Created by Danya T on 18/10/1443 AH.
//

import SwiftUI

struct calendarTab: View {
    @EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    private let calendar: Calendar
    private let monthDayFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    static var now = Date()
    @State private var selectedDate = Self.now
    @State private var showAddSheet = false
    @State private var taskProject = "No project"
    @State private var meetingProject = "No project"
    @State var numOfLines = 0
  
    init(){
        self.calendar = Calendar(identifier: .gregorian)
        self.monthDayFormatter = DateFormatter(dateFormat: "MMMM yyyy", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
        
    }
    
    
    
    
    var body: some View {
        
       
            
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                ScrollView{
                VStack{
                   
                    HStack {
                      Text("Calendar")
                        .font(.largeTitle.bold())
                      Spacer()
                      NavigationLink {
                        Text("Person View")
                      } label: {
                        Image(systemName: "person.crop.circle")
                          .font(.largeTitle)
                          .foregroundColor(Color("blue"))
                      }
                    }.padding(.horizontal, 7)
                    
                    
                   
                     Spacer().frame(height:15)
                            
                            
                            CalendarWeekListView(
                                calendar: calendar,
                                date: $selectedDate,
                                selectedDate: $selectedDate,
                                content: { date in
                                    Button(action: {selectedDate = date}){
                                        ZStack{
                                            //80
                                            Rectangle().frame(width:42, height: 80).cornerRadius(8).foregroundColor(Color("tabBarColor")).shadow(radius: 0.6).opacity((calendar.isDate(date, inSameDayAs: selectedDate) ? 1 : 0))
                                            VStack{
                                                Text("00")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.clear)
                                                    .overlay(Text(weekDayFormatter.string(from: date))
                                                                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? Color("text") : calendar.isDateInToday(date) ?  Color("blue") : .gray))
                                                //شيل
                                                    // Spacer().frame(height:4)
                                                
                                                Text("00")
                                                    .font(.system(size:16))
                                                    .padding(3)
                                                
                                                    .foregroundColor(.clear)
                                                    .overlay(Text(dayFormatter.string(from: date)).fontWeight(.bold)
                                                                .font(.system(size:18))
                                                                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? Color("text") : calendar.isDateInToday(date) ? Color("blue") : date < Date() ? .gray: Color("text")))
                                                
                                                
                                                Spacer().frame(height:3)
                                               
                                              

                                               
                                                //linesMakerWithPlus(date: date)
           
                                                 linesMaker(date: date)

                                             
                                                }
                                            }
                                        }
                                    }
                            
                                
                                ,title: { date in
                                    HStack{
                                        Text(monthDayFormatter.string(from: selectedDate))
                                            .font(.headline)
                                            .padding()
                                    
                                    }
                                    .padding(.bottom, 6)
                                } ,weekSwitcher1: { date in
                                    Button{
                                     
                                        guard let newDate = calendar.date(byAdding: .weekOfMonth , value: -1, to: selectedDate)
                                        else{
                                            return
                                        }
                                        selectedDate = newDate
                                        
                                        
                                    }label: {
                                        Label(
                                            title: { Text("Previous")},
                                            icon: {Image(systemName: "chevron.left").foregroundColor(Color("blue"))}
                                            
                                        )
                                            .labelStyle(IconOnlyLabelStyle())
                                            .padding(.horizontal)
                                    }
                                    
                                }, weekSwitcher2: { date in
                                    Button{
                                        
                                        
                                        guard let newDate = calendar.date(byAdding: .weekOfMonth , value: 1, to: selectedDate)
                                        else{
                                            return
                                        }
                                        selectedDate = newDate
                                        
                                    }label: {
                                        Label(
                                            title: { Text("Next")},
                                            icon: {Image(systemName: "chevron.right").foregroundColor(Color("blue"))}
                                            
                                        )
                                            .labelStyle(IconOnlyLabelStyle())
                                            .padding(.horizontal)
                                    }
                                    
                                }
                            )
                            
                            Divider()

                            HStack{
                                Button(action:{ showAddSheet = true}){
                                    
                                    Image(systemName: "plus").font(.system(size:20))
                                        .foregroundColor(Color("blue"))
                                    Text("Add").foregroundColor(Color("blue")).font(.system(size:20))
                                    
                                }.padding(.leading)
                                Spacer()
                                
                            }
                            
                            // for showing meetings cells for selected day

                            
                            ForEach(dbMeetings.meetings.indices, id: \.self) {index in
                                if  calendar.isDate(selectedDate, inSameDayAs: dbMeetings.meetings[index].meetingCreatedDate ?? Date()){
                                    HStack(spacing:-8){
                                       
                                    filledTimeLineShape()

                                        MakeMeetingCell(meeting: dbMeetings.meetings[index])
   
                                    }.padding(.leading, 5)
                                }
                                
                            }
                            
                            
                            
                            
                            // for showing tasks cells for selected day
                            ForEach(dbTasks.tasks.indices, id: \.self) {index in
                                if  dbTasks.tasks[index].taskDeadline != nil  &&  calendar.isDate(selectedDate, inSameDayAs:dbTasks.tasks[index].taskDeadline ?? Date())  && dbTasks.tasks[index].taskStatus
                                != "Done"{
                                    HStack(spacing:-8){
                                       
                                          filledTimeLineShape()

                                        MakeTaskCell(task: dbTasks.tasks[index], isDeadlineToday: true)
                                        
                                    }.padding(.leading, 5)
                                    
                                }else if calendar.isDate(selectedDate, inSameDayAs: dbTasks.tasks[index].taskStartDate ?? Date()){
                                    HStack(spacing:-8){
                                    filledTimeLineShape()
                                    
                                    MakeTaskCell(task: dbTasks.tasks[index])
                                    }.padding(.leading, 5)
                                }
                                
                            
                            }
                            unfilledTimeLineShape()
                            //  empty time lines
                        
                        
                        .sheet(isPresented: $showAddSheet, content: {
                            AddTaskMeetingSheet(selectedDate: $selectedDate,showAddSheet: $showAddSheet, taskProject: taskProject, taskProjectName: taskProject, meetingProject: meetingProject, meetingProjectName: meetingProject)
                        })
                        
              
                }.padding()
                }
            
            .navigationBarHidden(true)
       
            }
       }
   
    func linesMaker(date:Date) -> some View{
            var arr : [String] = []
            
            for i in dbMeetings.meetings{
                if  calendar.isDate(date, inSameDayAs: i.meetingCreatedDate ?? Date()){
                    arr.append("meetingBlue")
                    if arr.count == 4{
                        break
                    }
                    
                }
            }
        if arr.count < 4 {
            for i in dbTasks.tasks{
                if  calendar.isDate(date, inSameDayAs: i.taskStartDate ?? Date()) ||
                        i.taskDeadline != nil &&
                        calendar.isDate(date, inSameDayAs: i.taskDeadline ?? Date()) && i.taskStatus != "Done"{
                    arr.append(i.taskColor ?? "")
                    if arr.count == 4{
                        break
                    }
                    
                    
                }
            }
    }
        return ZStack{
            Rectangle().frame(width: 5, height:16).foregroundColor(.clear)
            VStack( spacing: 2.5){
        ForEach(arr, id: \.self){ color in
                
                Rectangle().frame(width:32 , height: 2).foregroundColor(Color(color))
            }
           }
        }
    }
    
    //شيل
    func linesMakerWithPlus(date:Date) -> some View{
            var arr : [String] = []
        var showPlus : Color = .clear
            for i in dbMeetings.meetings{
                if  calendar.isDate(date, inSameDayAs: i.meetingCreatedDate ?? Date()){
                    arr.append("meetingBlue")
                    if arr.count == 5{
                        showPlus = .gray
                        break
                    }
                    
                }
            }
        if arr.count < 4 {
            for i in dbTasks.tasks{
                if  calendar.isDate(date, inSameDayAs: i.taskStartDate ?? Date()) ||
                        i.taskDeadline != nil  && calendar.isDate(date, inSameDayAs: i.taskDeadline ?? Date()) && i.taskStatus
                        != "Done"{
                    arr.append(i.taskColor ?? "")
                    if arr.count == 5{
                        showPlus = .gray
                        break
                    }
                    
                    
                }
            }
    }
        return ZStack{
            Rectangle().frame(width: 5, height:28).foregroundColor(.clear)
            
         VStack(spacing:2.5){
        ForEach(arr.indices, id: \.self){ i in
            if i < 4{
                Rectangle().frame(width:32 , height: 2).foregroundColor(Color(arr[i]))
            }
            
        }
            Image(systemName: "plus").font(.system(size: 8)).foregroundColor(showPlus)
            }
        }

    }

    }

    


struct CalendarWeekListView<Day: View, Title: View, WeekSwitcher1: View, WeekSwitcher2: View>: View{

    
    private var calendar: Calendar
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let title: (Date) -> Title
    private let weekSwitcher1: (Date) -> WeekSwitcher1
    private let weekSwitcher2: (Date) -> WeekSwitcher2
    @EnvironmentObject var dbTasks: taskDatabaseVM
    private let daysInWeek = 7
    
    init(
        calendar: Calendar,
        date:Binding<Date>,
        selectedDate:Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
     
        @ViewBuilder title: @escaping (Date) -> Title,
        @ViewBuilder weekSwitcher1: @escaping (Date) -> WeekSwitcher1,
        @ViewBuilder weekSwitcher2: @escaping (Date) -> WeekSwitcher2){
            self.calendar = calendar
            self._date = date

            self.content = content
   
            self.title = title
            self.weekSwitcher1 = weekSwitcher1
            self.weekSwitcher2 = weekSwitcher2
            
        }
    var body: some View{
        let month = date.startOfMonth(using: calendar)
        let days = makeDays()
       
       
        VStack(spacing:1){
            
           
            HStack{
                
                self.weekSwitcher1(month)
                self.title(month)
                self.weekSwitcher2(month)
            }
          
            HStack(spacing: 13){
                ForEach(days, id: \.self) { date in
                 
                
                    content(date)
                        
                  
                    
                   
                }
            }
        }
        
    }

}

private extension CalendarWeekListView{
    func makeDays() -> [Date]{
        guard let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: date),
              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: firstWeek.end - 1)
        else{
            return []
        }
        let dateInterval = DateInterval(start: firstWeek.start, end: lastWeek.end)
        
        return calendar.generateDays(for: dateInterval)
    }
}

private extension Calendar{
    func generateDates(for dateInterval: DateInterval, matching components: DateComponents) -> [Date]{
        var dates = [dateInterval.start]
        
        enumerateDates(startingAfter: dateInterval.start, matching: components, matchingPolicy: .nextTime) { date,_, stop in
            
            guard let date = date else {return}
            guard date < dateInterval.end else{
                stop = true
                return
            }
            dates.append(date)
        }
        return dates
    }
    
    
    func generateDays( for dateInterval: DateInterval) -> [Date]{
        generateDates(
            for: dateInterval,matching: dateComponents([.hour,.minute, .second], from: dateInterval.start))
        
    }
}

private extension Date{
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)) ?? self
        
    }
}

private extension DateFormatter {
    convenience init ( dateFormat: String, calendar: Calendar){
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
        self.locale = Locale(identifier: "en_US")
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        calendarTab()
    }
}

func unfilledTimeLineShape() -> some View {
    ForEach((1...3), id: \.self) {_ in

         HStack{
         VStack(spacing:0){
             Circle()
                 .strokeBorder(Color("gray"),lineWidth: 1)
                 .frame(width:12,height: 12)
             
             Rectangle().frame(width: 1 , height: 105).foregroundColor(Color("gray"))
             Spacer().frame(height: 0)
             
          }
            Spacer()
         }.padding(.leading, 5)
         
       }
    
}

func filledTimeLineShape() -> some View {
    VStack(spacing:0){
   Circle().foregroundColor(Color("gray")).frame(width:12,height: 12)
    Rectangle().frame(width: 1 , height: 105).foregroundColor(Color("gray"))
        Spacer().frame(height: 0)
    
    }
}




                
                
        

