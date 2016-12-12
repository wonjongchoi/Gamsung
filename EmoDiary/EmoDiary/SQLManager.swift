//
//  SQLManager.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 12. 6..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import Foundation
import FMDB

let DB_FILE_NAME = "/journal.db"

let fileMgr = FileManager.default
let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
let docsDir = dirPaths[0] as String
var databasePath:String = docsDir.appending(DB_FILE_NAME)

func initDB() {
    
    if !fileMgr.fileExists(atPath: databasePath as String) {
        // FMDB 인스턴스를 이용하여 DB 체크
        let journalDB = FMDatabase(path: databasePath as String)
        
        if journalDB == nil {
            print("journal.db Not Found : \(journalDB?.lastErrorMessage())")
        }
        
        // DB 오픈
        if (journalDB?.open())! {
            // 테이블 생성처리
            let sql_stmt = "CREATE TABLE IF NOT EXISTS JOURNAL ( jid INTEGER PRIMARY KEY AUTOINCREMENT, memo TEXT NOT NULL, emo_index INTEGER NOT NULL, ctime DATETIME NOT NULL)"
            if !(journalDB?.executeStatements(sql_stmt))! {
                print("Create Table Error : \(journalDB?.lastErrorMessage())")
            }
            journalDB?.close()
        } else {
            print("journal.db Open Error : \(journalDB?.lastErrorMessage())")
        }
    } else {
        print(DB_FILE_NAME + " is aleady exist")
    }
}

func insertJournal(nJournal: Journal) {
    let journalDB = FMDatabase(path: databasePath as String)
    
    if (journalDB?.open())! {
        print("INSERT Memo : \(nJournal.memo) | EmoIndex : \(nJournal.emotion)")
        // SQL에 데이터를 입력하기 전 바로 입력하게 되면 "Optional('')"와 같은 문자열이 text문자열을 감싸게 되므로 뒤에 !을 붙여 옵셔널이 되지 않도록 한다.
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:SS"
        
        let insertSQL = "INSERT INTO JOURNAL (memo, emo_index, ctime) VALUES ('\(nJournal.memo)', \(nJournal.emotion.rawValue), DATETIME('\(dateFormatter.string(from: nJournal.ctime))'))"
        print("[Save to DB] SQL to Insert => \(insertSQL)")
        
        let result = journalDB?.executeUpdate(insertSQL, withArgumentsIn: nil)
        
        if !result! {
            print("DB Insert Error : \(journalDB?.lastErrorMessage())")
        } else {
            // DB 저장 완료 후 journal에 추가
            journal.append(nJournal)
        }
        
        journalDB?.close()
    } else {
        print("journal.db Open Error : \(journalDB?.lastErrorMessage())")
    }
}

func selectCountEmo(emoIndex: EmotionIndex, day: Int) -> Int {
    var count:Int = 0
    let journalDB = FMDatabase(path: databasePath as String)
    
    if (journalDB?.open())! {
        print("SELECT ALL TUPLES FROM JOURNAL")
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:SS"
        
        let selectSQL = "SELECT count(jid) as count FROM JOURNAL WHERE emo_index = \(emoIndex.rawValue) AND ctime >= DATETIME('now', '-\(day) days') AND ctime <= DATETIME('now', '+1 day')"
        
        let result:FMResultSet = (journalDB?.executeQuery(selectSQL, withArgumentsIn: nil))!
        
        if result.next() {
            count = Int(result.int(forColumn: "count"))
            print("select count : \(count)")
        }
        
        journalDB?.close()
    } else {
        print("journal.db Open Error : \(journalDB?.lastErrorMessage())")
    }
    
    return count
}

func selectRecentJournal() -> Array<Journal> {
    var resultArr:Array<Journal> = []
    
    let journalDB = FMDatabase(path: databasePath as String)
    
    if (journalDB?.open())! {
        print("SELECT ALL TUPLES FROM JOURNAL")
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:SS"
        
        let selectSQL = "SELECT jid, ctime, memo, emo_index FROM JOURNAL ORDER BY ctime DESC LIMIT 10"
        
        let result:FMResultSet = (journalDB?.executeQuery(selectSQL, withArgumentsIn: nil))!
        
        while result.next() {
            
            resultArr.append(Journal(jid: Int(result.int(forColumn: "jid")), ctime: dateFormatter.date(from: result.string(forColumn: "ctime"))!, memo: result.string(forColumn: "memo"), emotion: EmotionIndex(rawValue: Int(result.int(forColumn: "emo_index")))!))
        }
        
        journalDB?.close()
    } else {
        print("journal.db Open Error : \(journalDB?.lastErrorMessage())")
    }
    
    return resultArr
}

func selectAllJournal() -> Array<Journal> {
    var resultArr:Array<Journal> = []
    
    let journalDB = FMDatabase(path: databasePath as String)
    
    if (journalDB?.open())! {
        print("SELECT ALL TUPLES FROM JOURNAL")
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:SS"
        
        let selectSQL = "SELECT jid, ctime, memo, emo_index FROM JOURNAL ORDER BY ctime DESC LIMIT 20"
        
        let result:FMResultSet = (journalDB?.executeQuery(selectSQL, withArgumentsIn: nil))!
        
        while result.next() {
            
            resultArr.append(Journal(jid: Int(result.int(forColumn: "jid")), ctime: dateFormatter.date(from: result.string(forColumn: "ctime"))!, memo: result.string(forColumn: "memo"), emotion: EmotionIndex(rawValue: Int(result.int(forColumn: "emo_index")))!))
        }
        
        journalDB?.close()
    } else {
        print("journal.db Open Error : \(journalDB?.lastErrorMessage())")
    }
    
    return resultArr
}
