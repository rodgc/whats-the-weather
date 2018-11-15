//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Rodrigo Gonzalez on 11/15/18.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func getWeather(_ sender: Any) {
       if let url = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")  {
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, respponse, error in
                var message = ""
                if let error = error {
                    print(error)
                } else {
                    if let unwrapperData = data {
                        let dataString = NSString(data: unwrapperData, encoding: String.Encoding.utf8.rawValue)
                        var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                            if contentArray.count > 1 {
                                stringSeparator = "</span>"
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                if newContentArray.count > 1 {
                                   message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    print(newContentArray[0])
                                }
                            }
                        }
                    }
                }
                if message == "" {
                    message = "The weather there could't be found, Please try again"
                }
                DispatchQueue.main.sync(execute: {
                    self.resultLabel.text = message
                })
            }
            
            task.resume()
        } else {
            resultLabel.text = "The weather there couldn't be found. Please try again."
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }


}

