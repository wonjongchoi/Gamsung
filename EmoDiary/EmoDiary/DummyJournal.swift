//
//  DummyJournal.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 27..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import Foundation

func getFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    return formatter
}

var journal:Array<Journal> = [
    Journal(ctime: getFormatter().date(from: "2016-11-27 12:00")!, memo: "찬현오빠 결혼식!", emotion: EmotionIndex.happy),
    Journal(ctime: getFormatter().date(from: "2016-11-27 15:00")!, memo: "융소... 자살한다....", emotion: EmotionIndex.shame),
    Journal(ctime: getFormatter().date(from: "2016-11-28 18:00")!, memo: "병원가야징", emotion: EmotionIndex.sad),
    Journal(ctime: getFormatter().date(from: "2016-11-29 15:00")!, memo: "화난다 이벤트 외않됀데...", emotion: EmotionIndex.anger),
    Journal(ctime: getFormatter().date(from: "2016-11-29 16:00")!, memo: "이벤트 색 바뀜!!!", emotion: EmotionIndex.love)
]
