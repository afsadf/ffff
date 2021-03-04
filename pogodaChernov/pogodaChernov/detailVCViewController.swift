//
//  detailVCViewController.swift
//  pogodaChernov
//
//  Created by user on 04.03.2021.
//
import Alamofire
import SwiftyJSON
import UIKit

class detailVCViewController: UIViewController {
    var cityName = ""
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temp_c: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeather(city: cityName)
        }
    
    func currentWeather(city: String)  {
        let url = "http://api.weatherapi.com/v1/current.json?key=b9af563796d9442d9fe85035210403&q=\(city)&aqi=yes"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let name = json["location"]["name"].stringValue
                print(name)
                let temp = json["current"]["temp_c"].doubleValue
                let country = json["location"]["country"].stringValue
                let weatherURLString = "http:\(json["location"][0]["icon"].stringValue)"
                self.cityNameLabel.text = name
                self.temp_c.text = String(temp)
                self.countryLabel.text = country
                let weatherURL = URL(string: weatherURLString)
                if let data = try? Data(contentsOf: weatherURL!){
                    self.imageWeather.image = UIImage(data: data)
                    
                }
                
                print(value)
            case .failure(let error):
                print(error)
                
                
            }
        }
        
    }

    

}
