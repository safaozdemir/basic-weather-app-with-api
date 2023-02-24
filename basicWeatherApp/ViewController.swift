//
//  ViewController.swift
//  basicWeatherApp
//
//  Created by Muhammed Safa Ozdemir on 16.02.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var feelLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var cityLabel: UITextField!
    let apiKey: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapGetData(_ sender: Any) {
        guard let city = cityLabel.text else {
            print("sehir txt is null")
            return
        }
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)") else {
            print("error")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, _: URLResponse?, error: Error?) in
            if let error = error {
                print(error)
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            DispatchQueue.main.async {
                if let location = json!["sys"] as? [String: Any] {
                    if let maintext = location["country"] as? String {
                        self.mainLabel.text = String(maintext)
                    }
                }
                if let temp = json!["main"] as? [String: Any] {
                    if let tempText = temp["temp"] as? Double {
                        self.tempLabel.text = String(Int(tempText - 272))
                    }
                    if let feelText = temp["feels_like"] as? Double {
                        self.feelLabel.text = String(Int(feelText - 272))
                    }
                }
                if let wind = json!["wind"] as? [String: Any] {
                    if let windText = wind["speed"] as? Double {
                        self.windLabel.text = String(Int(windText))
                    }
                }
            }
        }
        task.resume()
    }
}
