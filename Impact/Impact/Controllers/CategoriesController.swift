//
//  CategoriesController.swift
//  Impact
//
//  Created by Connie Guan on 7/25/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CategoriesController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiURL = "http://data.orghunter.com/v1/categories"
        let parameters: Parameters = ["user_key": "ea889e700c495c853a1f42c45f7da3f0"]
        
        Alamofire.request(apiURL, parameters: parameters).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    print(json)
                    
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CategoriesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoriesTableViewCell
        cell.categoryLabel.text = "Category"
        return cell
    }
}
