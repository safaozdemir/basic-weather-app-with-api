//
//  ViewController.swift
//  basicWeatherApp
//
//  Created by Muhammed Safa Ozdemir on 16.02.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tempTxt: UILabel!
    @IBOutlet weak var feelTxt: UILabel!
    @IBOutlet weak var windTxt: UILabel!
    @IBOutlet weak var mainTxt: UILabel!
    @IBOutlet weak var sehirTxt: UITextField!
    let apiKey:String=""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getdataBtn(_ sender: Any) {
        
        let url=URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(sehirTxt.text ?? "")&appid=\(apiKey)")!
        let task=URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?,error: Error?) in
            if let error=error{
                print(error)
                return
            }
            let json=try! JSONSerialization.jsonObject(with: data!,options: [])as?[String:Any]
            DispatchQueue.main.async {
                if let location = json!["sys"] as? [String:Any]{
                    if let maintext = location["country"]  as? String{
                        self.mainTxt.text=String(maintext)
                        
                    }
                }
                if let temp = json!["main"] as? [String:Any]{
                    if let tempText = temp["temp"]  as? Double{
                        self.tempTxt.text=String(Int(tempText-272))
                        
                    }
                    if let feelText = temp["feels_like"]  as? Double{
                        self.feelTxt.text=String(Int(feelText-272))
                        
                    }
                }
                if let wind = json!["wind"] as? [String:Any]{
                    if let windText = wind["speed"]  as? Double{
                        self.windTxt.text=String(Int(windText))
                        
                    }
                }
            }
            
        }
        task.resume()
    }
}

