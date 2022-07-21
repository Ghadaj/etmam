//
//  ContentView.swift
//  calenderSwift
//
//  Created by Danya T on 18/10/1443 AH.
//

import SwiftUI
struct calendarTab: View {
    //@EnvironmentObject var dbTasks: taskDatabaseVM
    @EnvironmentObject var dbMeetings: meetingDatabaseVM
    @EnvironmentObject var dbUsers: userDatabaseVM

    private let calendar: Calendar
    private let monthDayFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    static var now = Date()
    @State private var selectedDate = Self.now
    
    //  @State var fromCalendar = true
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
                            UserProfile()
                        } label: {
                            Image(systemName: "person.crop.circle")
                                .font(.largeTitle)
                                .foregroundColor(Color("blue"))
                        }
                    }
                    Spacer().frame(height:15)
                    CalendarWeekListView(
                        calendar: calendar,
                        date: $selectedDate,
                        selectedDate: $selectedDate,
                        content: { date in
                            Button(action: {selectedDate = date}){
                                ZStack{
                                    //80
                                    Rectangle().frame( height: 80).cornerRadius(8).foregroundColor(Color("tabBarColor")).shadow(radius: 0.6).opacity((calendar.isDate(date, inSameDayAs: selectedDate) ? 1 : 0))
                                    VStack{
                                        Text("000")
                                            .font(.system(size: 12))
                                            .foregroundColor(.clear)
                                            .overlay(Text(weekDayFormatter.string(from: date))
                                                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? Color("text") : calendar.isDateInToday(date) ? Color("blue") : .gray))
                                        //شيل
                                        // Spacer().frame(height:4)
                                        Text("00")
                                            .font(.system(size:16))
                                            .padding(3)
                                            .foregroundColor(.clear)
                                            .overlay(Text(dayFormatter.string(from: date)).fontWeight(.bold)
                                                .font(.system(size:18))
                                                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? Color("text") : calendar.isDateInToday(date) ? Color("blue") : date < Date() ? .gray:Color("text")))
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
                                    icon: {Image(systemName: NSLocale.current.languageCode == "ar" ? "chevron.right" : "chevron.left" ).foregroundColor(Color("blue"))}
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
                                    icon: {Image(systemName: NSLocale.current.languageCode == "ar" ? "chevron.left" : "chevron.right").foregroundColor(Color("blue"))}
                                )
                                .labelStyle(IconOnlyLabelStyle())
                                .padding(.horizontal)
                            }
                        }
                    )
                    Divider()
                    // for showing meetings cells for selected day
                    ForEach(dbMeetings.meetings.indices, id: \.self) {index in
                        if calendar.isDate(selectedDate, inSameDayAs: dbMeetings.meetings[index].meetingDate ?? Date()){
                            HStack{
                                filledTimeLineShape()
                                MakeMeetingCell(meeting: dbMeetings.meetings[index])
                            }
                        }
                    }
                    // for showing tasks cells for selected day
                    ForEach(dbUsers.tasks.indices, id: \.self) {index in
                        if dbUsers.tasks[index].taskDeadline != nil && calendar.isDate(selectedDate, inSameDayAs:dbUsers.tasks[index].taskDeadline ?? Date()) && dbUsers.tasks[index].taskStatus
                            != "Done"{
                            HStack{
                                filledTimeLineShape()
                                MakeTaskCell(task: dbUsers.tasks[index])
                            }
                        }
                    }
                    unfilledTimeLineShape()
                    // empty time lines
                }.padding()
            }
            .navigationBarHidden(true)
        }
    }
    func linesMaker(date:Date) -> some View{
        var arr : [String] = []
        for i in dbMeetings.meetings{
            if calendar.isDate(date, inSameDayAs: i.meetingDate ?? Date()){
                arr.append("meetingBlue")
                if arr.count == 4{
                    break
                }
            }
        }
        if arr.count < 4 {
            for i in dbUsers.tasks{
                if i.taskDeadline != nil && calendar.isDate(date, inSameDayAs: i.taskDeadline ?? Date()) && i.taskStatus != "Done"{
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
//        let month = date.startOfMonth(using: calendar)
//        let days = makeDays()
//
//
//        VStack(spacing:1){
//
//
//            HStack{
//
//                self.weekSwitcher1(month)
//                self.title(month)
//                self.weekSwitcher2(month)
//            }
//
//            HStack{
//                ForEach(days, id: \.self) { date in
//
//
//                    content(date)
//
//
//
//
//                }
//            }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                .onEnded({ value in
//                    if value.translation.width < 0 {
//                        guard let newDate = calendar.date(byAdding: .weekOfMonth , value: NSLocale.current.languageCode == "ar" ? -1 : 1, to: date)
//                        else{
//                            return
//                        }
//                        date = newDate
//                    }
        let month = date.startOfMonth(using: calendar)
             let days = makeDays()
             VStack(spacing:1){
              HStack{
               self.weekSwitcher1(month)
               self.title(month)
               self.weekSwitcher2(month)
             }
              HStack{
               ForEach(days, id: \.self) { date in
                content(date)
              }
             }
            }.gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
               .onEnded { value in
                       print(value.translation)
                       switch(value.translation.width, value.translation.height) {
                        case (...0, -30...30):
                        guard let newDate = calendar.date(byAdding: .weekOfMonth , value: NSLocale.current.languageCode == "ar" ? -1 : 1, to: date)
                        else{
                         return
                       }
                        date = newDate
                        case (0..., -30...30):
                        guard let newDate = calendar.date(byAdding: .weekOfMonth , value:NSLocale.current.languageCode == "ar" ? 1 : -1, to: date)
                        else{
                         return
                       }
                        date = newDate
                        default: print("no clue") }
                     
               
                    if value.translation.width > 0 {
                        guard let newDate = calendar.date(byAdding: .weekOfMonth , value: NSLocale.current.languageCode == "ar" ? 1 : -1, to: date)
                        else{
                            return
                        }
                        date = newDate
                    }
                }).animation(.easeIn(duration: 0.1))
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
        self.locale = Locale(identifier: NSLocale.current.languageCode ?? "en")
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
        }
        
    }
    
}

func filledTimeLineShape() -> some View {
    VStack(spacing:0){
        Circle().foregroundColor(Color("gray")).frame(width:12,height: 12)
        Rectangle().frame(width: 1 , height: 105).foregroundColor(Color("gray"))
        Spacer().frame(height: 0)
        
    }
}








