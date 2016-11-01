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

let emoArray = [
    EmotionIndex.happy: Emotion(name: "행복", resource: "#000000", value: 1),
    EmotionIndex.love: Emotion(name: "사랑", resource: "#000000", value: 1),
    EmotionIndex.relieved: Emotion(name: "후련함", resource: "#000000", value: 1),
    EmotionIndex.fun: Emotion(name: "재밌음", resource: "#000000", value: 1),
    EmotionIndex.anger: Emotion(name: "분노", resource: "#000000", value: -1),
    EmotionIndex.sad: Emotion(name: "우울", resource: "#000000", value: -1),
    EmotionIndex.lonely: Emotion(name: "외로움", resource: "#000000", value: -1),
    EmotionIndex.shame: Emotion(name: "자괴감", resource: "#000000", value: -1),
    EmotionIndex.calm: Emotion(name: "침착", resource: "#000000", value: 0),
    EmotionIndex.feelingless: Emotion(name: "무감정", resource: "#000000", value: 0)
]

class Journal {
    var ctime:NSDate
    var memo:String
    var emotion:Emotion
    
    init(memo:String, emotion:Emotion){
        self.ctime = NSDate()
        self.memo = memo
        self.emotion = emotion
    }
}







