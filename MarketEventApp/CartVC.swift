//
//  CartVC.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/12/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//

import UIKit
import CoreData


class CartVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var timer = NSTimer()
    var holdDuration: Int! = 300
    
    var timerIsRunning: Bool = true
    
    var seconds: Int = 0
    
    var itemNameField : UITextField!
    var boothIdField : UITextField!
    
    var products = [HoldProduct]()
    var newList = [HoldProduct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }
    
    
 
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        timerIsRunning = true
    
    }
    
    func updateTime(){
    
 
    //check if it has been 10 seconds
    seconds += 1
//    print(seconds)
        if seconds == 60 {
            // resets the timer and calls restartTimer()
            seconds = 0
            print("60 secs finished now restarting")
            restartTimer()
            fetchAndSetResults()
            tableView.reloadData()
        }
    
    }
    
    func restartTimer(){
    //reset and startTimer()
        print("restarted - calling startTimer()")
        timer.invalidate()
        timerIsRunning = false
        startTimer()
    
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
        startTimer()
        
        }
    
    override func viewDidDisappear(animated:Bool) {
        timer.invalidate()
        print("view disppeard")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("HoldProductCell") as? HoldProductCell {
            
            let holdProduct = products[indexPath.row]
            
            
            cell.configureCell(holdProduct)
            
            return cell
        } else {
            return HoldProductCell()
        }
        
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.Delete
        
    }
    
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let timerToDelete = self.products[indexPath.row]
            
            
                let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
                let entity = NSEntityDescription.entityForName("HoldProduct", inManagedObjectContext: context)!
                
                context.deleteObject(timerToDelete)
                
                do {
                    try context.save()
                } catch {
                    print("Could not delete holdproduct")
                }
            products.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

                
                fetchAndSetResults()
                tableView.reloadData()
                
           
            
            
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 83.0
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func configurationTextFields(itemNameField: UITextField){
        itemNameField.placeholder = "Enter item name"
        self.itemNameField = itemNameField
    }
    
    func configurationTextFields2(boothIdField: UITextField){
        
        boothIdField.placeholder = "Enter Booth #"
        self.boothIdField = boothIdField
    }
    
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        alertPopup()
    }
    
    
    
    
    func saveNewItem(){
        
        if let itemName = itemNameField.text where itemName != "" && boothIdField.text != "" {
            let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            let entity = NSEntityDescription.entityForName("HoldProduct", inManagedObjectContext: context)!
            
            let holdProduct = HoldProduct(entity: entity, insertIntoManagedObjectContext:context)
                
            holdProduct.name = itemNameField.text
            holdProduct.boothID = boothIdField.text
            
            
            //get 24 hour time format
            let currentDate = NSDate()
            let dateForm = NSDateFormatter()
            dateForm.dateFormat = "HHmm"
            let convertedDate = dateForm.stringFromDate(currentDate)
            //adding 3 hours (hold time limit)
            let timeNow: Int! = Int(convertedDate)
            let newTime: Int! = timeNow! + 300
            let newTimeStr: String! = String(newTime)
            
            holdProduct.time = newTimeStr
            holdProduct.timeLeft = newTimeStr
            holdProduct.timeAlert = newTimeStr
            
            context.insertObject(holdProduct)
            
            do {
                try context.save()
            } catch {
                print("Could not save holdproduct")
            }
            
            fetchAndSetResults()
            tableView.reloadData()
        } else {
            print("Please enter valid info")
        }
    }
    
    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "HoldProduct")

        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            
            self.products = results as! [HoldProduct]

            
//            parse through fetch result
            if results.count > 0{
                for result: AnyObject! in results as! [HoldProduct] {
                    
                    //get the hold due time from the coredata
                    let limitTime = result.valueForKey("time") as! String
                    
                    let currentTime = NSDate()
                    let dateForm = NSDateFormatter()
                    dateForm.dateFormat = "HHmm"
                    let convertedTime = dateForm.stringFromDate(currentTime)
                    
                    
                    let timeNow: Int! = Int(convertedTime)
                    let limitTimeInt: Int! = Int(limitTime)
                    
                    
//                    print(limitTimeInt)
//                    print(timeNow)
                    
                    let timeLeft = limitTimeInt - timeNow
                    let timeLeftStr: String! = String(timeLeft)
                    
//                    print(timeLeft)
                    
                    //get the name
                    let itemName = result.valueForKey("name") as! String
                    
                    //get the booth ID
                    let boothId = result.valueForKey("boothID") as! String
      
//                    print(timeLeftStr)
//                    print(limitTime)
                    
                    result.setValue(timeLeftStr, forKey: "timeLeft")
                    
                    let char = result.valueForKey("timeLeft") as! String
                    let characters = Array(char.characters)
                    let timeLeftTxt: String!
//                    print(characters.count)
//                    print(characters)
                    if characters.count == 3 {
                        timeLeftTxt = "\(characters[0]):\(characters[1])\(characters[2])"
                        print("4 digits: \(timeLeftTxt)")
                    } else if characters.count == 2 {
                        timeLeftTxt = "0:\(characters[0])\(characters[1])"
                        print("3 digits: \(timeLeftTxt)")
                    } else  {
                        timeLeftTxt = "0:0\(characters[0])"
                        print("2 digits: \(timeLeftTxt)")
                    }
                    
                    result.setValue(timeLeftTxt, forKey: "timeLeft")
                    result.setValue(timeLeftStr, forKey: "timeAlert")
                    
                    let timeLeftIs = result.valueForKey("timeAlert") as! String
                    print(timeLeftIs)
                    if timeLeftIs == "293" {
                        print("notify the user!")
//                        notifyUser()
                        notification()
                    }
//                    print(self.products)
                    
//                    print(boothId)
//                    products.append(newHoldProd)
                    
                    
                    
                }

                
            }
            
        } catch let err as NSError{
            print (err.description)
        }
        
    }
    
    func notification() {
        var Notification = UILocalNotification()
        
        Notification.alertAction = "Go to the app"
        Notification.alertBody  = "Check the timer"
        Notification.fireDate = NSDate(timeIntervalSinceNow: 0)
        
        UIApplication.sharedApplication().scheduleLocalNotification(Notification)
    }

    func notifyUser(){
        var notifyView = UIAlertController(title: "30 mins left!", message: "Items on hold needs to be checked out. Tick Tock!", preferredStyle: UIAlertControllerStyle.Alert)
        
        notifyView.addAction(UIAlertAction(title: "Go", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(notifyView, animated: true, completion: nil)
        
        
    }
    
    func alertPopup() {
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default){
            UIAlertAction in
            self.saveNewItem()
        }
        
        alert.addTextFieldWithConfigurationHandler(configurationTextFields)
        alert.addTextFieldWithConfigurationHandler(configurationTextFields2)
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
