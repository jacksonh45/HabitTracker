//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Jackson Harrison on 3/26/24.
//

import SwiftUI

struct HabitDetailView: View {
    
    var habit: Habit
    let habitItems: HabitItems
    
    @Environment(\.presentationMode) var presentationMode
    
    var formatterDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        
        print(habit.name, habit.id)
        
        return formatter.string(from: habit.startDate)
    }
    
    @State private var contentTitle = ""
    @State private var newTime = defaultReminderTime
    
    static var defaultReminderTime: Date{
        return Date()
    }
    
    
    var time: String{
        var hour = Calendar.current.component(.hour, from: self.habit.reminderTime!)
        let minute = Calendar.current.component(.minute, from: self.habit.reminderTime!)
        var holder = "AM"
        if hour > 12{
            hour -= 12
            holder = "PM"
        }
        return "\(hour):\(minute) \(holder)"
    }
    
    
    @State private var editReminder = false
    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                Form{
                    Section(){
                        Text(self.habit.type)
                            .font(.headline)
                            .foregroundColor(Color.red)
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                        
                        Text(self.habit.note)
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                    
                    Section(header: Text("Your Streaks")
                        .foregroundColor(.primary)
                        .fontWeight(.heavy)
                        .font(.headline)
                    ){
                        HStack{
                            
                            VStack(){
                                Text("Best")
                                    .font(.title)
                                HStack(){
                                    Text("\(self.habit.bestStreak)")
                                }
                            }
                            .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                            
                            Spacer()
                            
                            VStack(){
                                Text("Current")
                                    .font(.title)
                                HStack(){
                                    Text("\(self.habit.calculatedCurrentStreak)")
                                    .font(.title)                                }
                            }
                            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
                        }
                        .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                        
                    }
                }
            }
        }
    }
}
