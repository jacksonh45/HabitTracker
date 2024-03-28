//
//  ContentView.swift
//  HabitTracker
//
//  Created by Jackson Harrison on 3/26/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {

    @State private var addMoreScreenIsPresented = false
    
    @ObservedObject var habitItems = HabitItems()
    
    
    
    var body: some View {
        ZStack{
            VStack{
                Text("Habit Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding()
                        
                
                ScrollView(.vertical){
                    ForEach(self.habitItems.habits, id: \.id){habit in
                        HabitRowView(habitItems: self.habitItems, habit: habit)
                    }
                }
            }
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    
                    Button(action: {
                        self.addMoreScreenIsPresented.toggle()
                    }){
                        Text("+")
                            .font(.largeTitle)
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 80, height: 80)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding()
                    .shadow(color: Color.black, radius: 10, x: 5, y: 5)
                }
            }
        }
        .sheet(isPresented: $addMoreScreenIsPresented){
            AddHabit(habitItems: self.habitItems)
            
        }
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){ success, error in
                if success{
                    print("Permission Granted")
                }else if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
