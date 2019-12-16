//
//  ViewController.swift
//  MyTimer
//
//  Created by taka on 2019/12/10.
//  Copyright © 2019 Swift-mytimer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // タイマーの変数を作成
    var timer : Timer?

    // カウント（経過時間）の変数を作成
    var  count = 0
    
    // 設定値を扱うキーを設定
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //UserDefaultsのインスタンスを生成
        
        let settings = UserDefaults.standard
        
        // UserDefaultsに初期値を登録
        settings.register(defaults: [settingKey:10])
    }


    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func settingButtonAction(_ sender: Any) {
        // timerをアンラップしてnowTimerに代入
        if let nowTimer = timer {
            
            // もしタイマーが、実行中だったら停止
            if nowTimer.isValid == true {
                
                // タイマー停止
                nowTimer.invalidate()
            }
        }
        
        // 画面遷移を行う
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBAction func strartButtonAction(_ sender: Any) {
        // timerをアンラップしてnowTimerに代入
        if let nowTimer = timer {
            
            // もしタイマーが、実行中だったらスタートしない
            if nowTimer.isValid == true {
                
                // 何も処理しない
                return
            }
        }
        // タイマーをスタート
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        // timerをアンラップしてnowTimerに代入
        if let nowTimer = timer {
            
            // もしタイマーが、実行中だったら停止
            if nowTimer.isValid == true {
                
                // タイマー停止
                nowTimer.invalidate()
            }
        }
    }
    // 画面の更新をする（戻り値：remainCount:残り時間
    func displayUpdate()-> Int {
        // UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        
        // 取得した秒数をtimerValueに渡す
        let timerValue = settings.integer(forKey: settingKey)
        
        // 残り時間(remainCount)を生成
        let remainCount = timerValue - count
        
        // remainCount（残りの時間）をラベルに表示
        // １分以上は分で表示する
        if remainCount >= 60 {
            let minuteCount = remainCount / 60
            countDownLabel.text = "\(minuteCount)分"
            
        }
        // １分未満は秒で表示する
        else if remainCount < 60 {
            countDownLabel.text = "\(remainCount)秒"
        }
//        countDownLabel.text = "残り\(remainCount)秒"
        
        // 残り時間を戻り値に設定
        return remainCount
        
    }
    
    // 経過時間の処理
    @objc func timerInterrupt(_ timer:Timer) {
        
        // count（経過時間）に+1していく
        count += 1
        
        // count（残り時間）が0以下のとき、タイマーを止める
        if displayUpdate() <= 0 {
            
            //初期化処理
            count = 0
            
            // タイマー停止
            timer.invalidate()
        }
        
    }
    
    // 画面切り替えのタイミングで処理を行う
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // カウント（経過時間）を0にする
        count = 0
        
        // タイマーの表示を更新する
        _ = displayUpdate()
    }
    
}

