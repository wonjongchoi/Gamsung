//
//  TimelineTableViewController.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 27..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.sㄴ
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journal.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // 셀이 큐에 있는지 확인하고 있으면 큐에서 뽑아서 재사용 하는 코드
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TimelineTableCell", for: indexPath) as! TimelineTableViewCell
        
        let cal = Calendar(identifier:Calendar.Identifier.gregorian)
        
        // 셀의 데이터와 이미지 설정 코드
        let row = indexPath.row
        
//        cell.timeLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
//        cell.dateLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
//        cell.memoLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        
        let ctime = journal[row].ctime
        let dateFormatter = DateFormatter()
        
        if (row != 0 && cal.dateComponents([Calendar.Component.day], from: ctime, to: journal[row - 1].ctime).day == 0) {
            cell.dateLabel.isHidden = true
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            cell.dateLabel.text = dateFormatter.string(from: ctime)
            cell.dateLabel.isHidden = false
        }
        
        cell.memoLabel.text = journal[row].memo
        
        dateFormatter.dateFormat = "a HH:mm"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        cell.timeLabel.text = dateFormatter.string(from: ctime)
        
        let emotion = journal[row].emotion
        cell.emotionColor.backgroundColor = hexStringToUIColor(hex: (emoArray[emotion]?.resource)!)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}