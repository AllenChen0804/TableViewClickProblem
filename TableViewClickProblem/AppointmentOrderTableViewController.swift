//
//  AppointmentOrderTableViewController.swift
//  TableViewClickProblem
//
//  Created by 陳永展 on 2019/10/19.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

class AppointmentOrderTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource{

    
    @IBOutlet weak var travelLocationTextField: UITextField!
    
    var BookingArr=[String]()
    
     var picker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       BookingArr = getTravelMenu()
    initPicker()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    
    
    func initPicker(){    //初始化Picker
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        picker.delegate = self
        picker.dataSource = self
        let doneButton = UIBarButtonItem(title: "確認", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.doneAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.dismissKeyBoard))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        travelLocationTextField.inputAccessoryView = toolBar
        
        travelLocationTextField.inputView = picker
        //加上手勢按鈕
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.delegate = self as? UIGestureRecognizerDelegate
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    func getTravelMenu() -> Array<String>{
        if let url = Bundle.main.url(forResource: "旅遊地點", withExtension: "txt"),
            let content = try?String(contentsOf: url){
            let coachArray = content.components(separatedBy: "\n")
            return coachArray
        }else{
            let array = [String]()
            return array
        }
    }
    

    @objc func doneAction() {
        let row = picker.selectedRow(inComponent: 0)
        travelLocationTextField.text = BookingArr[row]
           self.view.endEditing(true)
       }
       
       @objc func dismissKeyBoard(){
//        self.view.endEditing(true)
         print("tap")
       }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BookingArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BookingArr[row]    
    }
}
