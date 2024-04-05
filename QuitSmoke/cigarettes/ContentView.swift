//
//  ContentView.swift
//  cigarettes
//
//  Created by Gianmarco Cremisi on 15/11/23.
//

import Foundation
import SwiftUI
import SwiftData
import DotLottie

struct ContentView: View {
    @Binding var foreground: Color
    @Binding var gradient: LinearGradient

    @AppStorage("opacity") var op: Double = 1.00
    @AppStorage("circle.progres") var count: Double = 0
   
    
    @Environment(\.modelContext) private var context
    @Query(sort: \CigaretteData.date) private var history: [CigaretteData]
    
    
    @State private var tempoTrascorso: TimeInterval = 0.0
    @State private var isRunning = false
    @State private var timer: Timer?
    
    @State private var tempoFormattato: String = " "
       

    var body: some View {
       
        
        VStack{
            
            VStack(){
//                DotLottieAnimation(fileName: "Animation - 1711461440181", config: AnimationConfig(autoplay: true, loop: true)).view()
                Text("Since your last cigarette has been")
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.top, 20)
                    .opacity(0.8)
                    .foregroundStyle(Color(foreground))
                Text("\(tempoFormattato)")
                    .font(.largeTitle)
                    .foregroundStyle(Color(foreground))
                    .onAppear {
                        self.startTimer()
                    }
                    .padding(.top, 7)
            }.accessibilityElement(children: .combine)
                
            
            Spacer()
            ZStack{
                if count < 20 {
                    CircularProgressView(count: $count, foreground: $foreground)
                }
                else{
                    Circle()
                        .stroke(lineWidth: 20.0)
                        .opacity(0.3)
                        .foregroundColor(.white.opacity(0.3))
                        .frame(width: 300)
                    Circle()
                       // .stroke(lineWidth: 20.0)
                       // .opacity(0.3)
                        .foregroundColor(.red.opacity(0.3))
                        .frame(width: 280)
                }
                VStack{
                    Text(String(format: "%.0f" ,count)).font(.system(size: 70)).fontWeight(.medium).foregroundStyle(Color(foreground)).accessibilityLabel(Text(String(format: "%.0f cigarettes" ,count)))
                        .onAppear {
                            if !Calendar.current.isDateInToday(history.last?.date ?? Date()) {
                                count = 0
                                updateColors()
                            }
                        }
                }
                
            }
            Spacer()
            Button(action: {
                count += 1
                op -= 0.05
                if self.isRunning {
                    self.stopTimer()
                    self.startTimer()
                } else {
                    self.startTimer()
                }
                
                updateColors()
               
                
                context.insert(CigaretteData(date: Date()))
            }, label: {
                Image(systemName: "plus.circle").font(.system(size: 75)).foregroundStyle(Color(foreground)).padding(.bottom, 50)
            })
        }.onAppear{
            updateColors()
        }
       // .background(gradient)
        .background(
            Rectangle()
                .frame(width: 1200, height: 1200)
                .ignoresSafeArea()
                .foregroundStyle(gradient)
        )
        .scaledToFill()
    }
    
    
 
    func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                let interval = Int(Date().timeIntervalSince(history.last?.date ?? Date()))
                let seconds = interval % 60
                let minutes = (interval / 60) % 60
                let hours = interval / 3600
                tempoFormattato = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
            isRunning = true
        }
    
    func stopTimer() {
        timer?.invalidate()
        self.tempoTrascorso = 0.0
        timer = nil
        isRunning = false
    }
    func additem(){
        let item = CigaretteData(date: Date())
        context.insert(item)
    }
    
    
    func updateColors(){
            if count < 5 {
                gradient = LinearGradient(colors: [.teal.opacity(op), .green.opacity(op)], startPoint: .bottom, endPoint: .top)
                foreground = .white.opacity(op)
            } else if count < 10 {
                gradient = LinearGradient(colors: [Color("Muco").opacity(op), Color("UglyBrown").opacity(op)], startPoint: .bottom, endPoint: .top)
                foreground = Color("Mindaro").opacity(op)
            }
            else if count < 15 {
                gradient = LinearGradient(colors: [Color("Bistre").opacity(op), Color("Liquirizia").opacity(op)], startPoint: .bottom, endPoint: .top)
                foreground = Color("Carrot").opacity(op)
            }
            else{
                gradient = LinearGradient(colors: [.black, .black], startPoint: .bottom, endPoint: .top)
                foreground = .white.opacity(0.6)
            }
    }
   
}

#Preview {
    ContentView(foreground: .constant(.blue), gradient: .constant(LinearGradient(colors: [.blue.opacity(0.7), .red.opacity(0.7)], startPoint: .bottom, endPoint: .top)))
}
