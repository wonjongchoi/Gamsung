//
//  TimelineViewController.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 8..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Timeline"
//        let createButton = UIBarButtonItem(image: UIImage(named: "create"), style: .plain, target: self, action: #selector(getter: UIDynamicBehavior.action))
//                navigationItem.rightBarButtonItem = createButton
        // Do any additional setup after loading the view.
        
        
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
