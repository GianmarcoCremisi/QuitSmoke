//
//  cigarettesApp.swift
//  cigarettes
//
//  Created by Gianmarco Cremisi on 15/11/23.
//

import SwiftUI
import SwiftData

@main
struct cigarettesApp: App {
    @State var color: Color = .white
    @State var gradient: LinearGradient = LinearGradient(colors: [.teal.opacity(0.7), .green.opacity(0.7)], startPoint: .bottom, endPoint: .top)
    
    
    
    var body: some Scene {

        WindowGroup {
            
                TabView{
                    
                    ContentView(foreground: $color, gradient: $gradient).tabItem {
                        Image(systemName: "person.fill")
                        Text("Counter")
                    }
                    
                    HistoryView(foreground: $color, gradient: $gradient).tabItem {
                        Image(systemName:"book.circle")
                        Text("History")
                    }
                    
                }
            
                .accentColor(Color(color))
        .preferredColorScheme(.dark)
           // .tint(.white)
                     
            
        }
        
        
       
        
        .modelContainer(for: CigaretteData.self)
        
    }
}
