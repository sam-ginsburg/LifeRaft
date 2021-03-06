//
//  MessagesViewController.swift
//  LifeRaft
//
//  Created by Sam Ginsburg on 11/7/15.
//  Copyright © 2015 sbg11. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var messageField: UITextField!
    
    @IBOutlet weak var tableMessages: UITableView!
    public var myMessages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        self.messageField.delegate = self
        print("STARTTTTTTTTT")
        self.tableMessages.delegate = self
        self.tableMessages.dataSource = self
        let rgbValue = 0x4863a0
        let r = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
        let g = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
        let b = CGFloat((rgbValue & 0xFF))/255.0
        tableMessages.backgroundColor = UIColor(red:r, green: g, blue: b, alpha: 1.0)
    }
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    
    
    func keyboardWillShow(sender: NSNotification) {
        let info:NSDictionary = sender.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        bottomCons!.constant = keyboardSize.height
    }
    func keyboardWillHide(sender: NSNotification) {
        bottomCons!.constant = 8
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        myMessages.append(textField.text!)
        self.tableMessages.reloadData()
        textField.text = ""
        self.view.endEditing(true)
        return false
    }
    //FUNCTION TO ADD FROM OTHER PLACES
    func newChat(chatMessage: String){
        myMessages.append(chatMessage)
        self.tableMessages.reloadData()
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return myMessages.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let rgbValue = 0x4863a0
        let r = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
        let g = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
        let b = CGFloat((rgbValue & 0xFF))/255.0
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
        let newMember = myMessages[indexPath.row]
        cell.backgroundColor = UIColor(red:r, green: g, blue: b, alpha: 1.0)
        cell.textLabel?.text="\(myFullName): \(newMember)"
        
        let id = myRootRef.childByAppendingPath("group1/chat/").childByAutoId()
        //let charRef = myRootRef.childByAppendingPath("group1/chat/")
        id.setValue("\(myFullName) \(newMember)")
        
        let note  = SendNotification()
        var notification = UILocalNotification()
        note.notify(notification, reason: "hi", note: "\(myFullName) \(newMember)")
        
        cell.textLabel?.textColor=UIColor.whiteColor()
        return cell
    }
    // UITableViewDelegate Functions
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return myMessages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let rgbValue = 0x4863a0
        let r = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
        let g = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
        let b = CGFloat((rgbValue & 0xFF))/255.0
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
        let newMember = myMessages[indexPath.row]
        cell.backgroundColor = UIColor(red:r, green: g, blue: b, alpha: 1.0)
        cell.textLabel?.text="Name: \(newMember)"
        cell.textLabel?.textColor=UIColor.whiteColor()
        return cell
    }
    
    
}

extension MessagesViewController : MessageTableCell {
    
    func connectedDevicesChanged(manager: BluetoothManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.myMessages = connectedDevices
            self.memberTable.reloadData()
        }
    }*/
    /*func keyboardWillShow(notification: NSNotification) {
        let info:NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        
        let keyboardHeight: CGFloat = keyboardSize.height
        
        let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
        
        
        UIView.animateWithDuration(0.1, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.view.frame = CGRectMake(0, (self.view.frame.origin.y - keyboardHeight), self.view.bounds.width, self.view.bounds.height)
            }, completion: nil)
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let info: NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        
        let keyboardHeight: CGFloat = keyboardSize.height
        
        let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
        
        UIView.animateWithDuration(0.1, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.view.frame = CGRectMake(0, (self.view.frame.origin.y + keyboardHeight), self.view.bounds.width, self.view.bounds.height)
            }, completion: nil)
        
    }*/
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
