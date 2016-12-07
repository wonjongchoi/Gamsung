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
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var barChartView: BarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Statistics"
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(getter: UIDynamicBehavior.action))
        navigationItem.rightBarButtonItem = settingsButton
        
        let DummyIndex = ["행복","사랑","후련", "재미", "분노", "우울", "외로움", "자괴감", "침착", "애매"]
        let DummyEmo = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 5.0, 10.0, 7.0, 13.0]
        
        setChart(dataPoints: DummyIndex, values : DummyEmo)

     }
    

    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = Array()
        var bardataSet: ChartDataSet!
        var piedataSet: ChartDataSet!
        
        for (i, value) in values.enumerated()
        {
            dataEntries.append(BarChartDataEntry(x: Double(i), y: value))
        }
        
        bardataSet = BarChartDataSet(values: dataEntries, label: "Emotion Statistics")
        
        let bardata = BarChartData(dataSet: bardataSet)
        bardata.barWidth = 0.85
        
//        self.barChartView = BarChartView(frame: CGRect(x: 0, y: 0, width: 480, height: 350))
        
        //barChartView.backgroundColor = NSUIColor.clear
//        barChartView.leftAxis.axisMinimum = 0.0
//        barChartView.rightAxis.axisMinimum = 0.0
        barChartView.data = bardata
        
        bardataSet.colors = ChartColorTemplates.pastel()

        
        piedataSet = PieChartDataSet(values: dataEntries, label: "Emotion Statistics")
        
        let piedata = PieChartData(dataSet: piedataSet)
        pieChartView.data = piedata
        
        piedataSet.colors = ChartColorTemplates.pastel()
        
        
        //var colors: [UIColor] = []
//        lineChartDataSet.colors = ChartColorTemplates.pastel()

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

