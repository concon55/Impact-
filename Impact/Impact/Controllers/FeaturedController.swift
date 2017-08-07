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
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "featured", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    //print("jsonData:\(jsonObj)")
                    let allOrganizations = jsonObj["data"].arrayValue
                    for i in 0..<allOrganizations.count{
                        let eachOrg = OrganizationClass.init(json: allOrganizations[i])
                        featuredOrganizations.append(eachOrg)
                    }
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
            if identifier == "toInfo"{
                let indexPath = tableView.indexPathForSelectedRow!
                let eachOrg = featuredOrganizations[indexPath.row]
                let infoController = segue.destination as! InfoController
                infoController.org = eachOrg
                
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
        let cellColors = [UIColor(red:0.28, green:0.16, blue:0.23, alpha:0.75), UIColor(red:0.29, green:0.35, blue:0.40, alpha:0.75), UIColor(red:0.10, green:0.20, blue:0.26, alpha:0.75), UIColor(red:0.44, green:0.42, blue:0.41, alpha:0.75)]
        let bgColor = cellColors[indexPath.row % cellColors.count]
        cell.orgNameLabel.backgroundColor = bgColor
        return cell
    }
}


