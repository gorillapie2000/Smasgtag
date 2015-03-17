//
//  TweetTableTableViewController.swift
//  Smashtag
//
//  Created by pgore on 3/15/15.
//  Copyright (c) 2015 Pradnyesh Gore. All rights reserved.
//

import UIKit

class TweetTableTableViewController: UITableViewController, UITextFieldDelegate
{
    // MARK: - Member variables and outlets
    var searchText:String? = "pinkfloyd"{
        didSet{
            if searchText != nil {
                searchTextField?.text = searchText;
                self.tweets.removeAll();
                self.tableView.reloadData();
                refresh();
            }
        }
    }

    var tweets = [[Tweet]]();
    
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet{
            searchTextField.delegate = self;
            searchTextField.text = searchText;
        }
    }
    
    // MARK: - UITableViewController lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh();
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder();
            self.searchText = textField.text;
        }
        return true;
    }

    // MARK: - Table view data source
    
    func refresh(){
        var request:TwitterRequest = TwitterRequest(search: searchText!, count: 100);
        // NOTE the different types of closure notations used below
        request.fetchTweets { (newTweets) -> Void in
            // Because self.tableView.reloadData() needs to be executed on the main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if newTweets.count > 0 {
                    self.tweets.insert(newTweets, atIndex: 0);
                    self.tableView.reloadData();    //table view is present in the super class
                }
            })
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.tweets[section].count
    }

    private struct Storyboard {
        static let CellReuseIdentifier = "Tweet";
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as TweetTableViewCell
        cell.tweet = self.tweets[indexPath.section][indexPath.row];
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
