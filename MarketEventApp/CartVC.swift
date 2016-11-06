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
    
    var timer = Timer()
    var holdDuration: Int! = 300
    
    var timerIsRunning: Bool = true
    
    var seconds: Int = 0
    
    var itemNameField : UITextField!
    var boothIdField : UITextField!
    
    var products = [HoldProduct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
        fetchAndSetResults()
        if products.count > 0 && !(timer.isValid) {
            startTimer()
        } else {
            timer.invalidate()
        }
        
    }
    
    
    
 
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CartVC.updateTime), userInfo: nil, repeats: true)
        timerIsRunning = true
    
    }
    
    func updateTime(){
        
    
    //check if it has been 10 seconds
    seconds += 1
    print(seconds)
        if seconds == 60 {
            // resets the timer and calls restartTimer()
            seconds = 0
            print("60 secs finished now restarting")
//            restartTimer()
            timer.invalidate()
            fetchAndSetResults()
            tableView.reloadData()
        }
    
    }
    
//    func restartTimer(){
//    //reset and startTimer()
//        print("restarted - calling startTimer()")
//        timer.invalidate()
//        timerIsRunning = false
//        startTimer()
//    
//    }
    
    override func viewDidAppear(_ animated: Bool) {
//        timer.invalidate()
//        startTimer()
        fetchAndSetResults()
        tableView.reloadData()
        
        }
    
    override func viewDidDisappear(_ animated:Bool) {
//        timer.invalidate()
        print("view disppeard")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HoldProductCell") as? HoldProductCell {
            
            let holdProduct = products[indexPath.row]
            
            
            cell.configureCell(holdProduct)
            
            return cell
        } else {
            return HoldProductCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.delete
        
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let timerToDelete = self.products[indexPath.row]
            
            
                let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                let entity = NSEntityDescription.entity(forEntityName: "HoldProduct", in: context)!
                
                context.delete(timerToDelete)
                
                do {
                    try context.save()
                } catch {
                    print("Could not delete holdproduct")
                }
            products.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
                
                fetchAndSetResults()
                if products.count == 0{
                    timer.invalidate()
                }
                tableView.reloadData()
                
           
            
            
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func configurationTextFields(_ itemNameField: UITextField){
        itemNameField.placeholder = "Enter item name"
        self.itemNameField = itemNameField
    }
    
    func configurationTextFields2(_ boothIdField: UITextField){
        
        boothIdField.placeholder = "Enter Booth #"
        boothIdField.keyboardType = UIKeyboardType.numberPad
        self.boothIdField = boothIdField
    }
    
    
    @IBAction func addButtonPressed(_ sender: AnyObject) {
        alertPopup()
    }
    
    
    
    
    func saveNewItem(){
        
        if let itemName = itemNameField.text, itemName != "" && boothIdField.text != "" {
            
            let boothIdName = boothIdField.text
//            if let boothIdNameInt = boothIdName as Int {
            let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            let entity = NSEntityDescription.entity(forEntityName: "HoldProduct", in: context)!
            
            let holdProduct = HoldProduct(entity: entity, insertInto:context)
                
            holdProduct.name = itemNameField.text
            holdProduct.boothID = boothIdName
            
            
            //get 24 hour time format
            let currentDate = Date()
            let dateForm = DateFormatter()
            dateForm.dateFormat = "HHmm"
            let convertedDate = dateForm.string(from: currentDate)
            //adding 3 hours (hold time limit)
            let timeNow: Int! = Int(convertedDate)
            let newTime: Int! = timeNow! + 300
            let newTimeStr: String! = String(newTime)
            
            holdProduct.time = newTimeStr
            holdProduct.timeLeft = newTimeStr
            holdProduct.timeAlert = newTimeStr
            
            context.insert(holdProduct)
            
            
            do {
                try context.save()
            } catch {
                print("Could not save holdproduct")
            }
            
            //starttimer
            if timer.isValid {
                print("running")
                
            } else {
                startTimer()
            }
            
            
            fetchAndSetResults()
            tableView.reloadData()
//            }else {
//                print("type int please")
//                typeBoothNumberError()
//            }
        } else {
            print("Please enter valid info")
            typeBoothNumberError()
        }
    }
    
    func fetchAndSetResults() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HoldProduct")

        
        do {
            let results = try context.fetch(fetchRequest)
            
            self.products = results as! [HoldProduct]

            
//            parse through fetch result
            if results.count > 0{
                for result: AnyObject! in results as! [HoldProduct] {
                    
                    //get the hold due time from the coredata
                    let limitTime = result.value(forKey: "time") as! String
                    
                    let currentTime = Date()
                    let dateForm = DateFormatter()
                    dateForm.dateFormat = "HHmm"
                    let convertedTime = dateForm.string(from: currentTime)
                    
                    
                    let timeNow: Int! = Int(convertedTime)
                    let limitTimeInt: Int! = Int(limitTime)
                    
                    
//                    print(limitTimeInt)
//                    print(timeNow)
                    
                    let timeLeft = limitTimeInt - timeNow
                    let timeLeftStr: String! = String(timeLeft)
                    
//                    print(timeLeft)
                    
                    //get the name
                    let itemName = result.value(forKey: "name") as! String
                    
                    //get the booth ID
                    let boothId = result.value(forKey: "boothID") as! String
      
//                    print(timeLeftStr)
//                    print(limitTime)
                    
                    result.setValue(timeLeftStr, forKey: "timeLeft")
                    
                    let char = result.value(forKey: "timeLeft") as! String
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
                    
                    let timeLeftIs = result.value(forKey: "timeAlert") as! String
                    print(timeLeftIs)
                    if timeLeftIs == "299" {
                        print("notify the user!")
//                        notifyUser()
                        notification()
                    } else if timeLeftIs <= "0" {
                        notification()
                    } else {
                        print("overtime")
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
        let Notification = UILocalNotification()
        
        Notification.alertAction = "Go to the app"
        Notification.alertBody  = "Check the timer"
        Notification.fireDate = Date(timeIntervalSinceNow: 0)
        
        UIApplication.shared.scheduleLocalNotification(Notification)
    }

    func notifyUser(){
        let notifyView = UIAlertController(title: "30 mins left!", message: "Items on hold needs to be checked out. Tick Tock!", preferredStyle: UIAlertControllerStyle.alert)
        
        notifyView.addAction(UIAlertAction(title: "Go", style: UIAlertActionStyle.default, handler: nil))
        self.present(notifyView, animated: true, completion: nil)
        
        
    }
    
    func typeBoothNumberError(){
        let alert = UIAlertController(title: "Please type booth number", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertPopup() {
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            alert.dismiss(animated: true, completion: nil)
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default){
            UIAlertAction in
            self.saveNewItem()
        }
        
        alert.addTextField(configurationHandler: configurationTextFields)
        alert.addTextField(configurationHandler: configurationTextFields2)
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
