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
    
    override func viewWillAppear(_ animated: Bool) {
        self.categoriesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "organizations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    //print("jsonData:\(jsonObj)")
                    let allCategoriesData = jsonObj["data"].arrayValue
                    for i in 0..<allCategoriesData.count{
                        let category = OrganizationClass.init(json: allCategoriesData[i])
                        categories.append(category)
                    }
                    categories = categories.orderedSet
                    categories.sort(by: {$0.categoryName < $1.categoryName})
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toList"{
                print("Cell tapped")
                let indexPath = categoriesTableView.indexPathForSelectedRow!
                let eachOrg = categories[indexPath.row]
                let listController = segue.destination as! ListController
                listController.org = eachOrg
                
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
//        if indexPath.row == 0{
//            cell.categoryLabel.text = "All"
//        } else {
            let category = categories[indexPath.row]
        
            cell.categoryLabel.text = category.categoryName
//        }
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
