//
//  HistoryView.swift
//  cigarettes
//
//  Created by Gianmarco Cremisi on 18/11/23.
//

import SwiftUI
import SwiftData
import UIKit

struct HistoryView: View {
    @Binding var foreground: Color
    @Binding var gradient: LinearGradient

    @Query(sort: \CigaretteData.date) private var history: [CigaretteData]
   
    
  
    
    var body: some View {
        
        
        NavigationStack{
            List{
                ForEach(CigaretteData.uniqueDates(from: history), id: \.self){ item in
                    NavigationLink(
                        destination: CigarettesDetail(foreground: $foreground, gradient: $gradient, GiornoDate: item),
                        label: {
                            Text("\(item.formatted(date: .abbreviated, time: .omitted))")
                        }
                    )
                }
                // .listRowBackground(Color.green.opacity(0.5))
            }
           
          .background(
            gradient
            )
            .scrollContentBackground(.hidden)
            .navigationBarTitle("\(monthString) \(year)")
        }
    }
    
    var month: Int{
        let calendar = Calendar.current
        if(!history.isEmpty){
            let months = calendar.component(.month, from: Date())
            
            return months
        }
        return 0
    }
    
    func monthName(from month: Int) -> String {
        let formatter = DateFormatter()
        guard (1...12).contains(month) else {
            return " No cigarette yet"
        }
        return formatter.monthSymbols[month - 1]
    }
    
    var monthString: String {
        let month = month
        return monthName(from: month)
    }
    
    var year: String{
        let calendar = Calendar.current
        if(!history.isEmpty){
            let years = calendar.component(.year, from: Date())
            return "\(years)"
        }
        return " "
    }
    var dateFormatter:DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
}


#Preview {
    HistoryView(foreground: .constant(.blue), gradient: .constant(LinearGradient(colors: [.blue.opacity(0.7), .red.opacity(0.7)], startPoint: .bottom, endPoint: .top)))
}
