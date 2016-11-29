//
//  Journal.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 1..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import Foundation

enum EmotionIndex {
    case happy
    case love
    case relieved
    case fun
    case anger
    case sad
    case lonely
    case shame
    case calm
    case feelingless
}

struct Emotion {
    var name:String
    var resource:String
    var value:Int
    
    init(name:String, resource:String, value:Int) {
        self.name = name
        self.resource = resource
        self.value = value
    }
}

var emoArray:Dictionary<EmotionIndex, Emotion> = [
    EmotionIndex.happy: Emotion(name: "행복", resource: "#FED958", value: 4),
    EmotionIndex.love: Emotion(name: "사랑", resource: "#FED3E0", value: 3),
    EmotionIndex.relieved: Emotion(name: "후련", resource: "#D2EEFB", value: 1),
    EmotionIndex.fun: Emotion(name: "재미", resource: "#FFB364", value: 2),
    EmotionIndex.anger: Emotion(name: "분노", resource: "#BE5C5D", value: -4),
    EmotionIndex.sad: Emotion(name: "우울", resource: "#768EFF", value: -3),
    EmotionIndex.lonely: Emotion(name: "외로움", resource: "#E2B7EE", value: -2),
    EmotionIndex.shame: Emotion(name: "자괴감", resource: "#D7D7D7", value: -1),
    EmotionIndex.calm: Emotion(name: "침착", resource: "#E1F7D9", value: 0),
    EmotionIndex.feelingless: Emotion(name: "애매", resource: "#E3DCCA", value: 0)
]

class Journal {
    var ctime:Date
    var memo:String
    var emotion:EmotionIndex
    
    init(ctime: Date, memo: String, emotion: EmotionIndex){
        self.ctime = ctime
        self.memo = memo
        self.emotion = emotion
    }
}

func getJournalOfDate(date: Date) -> Array<Journal> {
    let cal = Calendar(identifier:Calendar.Identifier.gregorian)
    
    return journal.filter({ (j: Journal) -> (Bool) in
        if (cal.dateComponents([Calendar.Component.day], from: j.ctime) == cal.dateComponents([Calendar.Component.day], from: date)) {
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







