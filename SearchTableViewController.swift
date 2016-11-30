//
//  SearchTableViewController.swift
//  SearchBarTest
//
//  Created by Fabiano Heizer on 02/10/16.
//  Copyright © 2016 Fabiano Heizer. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    let searchBar = UISearchBar()
    let tableData = ["Teste","Code5", "Code3", "Code2", "Code1", "Code6", "Code7"]
    
    var filteredArray = [String]();
    var shouldShowSearchResults = false;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        createSeacrhBar();
    }
    
    
    // Create the search bar in the navigationItem
    func createSeacrhBar(){
        searchBar.showsCancelButton = false;
        searchBar.placeholder = "Enter the code here";
        
        searchBar.delegate = self;
        self.navigationItem.titleView = searchBar;
    }
    
    
    // Number of section in the tableView
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Tells the data source to return the number of rows in a given section of a table view.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count;
        } else {
            return tableData.count;
        }
    }
    
    
    // Function to add the datas at the tableView
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath)
        
        if shouldShowSearchResults {
            cell.textLabel!.text = filteredArray[indexPath.row]
            return cell
        } else {
            cell.textLabel!.text = tableData[indexPath.row]
            return cell
        }
    }
    
    
    // Function for adding search
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        filteredArray = tableData.filter({ (names: String) -> Bool in
            return names.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
        })
        
        if searchText != "" {
            shouldShowSearchResults = true
            self.tableView.reloadData()
        } else {
            shouldShowSearchResults = false
            self.tableView.reloadData()
        }
    }
    
    
    // Hide the keyborad when you dragging the list
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }


}
