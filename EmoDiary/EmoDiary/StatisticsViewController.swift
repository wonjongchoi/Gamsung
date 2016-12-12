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
    
    var values:Array<Double> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Statistics"

        self.tabBarController?.tabBar.isHidden = false
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setChart(datatype: segmentedControl.selectedSegmentIndex)   //default : week chart
    }
    
    func setChart(datatype : Int) {
        var dataEntries: [ChartDataEntry] = Array()
        var bardataSet: ChartDataSet!
        var piedataSet: ChartDataSet!
        
        var day:Int = 7
        
        if datatype == 0 {
            day = 7
        } else if datatype == 1 {
            day = 31
        } else if datatype == 2 {
            day = 365
        }
        
        values.removeAll()
        
        for emoIndex in emoIndexArr {
            values.append(Double(selectCountEmo(emoIndex: emoIndex, day: day)))
        }
        
        for (i, value) in values.enumerated()
        {
            dataEntries.append(BarChartDataEntry(x: Double(i), y: value))
        }
        
        bardataSet = BarChartDataSet(values: dataEntries, label: "Emotion Statistics")
        
        let bardata = BarChartData(dataSet: bardataSet)
        //bardata.barWidth = 0.85
       
        barChartView.data = bardata
        barChartView.doubleTapToZoomEnabled = false
        
        piedataSet = PieChartDataSet(values: dataEntries, label: "Emotion Statistics")
        pieChartView.descriptionText = " "
        pieChartView.legend.enabled = false

        
        let piedata = PieChartData(dataSet: piedataSet)
        pieChartView.data = piedata

//        piedataSet.colors = ChartColorTemplates.pastel()
        
        var indexArr:Array<String> = [] //for barchart index
        
        bardataSet.colors.removeAll()
        piedataSet.colors.removeAll()
        
        for emoIndex in emoIndexArr {
            bardataSet.colors.append(hexStringToUIColor(hex: (emoArray[emoIndex]?.resource)!))
            piedataSet.colors.append(hexStringToUIColor(hex: (emoArray[emoIndex]?.resource)!))
            
            indexArr.append((emoArray[emoIndex]?.name)!)
        }
        
        for element in indexArr {
            print(element)
        }
//
//        var axisLabelModulus = Int(1)
//        var _isAxisModulusCustom = false
        
        barChartView.xAxis.labelPosition = .bottom
        barChartView.rightAxis.drawLabelsEnabled = false
        barChartView.descriptionText = ""
        barChartView.legend.enabled = false
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)

        
        barChartView.xAxis.valueFormatter = DefaultAxisValueFormatter(block: {(index, _) in
            return indexArr[Int(index)]
        })
        
        barChartView.xAxis.setLabelCount(indexArr.count, force: false)
        
        //barChartView.xAxis.granularity = 1.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

