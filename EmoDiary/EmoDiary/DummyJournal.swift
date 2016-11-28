//
//  DummyJournal.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 27..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import Foundation

var journal:Array<Journal> = [
    Journal(ctime: Date(), memo: "찬현오빠 결혼식!", emotion: EmotionIndex.happy),
    Journal(ctime: Date(timeIntervalSinceNow: 60 * 60 * 24 * 2) as Date, memo: "융소... 자살한다....", emotion: EmotionIndex.shame)
]
