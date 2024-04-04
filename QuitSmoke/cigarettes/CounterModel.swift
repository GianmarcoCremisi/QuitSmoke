//
//  CounterModel.swift
//  cigarettes
//
//  Created by Gianmarco Cremisi on 16/11/23.
//

import Foundation
import SwiftData

@Model class CigaretteData: ObservableObject{
    var date: Date
 
    init(date: Date) {
        self.date = date
    }
    
    static func uniqueDates(from history: [CigaretteData]) -> [Date] {
            let uniqueDates = Set(history.map { Calendar.current.startOfDay(for: $0.date) })
            return Array(uniqueDates).sorted(by: { $0 > $1 })
    }

}

