//
//  SettingViewController.swift
//  MyTimer
//
//  Created by taka on 2019/12/12.
//  Copyright © 2019 Swift-mytimer. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    // UIPickerViewに表示するデータをArrayで作成
    let settingArray : [Int] = [10,20,30,40,50,60]
    
    // 設定値を覚えつキーを設定
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // timerSettingPicskerのデリゲートとデータソースの通知先を指定
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        // UserDefaultsの取得
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        
        // Pickerの選択に合わせる
        for row in 0..<settingArray.count {
            if settingArray[row] == timerValue {
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var timerSettingPicker: UIPickerView!
    
    @IBAction func decisionButtonAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // UIPikerViewの列数を設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // UIPckerViewの行数を取得
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
            return settingArray.count
        
    }
        
    // UiPckerViewの表示する内容を設定
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
            return String(settingArray[row])
        
    }
        
        //picker選択時に実行
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int,inComponent component: Int) {
            
        //UserDefaultの設定
        let settings = UserDefaults.standard
        settings.setValue(settingArray[row], forKey: settingKey)
        settings.synchronize()
    }
}
    


