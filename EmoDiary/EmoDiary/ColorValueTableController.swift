//
//  ColorValueSettingController.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 12. 9..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import UIKit

class ColorValueTableController: UITableViewController {
    @IBOutlet var colorBtns: [UIButton]!
    @IBOutlet var positiveSliders: [UISlider]!
    @IBOutlet var negativeSliders: [UISlider]!

    @IBAction func setSliderAction(_ sender: UISlider) {
        sender.setValue(Float(lroundf(sender.value)), animated: true)
    }

    func saveColorValue(_ sender: UIBarButtonItem) {
        var values:Array<Int> = []
        
        for pSlider in positiveSliders {
            if (values.contains(Int(pSlider.value))) {
                break
            } else {
                values.append(Int(pSlider.value))
            }
        }
        
        if (values.count != 4) {
            showToast(view: self, msg: "긍정적인 감정에 중복되는 값이 있습니다.")
            return
        }
        
        values.removeAll()
        
        for nSlider in negativeSliders {
            if (values.contains(Int(nSlider.value))) {
                break
            } else {
                values.append(Int(nSlider.value))
            }
        }
        
        if (values.count != 4) {
            showToast(view: self, msg: "부정적인 감정에 중복되는 값이 있습니다.")
            return
        }
        
        for pSlider in positiveSliders {
            emoArray[EmotionIndex(rawValue: pSlider.tag)!]?.value = Int(pSlider.value)
        }
        
        for nSlider in negativeSliders {
            emoArray[EmotionIndex(rawValue: nSlider.tag)!]?.value = Int(nSlider.value)
        }
        
        showToast(view: self, msg: "설정값이 저장되었습니다.")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.saveColorValue(_:)))
//        self.navigationItem.leftBarButtonItem = saveButton
        
        for colorBtn in colorBtns {
            colorBtn.layer.cornerRadius = colorBtn.fs_width / 2
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for pSlider in positiveSliders {
            pSlider.value = Float((emoArray[EmotionIndex(rawValue: pSlider.tag)!]?.value)!)
        }
        
        for nSlider in negativeSliders {
            nSlider.value = Float((emoArray[EmotionIndex(rawValue: nSlider.tag)!]?.value)!)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
