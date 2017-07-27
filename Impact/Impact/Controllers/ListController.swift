//
//  ListController.swift
//  Impact
//
//  Created by Connie Guan on 7/26/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit

class ListController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    
    

