//
//  SecondViewController.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 1..
//  Copyright © 2016년 gamsung. All rights reserved.
//
import UIKit

enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    private let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private weak var calendar: FSCalendar!
    private weak var eventLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        view.backgroundColor = UIColor.groupTableViewBackground
        self.view = view
        
        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 450 : 300
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: height))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scopeGesture.isEnabled = true
        calendar.allowsMultipleSelection = true
        //    calendar.backgroundColor = [UIColor whiteColor];
        view.addSubview(calendar)
        self.calendar = calendar
        
        calendar.calendarHeaderView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        calendar.calendarWeekdayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.today = nil // Hide the today circle
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        
        calendar.clipsToBounds = true // Remove top/bottom line
        
        let label = UILabel(frame: CGRect(x: 0, y: calendar.frame.maxY + 10, width: self.view.frame.size.width, height: 50))
        label.textAlignment = .center
//        label.font = UIFont.preferredFontForTextStyle(.Subheadline)
        self.view.addSubview(label)
        self.eventLabel = label
        
//        let attributedText = NSMutableAttributedString(string: "")
//        let attatchment = NSTextAttachment()
//        attatchment.image = UIImage(named: "first")!
//        attatchment.bounds = CGRect(x: 0, y: -3, width: attatchment.image!.size.width, height: attatchment.image!.size.height)
//        attributedText.appendAttributedString(NSAttributedString(attachment: attatchment))
//        attributedText.appendAttributedString(NSAttributedString(string: "  Hey Daily Event  "))
//        attributedText.appendAttributedString(NSAttributedString(attachment: attatchment))
//        self.eventLabel.attributedText = attributedText
    }
    
    func calendar(calendar: FSCalendar, cellFor date: NSDate, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date as Date, at: position)
        return cell
    }
    
    
    func calendar(calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: NSDate, at position: FSCalendarMonthPosition) {
        configure(cell: cell, for: date, at: position)
    }
    
    
    func calendar(calendar: FSCalendar, titleFor date: NSDate) -> String? {
        if self.gregorian.isDateInToday(date as Date) {
            return "今"
        }
        return nil
    }
    
    func calendar(calendar: FSCalendar, numberOfEventsFor date: NSDate) -> Int {
        return 2
    }
    
    func calendar(calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
        self.eventLabel.frame.origin.y = calendar.frame.maxY + 10
    }
    
    func calendar(calendar: FSCalendar, didSelect date: NSDate) {
        print("did select date \(self.formatter.string(from: date as Date))")
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date as NSDate, at: position)
        }
    }
    
    func configure(cell: FSCalendarCell, for date: NSDate, at position: FSCalendarMonthPosition) {
        
        let diyCell = cell
        // Custom today circle
        diyCell.imageView.isHidden = !self.gregorian.isDateInToday(date as Date)
        // Configure selection layer
        if position == .current || calendar.scope == .week {
            
            diyCell.eventIndicator.isHidden = false
            
            var selectionType = SelectionType.none
            
            if calendar.selectedDates.contains(date as Date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date as Date, options: NSCalendar.Options.init(rawValue: 0))!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date as Date, options: NSCalendar.Options.init(rawValue: 0))!
                if calendar.selectedDates.contains(date as Date) {
                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                        selectionType = .middle
                    }
                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date as Date) {
                        selectionType = .rightBorder
                    }
                    else if calendar.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                    }
                    else {
                        selectionType = .single
                    }
                }
            }
            else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.shapeLayer.isHidden = true
                return
            }
            
            diyCell.shapeLayer.isHidden = false
            if selectionType == .middle {
                diyCell.shapeLayer.path = UIBezierPath(rect: diyCell.shapeLayer.bounds).cgPath
            }
            else if selectionType == .leftBorder {
                diyCell.shapeLayer.path = UIBezierPath(roundedRect: diyCell.shapeLayer.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: diyCell.shapeLayer.frame.width / 2, height: diyCell.shapeLayer.frame.width / 2)).cgPath
            }
            else if selectionType == .rightBorder {
                diyCell.shapeLayer.path = UIBezierPath(roundedRect: diyCell.shapeLayer.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: diyCell.shapeLayer.frame.width / 2, height: diyCell.shapeLayer.frame.width / 2)).cgPath
            }
            else if selectionType == .single {
                let diameter: CGFloat = min(diyCell.shapeLayer.frame.height, diyCell.shapeLayer.frame.width)
                diyCell.shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: diyCell.contentView.frame.width / 2 - diameter / 2, y: diyCell.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)).cgPath
            }
            
        }
        else if position == .next || position == .previous {
            diyCell.imageView.isHidden = true
            diyCell.shapeLayer.isHidden = true
            diyCell.eventIndicator.isHidden = true
            // Hide default event indicator
            if self.calendar.selectedDates.contains(date as Date) {
                diyCell.titleLabel!.textColor = self.calendar.appearance.titlePlaceholderColor
                // Prevent placeholders from changing text color
            }
        }
    }

}

