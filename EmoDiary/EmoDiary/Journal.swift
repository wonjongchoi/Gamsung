//
//  Journal.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 1..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import Foundation

enum EmotionIndex: Int {
    case happy = 0
    case love = 1
    case relieved = 2
    case fun = 3
    case anger = 4
    case sad = 5
    case lonely = 6
    case shame = 7
    case calm = 8
    case feelingless = 9
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
    EmotionIndex.happy: Emotion(name: "행복", resource: "#FED958", value: 3),
    EmotionIndex.love: Emotion(name: "사랑", resource: "#FED3E0", value: 2),
    EmotionIndex.relieved: Emotion(name: "후련", resource: "#D2EEFB", value: 1),
    EmotionIndex.fun: Emotion(name: "재미", resource: "#FFB364", value: 4),
    EmotionIndex.anger: Emotion(name: "분노", resource: "#BE5C5D", value: -4),
    EmotionIndex.sad: Emotion(name: "우울", resource: "#768EFF", value: -3),
    EmotionIndex.lonely: Emotion(name: "외로움", resource: "#E2B7EE", value: -2),
    EmotionIndex.shame: Emotion(name: "자괴", resource: "#D7D7D7", value: -1),
    EmotionIndex.calm: Emotion(name: "침착", resource: "#E1F7D9", value: 0),
    EmotionIndex.feelingless: Emotion(name: "애매", resource: "#E3DCCA", value: 0)
]

class Journal {
    var jid:Int
    var ctime:Date
    var memo:String
    var emotion:EmotionIndex
    
    init(jid:Int, ctime: Date, memo: String, emotion: EmotionIndex){
        self.jid = jid
        self.ctime = ctime
        self.memo = memo
        self.emotion = emotion
    }
}






