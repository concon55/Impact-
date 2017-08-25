//
//  FeaturedController.swift
//  Impact
//
//  Created by Connie Guan on 7/25/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class FeaturedController: UIViewController {
    
    var featuredOrganizations = [OrganizationClass]()
    var sections = [String]()
    var namesOfSection: [String] = []
    var dictionary = [String: [Any?]]()
    var section1 = [OrganizationClass]()
    var section2 = [OrganizationClass]()
    var section3 = [OrganizationClass]()
    var sectionData: [Int: [OrganizationClass]] = [:]
    
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
                        namesOfSection.append(eachOrg.section)
                        
                        if eachOrg.section == "Support Charlottesville" {
                            section1.append(eachOrg)
                        }else if eachOrg.section == "Support Syrian Refugees" {
                            section2.append(eachOrg)
                        }else{
                            section3.append(eachOrg)
                        }
                        sectionData = [0:section1, 1:section2, 2:section3]
                        
                    }
                    sections = uniqueElementsFrom(array: namesOfSection)
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
    
    func uniqueElementsFrom(array: [String]) -> [String] {
        //Create an empty Set to track unique items
        var set = Set<String>()
        let result = array.filter {
            guard !set.contains($0) else {
                //If the set already contains this object, return false
                //so we skip it
                return false
            }
            //Add this item to the set since it will now be in the array
            set.insert($0)
            //Return true so that filtered array will contain this item.
            return true
        }
        return result
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toInfo"{
                let indexPath = tableView.indexPathForSelectedRow!
                let eachOrg = sectionData[indexPath.section]![indexPath.row]
                let infoController = segue.destination as! InfoController
                infoController.org = eachOrg
                
            }
        }
    }
}
extension FeaturedController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionData[section]?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrgCell", for: indexPath) as! FeaturedTableViewCell
        //let featuredOrg = featuredOrganizations[indexPath.row]
        cell.orgNameLabel.text = sectionData[indexPath.section]![indexPath.row].charityName
        //let featuredImageUrl = featuredOrg.imageUrl
        cell.featuredImage?.image = nil
        cell.featuredImage.af_setImage(withURL: URL(string: sectionData[indexPath.section]![indexPath.row].imageUrl)!)
        let cellColors = [UIColor(red:0.28, green:0.16, blue:0.23, alpha:0.85), UIColor(red:0.29, green:0.35, blue:0.40, alpha:0.85), UIColor(red:0.10, green:0.20, blue:0.26, alpha:0.85), UIColor(red:0.44, green:0.42, blue:0.41, alpha:0.85)]
        let bgColor = cellColors[indexPath.row % cellColors.count]
        cell.orgNameLabel.backgroundColor = bgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 70))
        returnedView.backgroundColor = UIColor(red:1, green:1, blue:1, alpha:0.85)
        
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 70))
        label.text = sections[section]
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = UIColor(red:0.16, green:0.26, blue:0.35, alpha:1)
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}




