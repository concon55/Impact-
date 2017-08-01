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
import AlamofireImage

class FeaturedController: UIViewController {
    
    var featuredOrganizations = [OrganizationClass]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let apiToContact = "file:///Users/connieguan/Desktop/Impact%20iOS/Impact/Impact/featured.json"
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            //print(response)
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    let allOrganizations = json["data"].arrayValue
                    for i in 0..<allOrganizations.count{
                        let eachOrg = OrganizationClass.init(json: allOrganizations[i])
                        self.featuredOrganizations.append(eachOrg)
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
        let featuredImageUrl = featuredOrg.imageUrl
        cell.featuredImage.af_setImage(withURL: URL(string: featuredImageUrl)!)
        return cell
    }
}

