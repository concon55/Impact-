//
//  FeaturedController.swift
//  Impact
//
//  Created by Connie Guan on 7/25/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FeaturedController: UIViewController {
    
    var featuredOrganizations = [SearchSummary]()
    
    @IBOutlet weak var tableView: UITableView!
    
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
                    for i in 0..<allOrganizations.count{
                        let eachOrg = SearchSummary.init(json: allOrganizations[i])
                        if eachOrg.category == "Not Provided"{
                            self.featuredOrganizations.append(eachOrg)
                        }
                    }
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension FeaturedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuredOrganizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrgCell", for: indexPath) as! FeaturedTableViewCell
        let featuredOrg = featuredOrganizations[indexPath.row]
        cell.orgNameLabel.text = featuredOrg.charityName
        //cell.orgImageView.image = tbd
        return cell
    }
}
