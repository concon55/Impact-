//
//  ListController.swift
//  Impact
//
//  Created by Connie Guan on 7/26/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ListController: UITableViewController{
    
    //var categories = [OrganizationClass]()
    var organizations = [OrganizationClass]()
    
    @IBOutlet var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "organizations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    //print("jsonData:\(jsonObj)")
                    let allOrganizationsData = jsonObj["data"].arrayValue
                    for i in 0..<allOrganizationsData.count{
                        let listOrg = OrganizationClass.init(json: allOrganizationsData[i])
                        organizations.append(listOrg)
                    }
                    organizations.sort(by: {$0.categoryName < $1.categoryName})
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        let eachOrg = organizations[indexPath.row]
        cell.listNameLabel.text = eachOrg.charityName
        cell.listCategoryLabel.text = eachOrg.categoryName
        let listImageUrl = eachOrg.iconImage
        cell.listImageView.af_setImage(withURL: URL(string: listImageUrl)!)
        
        return cell
    }
}


    
    

