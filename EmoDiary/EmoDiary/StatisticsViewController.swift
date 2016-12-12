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
        
        self.navigationItem.title = "Statistics"

        self.tabBarController?.tabBar.isHidden = false
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setChart(datatype: segmentedControl.selectedSegmentIndex)   //default : week chart
    }
    
    func setChart(datatype : Int) {
        var dataEntries: [ChartDataEntry] = Array()
        var pieEntries: [ChartDataEntry] = Array()
        var bardataSet: ChartDataSet!
        var piedataSet: ChartDataSet!
        
        var pieColorIndex:Array<EmotionIndex> = []
        var pieValues:Array<Double> = []
        
        var barValues:Array<Double> = []
        
        var day:Int = 7
        
        if datatype == 0 {
            day = 7
        } else if datatype == 1 {
            day = 31
        } else if datatype == 2 {
            day = 365
        }
        
        barValues.removeAll()
        pieValues.removeAll()
        
        for emoIndex in emoIndexArr {
            let value = selectCountEmo(emoIndex: emoIndex, day: day)
            barValues.append(Double(value))
            
            if (value != 0) {
                pieValues.append(Double(value))
                pieColorIndex.append(emoIndex)
            }
        }
        
        for (i, value) in barValues.enumerated()
        {
            dataEntries.append(BarChartDataEntry(x: Double(i), y: value))
            print(dataEntries)
            
        }
        
        for value in pieValues {
            pieEntries.append(PieChartDataEntry(value: Double(value)))
        }
        
        bardataSet = BarChartDataSet(values: dataEntries, label: "Emotion Statistics")
        
        let bardata = BarChartData(dataSet: bardataSet)
        //bardata.barWidth = 0.85
       
        barChartView.data = bardata
        barChartView.doubleTapToZoomEnabled = false
        
        piedataSet = PieChartDataSet(values: pieEntries, label: "Emotion Statistics")
        pieChartView.legend.enabled = false

        
        let piedata = PieChartData(dataSet: piedataSet)
        pieChartView.data = piedata
        pieChartView.usePercentValuesEnabled = true
        pieChartView.descriptionText = " "
        
        var indexArr:Array<String> = [] //for barchart index
        
        bardataSet.colors.removeAll()
        piedataSet.colors.removeAll()
        
        for emoIndex in emoIndexArr {
            bardataSet.colors.append(hexStringToUIColor(hex: (emoArray[emoIndex]?.resource)!))
            
            indexArr.append((emoArray[emoIndex]?.name)!)
        }
        
        for emoIndex in pieColorIndex {
            piedataSet.colors.append(hexStringToUIColor(hex: (emoArray[emoIndex]?.resource)!))
        }
        
        for element in indexArr {
            print(element)
        }
        
        barChartView.xAxis.labelPosition = .bottom
        barChartView.rightAxis.drawLabelsEnabled = false
        barChartView.descriptionText = ""
        barChartView.legend.enabled = false
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.rightAxis.axisMinimum = 0.0

        
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)

        barChartView.xAxis.valueFormatter = DefaultAxisValueFormatter(block: {(index, _) in
            return indexArr[Int(index)]
        })
        
        barChartView.xAxis.setLabelCount(indexArr.count, force: false)
        
        barChartView.xAxis.granularity = 1.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

