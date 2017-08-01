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

class ListController: UITableViewController{
    
    var organizations = [OrganizationClass]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiToContact = "http://data.orghunter.com/v1/charitysearch?"
        let parameters = ["user_key": "ea889e700c495c853a1f42c45f7da3f0"] as [String: Any]
        
        let request = Alamofire.request(apiToContact, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: nil)
        request.validate().responseJSON { (response) in
            //print(response)
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    let allOrganizations = json["data"].arrayValue
                    for i in 0..<allOrganizations.count{
                        let eachOrg = OrganizationClass.init(json: allOrganizations[i])
                        self.organizations.append(eachOrg)
                    }
                    
                    
                }
            case .failure(let error):
                print(error)
            }
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
        //cell.orgImageView.image = tbd
        return cell
    }
}

    
    

