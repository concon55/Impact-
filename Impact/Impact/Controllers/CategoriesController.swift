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
    
    var categories = [OrganizationClass]()
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiToContact = "file:///Users/connieguan/Desktop/Impact%20iOS/Impact/Impact/organizations.json"
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            print(response)
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    let allCategoriesData = json["data"].arrayValue
                    for i in 0..<allCategoriesData.count{
                        let category = OrganizationClass.init(json: allCategoriesData[i])
                        self.categories.append(category)
                    }
                    self.categories = self.categories.orderedSet
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

extension Array where Element: Equatable {
    var orderedSet: Array  {
        var array: [Element] = []
        return flatMap {
            if array.contains($0) {
                return nil
            } else {
                array.append($0)
                return $0
            }
        }
    }
}
