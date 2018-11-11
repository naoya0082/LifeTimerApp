import UIKit

class SetViewController: UIViewController {
    
    let calendar = Calendar(identifier: .gregorian)
    //現在日時
    let now = Date()
    let formatter = DateFormatter()
    
    
    @IBOutlet weak var announceLabel: UILabel!
    @IBOutlet weak var picker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //今日の日付を表示する関数
    func getToday(format:String = "yyyy/MM/dd") -> String {
        //今日の日付
        let now = Date()
        formatter.dateFormat = format
        //yyyy/MM/dd形式で出力させる
        return formatter.string(from: now as Date)
    }
    
    @IBAction func pickerButton(_ sender: Any) {
        formatter.dateFormat = "yyyy年MM月dd日"
        formatter.locale = Locale(identifier: "ja_JP")
        announceLabel.text = "\(formatter.string(from: picker.date))"
        
        let birthdayDate = picker.date
        
        print(picker.date.timeIntervalSinceNow)
        
        
        let timeDifference = Int(birthdayDate.timeIntervalSinceNow)
        print(timeDifference)
        
        if timeDifference != nil {
            UserDefaults.standard.set(timeDifference, forKey: "save")
            print("timeDifference is saved")
            //        ↑生年月日と今の差(秒)を取得
            
        }
    }
}
