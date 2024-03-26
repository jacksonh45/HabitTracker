//
//  AddHabit.swift
//  HabitTracker
//
//  Created by Jackson Harrison on 3/26/24.
//

import SwiftUI

struct AddHabit: View {
    
    @ObservedObject var habitItems : HabitItems
    
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var dateTarget = Date()
    @State private var type = "To Build"
    @State private var name = ""
    @State private var description = ""
    
    
    @State private var showingReminder = true
    @State private var showingPicker = false
    @State private var contentTitle = ""
    @State private var time = defaultReminderTime

    static var defaultReminderTime: Date{
        return Date()
    }
    
    static let types = ["To Build", "To Quit"]
    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                ZStack{
                    VStack{
                        VStack(alignment: .leading, spacing: 20){
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                    .frame(width: geo.size.width - 20, height: 80)
                                VStack(alignment: .leading){
                                    Text("What's the habit?")
                                    TextField("Add Name for the habit...", text: $name)

                                }
                                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            }
                            .padding(.init(top: 10, leading: 0, bottom: 0, trailing: 0))
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                    .frame(width: geo.size.width - 20, height: 80)
                                VStack(alignment: .leading){
                                    Text("This habit is all about?")
                                    TextField("Add a description for the habit...", text: $description)
                                }
                                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            }

                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                    .frame(width: geo.size.width - 20, height: 80)
                                VStack(alignment: .leading){
                                    Text("The habit is to...")
                                    Picker("Choose type of Habit", selection: self.$type){
                                        ForEach(Self.types, id:\.self){
                                            Text($0)
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                                }
                                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 40))
                            }
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading){
                            Toggle(isOn: self.$showingReminder.animation()){
                                Text("Reminder")
                            }
                            .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            
                            if self.showingReminder{
                    
                                
                                VStack (alignment: .leading){
                                    HStack{
                                        Image(systemName: "clock")
                                        Text("Reminder Time")
                                    }
                                    
                                    DatePicker("Select time", selection: self.$time, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .datePickerStyle(WheelDatePickerStyle())
                                }
                                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            }
                        }
                        Spacer()
                    }
                }
            }
                
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
            }
            .buttonStyle(PlainButtonStyle())
            )
        }
    }
}

struct AddHabit_Previews : PreviewProvider {
    static var previews: some View {
        AddHabit(habitItems: HabitItems())
    }
}
