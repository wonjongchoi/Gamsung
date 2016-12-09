//
//  SecondViewController.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 1..
//  Copyright © 2016년 gamsung. All rights reserved.
//
import UIKit
//import Charts

enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
//    @IBOutlet weak var lineChartView: LineChartView!
    
    private let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private weak var calendar: FSCalendar!
    
    private var journal:Array<Journal> = []
    
    @IBAction func goToday(_ sender: UIBarButtonItem) {
        calendar.select(Date.init(), scrollToDate: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Calendar"
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.journal = selectAllJournal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 2번째 화면에서 이 클래스의 인스턴스로 넘어올 경우 해당함수가 호출된다.
    @IBAction func returned(segue:UIStoryboardSegue){
    }
    
    override func loadView() {
        // In loadView or viewDidLoad
        
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.white
        self.view = view
        
        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 450 : 300
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: height))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scopeGesture.isEnabled = true
        view.addSubview(calendar)
        self.calendar = calendar
        
        calendar.calendarHeaderView.backgroundColor = UIColor.white
        calendar.calendarWeekdayView.backgroundColor = UIColor.white
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.today = nil // Hide the today circle
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.appearance.todayColor = UIColor.orange
        calendar.appearance.borderSelectionColor = UIColor.orange
        calendar.appearance.selectionColor = UIColor.white
        calendar.appearance.titleSelectionColor = UIColor.black
        
//        calendar.appearance.headerDateFormat = "yyyy MMMM";
        
        calendar.appearance.headerDateFormat = "yyyy / MM";
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        
//        calendar.appearance.eventDefaultColor = hexStringToUIColor(hex: emoArray[EmotionIndex.calm]!.resource)
        
//        calendar.clipsToBounds = true // Remove top/bottom line
        
//        let colorTop =  hexStringToUIColor(hex: "#18CEE4").cgColor
//        let colorBottom = hexStringToUIColor(hex: "#ABFFD9").cgColor
        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [ colorTop, colorBottom]
//        gradientLayer.locations = [ 0.0, 1.0]
//        gradientLayer.frame = calendar.contentView.bounds
//        calendar.contentView.layer.addSublayer(gradientLayer)
//        calendar.layer.addSublayer(gradientLayer)
//        
//        let label = UILabel(frame: CGRect(x: 0, y: calendar.frame.maxY + 10, width: self.view.frame.size.width, height: 50))
//        label.textAlignment = .center
////        label.font = UIFont.preferredFontForTextStyle(.Subheadline)
//        self.view.addSubview(label)
//        self.eventLabel = label
        
//        let attributedText = NSMutableAttributedString(string: "")
//        let attatchment = NSTextAttachment()
//        attatchment.image = UIImage(named: "first")!
//        attatchment.bounds = CGRect(x: 0, y: -3, width: attatchment.image!.size.width, height: attatchment.image!.size.height)
//        attributedText.appendAttributedString(NSAttributedString(attachment: attatchment))
//        attributedText.appendAttributedString(NSAttributedString(string: "  Hey Daily Event  "))
//        attributedText.appendAttributedString(NSAttributedString(attachment: attatchment))
//        self.eventLabel.attributedText = attributedText
        calendar.select(Date.init())
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date as Date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        configure(cell: cell, for: date as NSDate, at: position)
    }
    
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return getJournalOfDate(journal: self.journal, date: date).count
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
        //self.eventLabel.frame.origin.y = calendar.frame.maxY + 10
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        print("did select date \(self.formatter.string(from: date as Date))")
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date as NSDate, at: position)
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        var result:[UIColor] = []
        
        for j in getJournalOfDate(journal: self.journal, date: date) {
            result.append(hexStringToUIColor(hex: (emoArray[j.emotion]?.resource)!))
        }
        
        return result
    }
    
    func configure(cell: FSCalendarCell, for date: NSDate, at position: FSCalendarMonthPosition) {
        
        let diyCell = cell
        // Custom today circle
        diyCell.imageView.isHidden = !self.gregorian.isDateInToday(date as Date)
        
        diyCell.eventIndicator.color = calendar(calendar, appearance: calendar.appearance, eventDefaultColorsFor: date as Date)
        
//        print(diyCell.eventIndicator.)
//        diyCell.eventIndicator.color =
        // Configure selection layer
//        if position == .current || calendar.scope == .week {
//            
//            diyCell.eventIndicator.isHidden = false
//            
//            var selectionType = SelectionType.none
//            
//            if calendar.selectedDates.contains(date as Date) {
//                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date as Date, options: NSCalendar.Options.init(rawValue: 0))!
//                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date as Date, options: NSCalendar.Options.init(rawValue: 0))!
//                if calendar.selectedDates.contains(date as Date) {
//                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
//                        selectionType = .middle
//                    }
//                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date as Date) {
//                        selectionType = .rightBorder
//                    }
//                    else if calendar.selectedDates.contains(nextDate) {
//                        selectionType = .leftBorder
//                    }
//                    else {
//                        selectionType = .single
//                    }
//                }
//            }
//            else {
//                selectionType = .none
//            }
//            if selectionType == .none {
//                diyCell.shapeLayer.isHidden = true
//                return
//            }
//            
//            diyCell.shapeLayer.isHidden = false
//            if selectionType == .middle {
//                diyCell.shapeLayer.path = UIBezierPath(rect: diyCell.shapeLayer.bounds).cgPath
//            }
//            else if selectionType == .leftBorder {
//                diyCell.shapeLayer.path = UIBezierPath(roundedRect: diyCell.shapeLayer.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: diyCell.shapeLayer.frame.width / 2, height: diyCell.shapeLayer.frame.width / 2)).cgPath
//            }
//            else if selectionType == .rightBorder {
//                diyCell.shapeLayer.path = UIBezierPath(roundedRect: diyCell.shapeLayer.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: diyCell.shapeLayer.frame.width / 2, height: diyCell.shapeLayer.frame.width / 2)).cgPath
//            }
//            else if selectionType == .single {
//                let diameter: CGFloat = min(diyCell.shapeLayer.frame.height, diyCell.shapeLayer.frame.width)
//                diyCell.shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: diyCell.contentView.frame.width / 2 - diameter / 2, y: diyCell.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)).cgPath
//            }
//            
//        }
//        else if position == .next || position == .previous {
//            diyCell.imageView.isHidden = true
//            diyCell.shapeLayer.isHidden = true
//            diyCell.eventIndicator.isHidden = true
//            // Hide default event indicator
//            if self.calendar.selectedDates.contains(date as Date) {
//                diyCell.titleLabel!.textColor = self.calendar.appearance.titlePlaceholderColor
//                // Prevent placeholders from changing text color
//            }
//        }
    }
    
//    func setChart(dataPoints: [String], values: [Double]) {
//        
//        var dataEntries: [ChartDataEntry] = Array()
//        var linedataSet: ChartDataSet!
//        
//        for (i, value) in values.enumerated()
//        {
//            dataEntries.append(ChartDataEntry(x: Double(i), y: value))
//        }
//        
//        linedataSet = LineChartDataSet(values: dataEntries, label: "Emotion Statistics")
//        
//        let linedata = LineChartData(dataSet: linedataSet)
//        
//        self.lineChartView.data = linedata
//        
//        linedataSet.colors = ChartColorTemplates.pastel()
//        
//    }

}

