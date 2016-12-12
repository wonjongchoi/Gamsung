//
//  CreateViewController.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 12. 8..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    var selectEmo:EmotionIndex = .love

    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet var colorBtns: [UIButton]!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var inputMemo: UITextField!
    
    @IBAction func pickEmotion(_ sender: UIButton) {
        btnSet()
        sender.setTitleColor(UIColor.black, for: .normal)
        
        selectEmo = EmotionIndex(rawValue: sender.tag)!
        
        print("select : \(selectEmo)")
    }
    
    @IBAction func saveJournal(_ sender: UIBarButtonItem) {
        if (inputMemo.text?.characters.count == 0) {
            showToast(view: self, msg: "한줄 메모를 입력해주세요.")
        } else {
            insertJournal(nJournal: Journal(jid: 0, ctime: datePicker.date, memo: inputMemo.text!, emotion: selectEmo))
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
        
        datePicker.maximumDate = Date.init()

        NotificationCenter.default.addObserver(self, selector: #selector(CreateViewController.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateViewController.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        btnSet()
        
        for colorBtn in colorBtns {
            if colorBtn.tag == EmotionIndex.love.rawValue {
                colorBtn.setTitleColor(UIColor.black, for: .normal)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParentViewController){
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    
    func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo!
        
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // 스크롤 업 (텍스트 필드를 키보드 제외한 화면의 y 중간까지 스크롤
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardEndFrame.height, 0.0)
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
        
        let textFieldOrigin:CGPoint = self.inputMemo.frame.origin;
        let textFieldHeight:CGFloat = self.inputMemo.frame.size.height;
        
        var aRect:CGRect = self.view.frame
        aRect.size.height -= keyboardEndFrame.height
        
        if (!aRect.contains(textFieldOrigin))
        {
            //you can add yor desired height how much you want move keypad up, by replacing "textFieldHeight" below
            
            let scrollPoint = CGPoint.init(x: 0.0, y: textFieldOrigin.y - aRect.size.height  + textFieldHeight) //replace textFieldHeight to currentKeyboardSize.height, if you want to move up with more height
            scroll.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let userInfo = notification.userInfo!
        
        //스크롤 다운
        scroll.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func btnSet() {
        for colorBtn in colorBtns {
            colorBtn.setTitle(emoArray[EmotionIndex(rawValue:colorBtn.tag)!]?.name, for: .normal)
            colorBtn.setTitleColor(UIColor.white, for: .normal)
            colorBtn.layer.cornerRadius = colorBtn.fs_width / 2
            colorBtn.backgroundColor = hexStringToUIColor(hex: (emoArray[EmotionIndex(rawValue:colorBtn.tag)!]?.resource)!)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
