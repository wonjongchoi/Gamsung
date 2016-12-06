//
//  AppManager.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 12. 7..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import Foundation

func getJournalOfDate(date: Date) -> Array<Journal> {
    let cal = Calendar(identifier:Calendar.Identifier.gregorian)
    
    return journal.filter({ (j: Journal) -> (Bool) in
        if (cal.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day], from: j.ctime) == cal.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day], from: date)) {
            return true
        } else {
            return false
        }
    })
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
