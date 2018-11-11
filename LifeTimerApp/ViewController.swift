//
//  ViewController.swift
//  LifeTimerApp
//
//  Created by 高橋直也 on 2018/11/08.
//  Copyright © 2018 Takahashi Naoya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var passedLifeTime: Int?
    
    var timer: Timer?
    var duration = 0
    let settingKey = "timerValue"
    let now = NSDate()
    var remainSeconds :Int!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var timeDisplay2: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        callData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let setting = UserDefaults.standard
//        setting.removeObject(forKey: "save")
        
        if (setting.object(forKey: "save") == nil) {
            setting.set(20000, forKey: "save")
            passedLifeTime  = setting.integer(forKey: "save")
            print(setting.object(forKey: "save"))
        }
        
        print(setting)
        
        timeDisplay.text = ""
        mainLabel.text = "人生の残り時間"
        
        timerSet()
        displayUpdate()
    }
    
    func displayUpdate() -> Int {
        
        callData()
        //        let settings = UserDefaults.standard
        //        let timerValue = settings.integer(forKey: settingKey)
        
        //  求めた秒数を年月日に変換にして表示
        let minuteSeconds: Int = 60
        let hourSeconds: Int = minuteSeconds * 60
        let daySeconds: Int = hourSeconds * 24
        let yearSeconds: Int = daySeconds * 365
        let maxSeconds: Int = yearSeconds * 80
        
        //  生まれた日 ー> 自由に設定できるようにしたい
        //        var passedLifeTime: () = callData()
        //        var passedLifeTime: Double
        
        //        let birthDayTime = NSDate(timeInterval: TimeInterval(lifeTime), since: now as Date)
        
        //      生まれた日と今との時間差
        //        let span = now.timeIntervalSince(birthDayTime as Date)
        
        //      残り時間 = 80年間 - 生きてきた時間 - アプリ起動からの経過時間
        remainSeconds = maxSeconds + passedLifeTime! - duration
        
        //      日数を算出
        let Day: Int = remainSeconds / daySeconds
        let Hour: Int = (remainSeconds % daySeconds) / hourSeconds
        let Minute: Int = (remainSeconds % daySeconds % hourSeconds) / minuteSeconds
        let Second: Int = remainSeconds % daySeconds % hourSeconds % minuteSeconds
        
        //        settings.register(defaults: [settingKey: remainSeconds])
        print(Day)
        print(Hour)
        print(Minute)
        print(Second)
        
        
        timer = Timer()
        
        timeDisplay.text = "\(String(Day))日"
        
        timeDisplay2.text = "\(String(Hour))時間\(String(Minute))分\(String(Second))秒"
        //        timeDisplay.text = "\(remainSeconds)秒"
        
        return remainSeconds
    }
    
    //    タイマーがゼロになったらと止める
    @objc func timerStop(_ timer:Timer) {
        duration += 1
        if displayUpdate() == 0 {
            duration = 0
            timer.invalidate()
        }
        
    }
    //    現在時刻を取得
    func nowTime() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let nowTime = formatter.string(from: now as Date)
        
        print(nowTime)
    }
    
    func timerSet() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerStop(_:)), userInfo: nil, repeats: true)
    }
    
    func callData() {
        if let passedTime =  UserDefaults.standard.object(forKey: "save") {
            passedLifeTime = passedTime as? Int
        }
    }
}

