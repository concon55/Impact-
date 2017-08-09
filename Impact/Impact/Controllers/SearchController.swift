//
//  SearchController.swift
//  Impact
//
//  Created by Connie Guan on 8/1/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class SearchController: UITableViewController, UISearchResultsUpdating{
    
    var org: OrganizationClass?
    var unfilteredOrgs = [OrganizationClass]()
    var filteredOrgs = [OrganizationClass]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredOrgs = unfilteredOrgs
        if let path = Bundle.main.path(forResource: "organizations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    //print("jsonData:\(jsonObj)")
                    let allData = jsonObj["data"].arrayValue
                    for i in 0..<allData.count{
                        let organization = OrganizationClass.init(json: allData[i])
                        unfilteredOrgs.append(organization)
                    }
                    unfilteredOrgs.sort(by: {$0.charityName < $1.charityName})
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredOrgs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 	{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "searchCell")
        
        cell.textLabel?.text = self.filteredOrgs[indexPath.row].charityName
        cell.detailTextLabel?.text = self.filteredOrgs[indexPath.row].categoryName
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredOrgs = unfilteredOrgs
        } else {
            // Filter the results
            filteredOrgs = unfilteredOrgs.filter { $0.charityName.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "searchToInfo"{
                let indexPath = tableView.indexPathForSelectedRow!
                let eachOrg = filteredOrgs[indexPath.row]
                let infoController = segue.destination as! InfoController
                infoController.org = eachOrg
                
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "searchToInfo", sender: self)
    }
    

}
