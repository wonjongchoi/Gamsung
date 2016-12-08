//
//  FirstViewController.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 1..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Statistics"
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(getter: UIDynamicBehavior.action))
        navigationItem.rightBarButtonItem = settingsButton

        self.tabBarController?.tabBar.isHidden = false
        
        // Do any additional setup after loading the view.
//        let ys1 = Array(1..<10).map { x in return Int(arc4random_uniform(6) + 1) }
//        let ys2 = Array(1..<10).map { x in return Int(arc4random_uniform(6) + 1) }
        
//        let yse1 = [BarChartDataEntry(x: Double(0), y: Double(4))]//ys1.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: Double(y)) }
//        let yse2 = ys2.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
        
        let data = BarChartData()
        let ds1 = BarChartDataSet(values: [BarChartDataEntry(x: Double(0), y: Double(4))], label: "A1")
        ds1.colors = [UIColor.yellow]
        let ds2 = BarChartDataSet(values: [BarChartDataEntry(x: Double(1), y: Double(10))], label: "A2")
        ds2.colors = [UIColor.cyan]
        let ds3 = BarChartDataSet(values: [BarChartDataEntry(x: Double(2), y: Double(4))], label: "A3")
        ds3.colors = [UIColor.orange]
        let ds4 = BarChartDataSet(values: [BarChartDataEntry(x: Double(3), y: Double(4))], label: "A4")
        ds4.colors = [UIColor.magenta]
        data.addDataSet(ds1)
        data.addDataSet(ds2)
        data.addDataSet(ds3)
        data.addDataSet(ds4)
        
//        let ds2 = BarChartDataSet(values: yse2, label: "World")
//        ds2.colors = [UIColor.blue]
//        data.addDataSet(ds2)
        self.barChartView.data = data
        
        self.barChartView.chartDescription?.text = "Barchart Demo"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

