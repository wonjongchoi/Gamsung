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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
            
        case 0 :
            print("0")
            setChart(datatype: 0)   //week chart
            break
        case 1:
            print("1")
            setChart(datatype: 1)   //month chart
            break
        case 2:
            print("2")
            setChart(datatype: 2)   //year chart
            break
        default:
            print("0")
            break
        }
    }
    
    let emoIndexArr = [EmotionIndex.fun, EmotionIndex.happy, EmotionIndex.love, EmotionIndex.relieved, EmotionIndex.calm, EmotionIndex.feelingless, EmotionIndex.shame, EmotionIndex.lonely, EmotionIndex.sad, EmotionIndex.anger]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var datatype:Int
        
        self.navigationItem.title = "Statistics"

        self.tabBarController?.tabBar.isHidden = false
    
        //let DummyIndex = ["행복","사랑","후련", "재미", "분노", "우울", "외로움", "자괴감", "침착", "애매"]
        //let DummyEmo = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 5.0, 10.0, 7.0, 13.0]
        
        setChart(datatype: 0)   //default : week chart

     }
    
    func setChart(datatype : Int) {
        var values:Array<Double> = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 5.0, 10.0, 7.0, 13.0]
        
        var dataEntries: [ChartDataEntry] = Array()
        var bardataSet: ChartDataSet!
        var piedataSet: ChartDataSet!
        
        if datatype == 0 {
            //week dataset
        } else if datatype == 1 {
            //month dataset
        } else if datatype == 2 {
            //year dataset
        } else {
            
        }
        
        
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
        
//        bardataSet.colors = ChartColorTemplates.pastel()

        
        piedataSet = PieChartDataSet(values: dataEntries, label: "Emotion Statistics")
        
        let piedata = PieChartData(dataSet: piedataSet)
        pieChartView.data = piedata
        
//        piedataSet.colors = ChartColorTemplates.pastel()
        
        bardataSet.colors.removeAll()
        piedataSet.colors.removeAll()
        
        for emoIndex in emoIndexArr {
            bardataSet.colors.append(hexStringToUIColor(hex: (emoArray[emoIndex]?.resource)!))
            piedataSet.colors.append(hexStringToUIColor(hex: (emoArray[emoIndex]?.resource)!))
        }
        
        //var colors: [UIColor] = []
//        lineChartDataSet.colors = ChartColorTemplates.pastel()

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

