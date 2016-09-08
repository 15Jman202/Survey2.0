//
//  ResponseTableViewController.swift
//  Survey2.0
//
//  Created by Justin Carver on 9/8/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import UIKit

class ResponseTableViewController: UITableViewController {
    
    var responses: [Response] = [] {
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        ResponseController.getResponses { (responses) in
            self.responses = responses
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResponseCell", forIndexPath: indexPath)

        let response = responses[indexPath.row]
        cell.textLabel?.text = response.responseText
        cell.detailTextLabel?.text = response.name
        
        return cell
    }
}