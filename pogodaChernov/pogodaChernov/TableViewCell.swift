//
//  citiesTVCTableViewController.swift
//  pogodaChernov
//
//  Created by user on 01.03.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class citiesTVC: UITableViewController {
    
    var cityName = ""
    
    struct Cities {
        var cityName = ""
        var cityTemp: Double = 0.0
    }
    
    var cityTempArray: [Cities] = []
    
    func currentWeather(city: String)  {
        let url = "http://api.weatherapi.com/v1/current.json?key=b9af563796d9442d9fe85035210403&q=\(city)&aqi=yes"
        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                let name = "Moscow"
                let temp = 0.0
                self.cityTempArray.append(Cities(cityName: name, cityTemp: temp))
                print(cityTempArray)
            case .failure(let error):
                print(error)
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addCityAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Добавить", message: "Введите название", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Moscow"
        }
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        let newCityAction = UIAlertAction(title: "Добавить", style: .default) { action in
            let name = alert.textFields![0].text
            self.currentWeather(city: name!)
        }
        alert.addAction(cancelAction)
        alert.addAction(newCityAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityTempArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.cityName.text = cityTempArray[indexPath.row].cityName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cityName = cityTempArray[indexPath.row].cityName
        performSegue(withIdentifier: "detailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let vc = segue.destination as? detailVCViewController{
            vc.cityName = cityName
        }
    }
}
