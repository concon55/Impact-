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
    
    var categories = [Category]()
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let apiToContact = "http://data.orghunter.com/v1/categories?"
        let parameters = ["user_key": "ea889e700c495c853a1f42c45f7da3f0" ] as [String: Any]
        
        let request = Alamofire.request(apiToContact, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: nil)
        request.validate().responseJSON { (response) in
            print(response)
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    let allCategoriesData = json["data"].arrayValue
                    for i in 0..<allCategoriesData.count{
                        let category = Category.init(json: allCategoriesData[i])
                        if category.categoryName == "Not Provided"  || category.categoryName == "Unknown"{
                            print("skipped category")
                        }else{
                            self.categories.append(category)
                        }
                        
                    }
                    self.categories.sort(by: {$0.categoryName < $1.categoryName})
                    self.categoriesTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

extension CategoriesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoriesTableViewCell
        if indexPath.row == 0{
            cell.categoryLabel.text = "All"
        } else {
            let category = categories[indexPath.row]
            cell.categoryLabel.text = category.categoryName
        }
        return cell
    }
}
