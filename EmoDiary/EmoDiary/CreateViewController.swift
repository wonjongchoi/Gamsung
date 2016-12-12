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

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var inputMemo: UITextField!
    
    @IBOutlet weak var love: UIButton!
    @IBOutlet weak var lonely: UIButton!
    @IBOutlet weak var calm: UIButton!
    @IBOutlet weak var relieved: UIButton!
    @IBOutlet weak var sad: UIButton!
    @IBOutlet weak var shame: UIButton!
    @IBOutlet weak var fun: UIButton!
    @IBOutlet weak var feelingless: UIButton!
    @IBOutlet weak var anger: UIButton!
    @IBOutlet weak var happy: UIButton!
    
    @IBAction func pickEmotion(_ sender: UIButton) {
        nogadaBtnSet()
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
        
        nogadaBtnSet()
        
        self.love.setTitleColor(UIColor.black, for: .normal)
        
        datePicker.maximumDate = Date.init()
        

        NotificationCenter.default.addObserver(self, selector: #selector(CreateViewController.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateViewController.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
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
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let userInfo = notification.userInfo!
        
        //스크롤 다운
        
    }
    
    func nogadaBtnSet() {
        self.happy.setTitle(emoArray[.happy]?.name, for: .normal)
        self.happy.setTitleColor(UIColor.white, for: .normal)
        self.happy.layer.cornerRadius = self.happy.fs_width / 2
        self.happy.backgroundColor = hexStringToUIColor(hex: (emoArray[.happy]?.resource)!)
        self.love.setTitle(emoArray[.love]?.name, for: .normal)
        self.love.setTitleColor(UIColor.white, for: .normal)
        self.love.layer.cornerRadius = self.love.fs_width / 2
        self.love.backgroundColor = hexStringToUIColor(hex: (emoArray[.love]?.resource)!)
        self.relieved.setTitle(emoArray[.relieved]?.name, for: .normal)
        self.relieved.setTitleColor(UIColor.white, for: .normal)
        self.relieved.layer.cornerRadius = self.relieved.fs_width / 2
        self.relieved.backgroundColor = hexStringToUIColor(hex: (emoArray[.relieved]?.resource)!)
        self.fun.setTitle(emoArray[.fun]?.name, for: .normal)
        self.fun.setTitleColor(UIColor.white, for: .normal)
        self.fun.layer.cornerRadius = self.fun.fs_width / 2
        self.fun.backgroundColor = hexStringToUIColor(hex: (emoArray[.fun]?.resource)!)
        self.anger.setTitle(emoArray[.anger]?.name, for: .normal)
        self.anger.setTitleColor(UIColor.white, for: .normal)
        self.anger.layer.cornerRadius = self.anger.fs_width / 2
        self.anger.backgroundColor = hexStringToUIColor(hex: (emoArray[.anger]?.resource)!)
        self.sad.setTitle(emoArray[.sad]?.name, for: .normal)
        self.sad.setTitleColor(UIColor.white, for: .normal)
        self.sad.layer.cornerRadius = self.sad.fs_width / 2
        self.sad.backgroundColor = hexStringToUIColor(hex: (emoArray[.sad]?.resource)!)
        self.lonely.setTitle(emoArray[.lonely]?.name, for: .normal)
        self.lonely.setTitleColor(UIColor.white, for: .normal)
        self.lonely.layer.cornerRadius = self.lonely.fs_width / 2
        self.lonely.backgroundColor = hexStringToUIColor(hex: (emoArray[.lonely]?.resource)!)
        self.shame.setTitle(emoArray[.shame]?.name, for: .normal)
        self.shame.setTitleColor(UIColor.white, for: .normal)
        self.shame.layer.cornerRadius = self.shame.fs_width / 2
        self.shame.backgroundColor = hexStringToUIColor(hex: (emoArray[.shame]?.resource)!)
        self.calm.setTitle(emoArray[.calm]?.name, for: .normal)
        self.calm.setTitleColor(UIColor.white, for: .normal)
        self.calm.layer.cornerRadius = self.calm.fs_width / 2
        self.calm.backgroundColor = hexStringToUIColor(hex: (emoArray[.calm]?.resource)!)
        self.feelingless.setTitle(emoArray[.feelingless]?.name, for: .normal)
        self.feelingless.setTitleColor(UIColor.white, for: .normal)
        self.feelingless.layer.cornerRadius = self.feelingless.fs_width / 2
        self.feelingless.backgroundColor = hexStringToUIColor(hex: (emoArray[.feelingless]?.resource)!)
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
