//
//  MasterViewController.swift
//  Stretch My Header
//
//  Created by Anthony Coelho on 2016-06-07.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

import UIKit


class MasterViewController: UITableViewController {
    
    var kTableHeaderHeight = 0
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    
    

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    
    struct NewsItem {
        var category = ""
        var headline = ""
        let categoryColors = ["World": UIColor.redColor(),
                          "Americas": UIColor.blueColor(),
                          "Europe": UIColor.greenColor(),
                          "Middle East": UIColor.yellowColor(),
                          "Africa": UIColor.orangeColor(),
                          "Asia Pacific": UIColor.purpleColor()]
        
        
        init(withCategory category: String, andHeadline headline: String) {
            self.category = category
            self.headline = headline
            
        }
                       
    }
    
    let array = [NewsItem(withCategory:"World", andHeadline:"Climate change protests, divestments meet fossil fuels realities"),
                 NewsItem(withCategory: "Europe", andHeadline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"),
                 NewsItem(withCategory: "Middle East", andHeadline: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
                 NewsItem(withCategory: "Africa", andHeadline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
                 NewsItem(withCategory: "Asia Pacific", andHeadline: "Despite UN ruling, Japan seeks backing for whale hunting"),
                 NewsItem(withCategory: "Americas", andHeadline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
                 NewsItem(withCategory: "World", andHeadline:"South Africa in $40 billion deal for Russian nuclear reactors"),
                 NewsItem(withCategory: "Europe", andHeadline: "'One million babies' created by EU student exchanges")]
    
                 


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(MasterViewController.insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
 
        self.dateLabel.text =  dateFormatter.stringFromDate(NSDate())
        
        kTableHeaderHeight = Int(self.headerView.frame.size.height)
        tableView.tableHeaderView = nil
        self.view.addSubview(self.headerView)
        tableView.contentInset = UIEdgeInsetsMake(CGFloat(kTableHeaderHeight), 0, 0, 0)
        tableView.contentOffset.y = CGFloat(-kTableHeaderHeight)
        updateHeaderView()
        
  
    }
    
    func updateHeaderView() {
        var headerRect = CGRectMake(0, CGFloat(-kTableHeaderHeight), tableView.bounds.width, CGFloat(kTableHeaderHeight))
        if Int(tableView.contentOffset.y) < -kTableHeaderHeight {
            
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
     
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = segue.destinationViewController as! DetailViewController
                controller.detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CustomTVC {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTVC

        let newsItem = array[indexPath.row]
        
        
        cell.categoryLabel.text = newsItem.category
        cell.categoryLabel.textColor = newsItem.categoryColors[newsItem.category]
        cell.headlineLabel.text = newsItem.headline
        
        
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


}

