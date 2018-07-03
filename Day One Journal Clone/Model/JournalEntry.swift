//
//  JournalEntry.swift
//  Day One Journal Clone
//
//  Created by Vigneshraj Sekar Babu on 6/29/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import Foundation
import RealmSwift

class JournalEntry : Object {
    
    @objc dynamic var text : String = ""
    @objc dynamic var date = Date()
    let pictures = List<Pictures>()
    
  
    func getFormattedDate(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy"
        return formatter.string(from: date)
    }
    
    func getDateComponent(component : String) -> String {
        let formatter = DateFormatter()
        
        switch component {
        case "MMM":
            formatter.dateFormat = "MMM"
        case "d":
            formatter.dateFormat = "d"
        case "yyyy":
            formatter.dateFormat = "yyyy"
        case "MMM yyyy":
            formatter.dateFormat = "MMM yyyy"
        default:
            formatter.dateFormat = "E, d MMM yyyy"
        }
        return formatter.string(from: date)
    }
    
}
