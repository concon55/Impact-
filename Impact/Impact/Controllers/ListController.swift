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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiToContact = "http://data.orghunter.com/v1/charitysearch?"
        let parameters = ["user_key": "ea889e700c495c853a1f42c45f7da3f0"] as [String: Any]
        
        let request = Alamofire.request(apiToContact, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: nil)
        request.validate().responseJSON { (response) in
            print(response)
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    let allOrganizations = json["data"].arrayValue
                    print(allOrganizations)
                    
                    // if this works correctly after youve created organizations object
                    
                    //print(json)
                }
            case .failure(let error):
                print(error)
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        cell.listNameLabel.text = "Organization Name"
        cell.listCategoryLabel.text = "Category"
        //cell.orgImageView.image = tbd
        return cell
    }
}

    
    

