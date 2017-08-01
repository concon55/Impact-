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
        let cellColors = [UIColor(red:0.28, green:0.16, blue:0.23, alpha:0.7), UIColor(red:0.29, green:0.35, blue:0.40, alpha:0.7), UIColor(red:0.10, green:0.20, blue:0.26, alpha:0.7), UIColor(red:0.44, green:0.42, blue:0.41, alpha:0.7)]
        let bgColor = cellColors[indexPath.row % cellColors.count]
        cell.orgNameLabel.backgroundColor = bgColor
        return cell
    }
}


