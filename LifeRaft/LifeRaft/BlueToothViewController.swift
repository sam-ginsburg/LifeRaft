//
//  BlueToothViewController.swift
//  LifeRaft
//
//  Created by Grant Costa on 11/7/15.
//  Copyright © 2015 sbg11. All rights reserved.
//


import UIKit
import Firebase
import SwiftyJSON

class BlueToothViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var connectionsLabel: UILabel!
    
    @IBOutlet weak var memberTable: UITableView!
    
    var connections = [String]()
    
    let blueTooth = BluetoothManager()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        connections = [String]()
        
        var bluetoothRef = myRootRef.childByAppendingPath("/bluetooth/")
        
        let groupId = myRootRef.childByAppendingPath("/").childByAutoId()
        for s in connections {
            let id = bluetoothRef.childByAutoId()
            id.setValue(s)
            groupId.setValue([id: s])
        }
        
        
        let rgbValue = 0x4863a0
        let r = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
        let g = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
        let b = CGFloat((rgbValue & 0xFF))/255.0
        memberTable.backgroundColor = UIColor(red:r, green: g, blue: b, alpha: 1.0)
        
        //print(connections.count)
        self.blueTooth.delegate = self
        //print(connections.count)
        self.memberTable.delegate = self
        self.memberTable.dataSource = self
    }
    @IBAction func cancelClicked(sender: UIButton) {
        connections.removeAll()
        self.dismissViewControllerAnimated(true, completion: {});
        
        blueTooth.serviceAdvertiser.stopAdvertisingPeer()
        blueTooth.serviceBrowser.stopBrowsingForPeers()
        
    }
    @IBAction func doneClicked(sender: UIButton) {
        if connections.count > 0 {
            //store connections in database
            connections.removeAll()
            self.dismissViewControllerAnimated(true, completion: {});
            
            blueTooth.serviceAdvertiser.stopAdvertisingPeer()
            blueTooth.serviceBrowser.stopBrowsingForPeers()
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return connections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
            let rgbValue = 0x4863a0
            let r = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
            let g = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
            let b = CGFloat((rgbValue & 0xFF))/255.0
            let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
            let newMember = connections[indexPath.row]
            cell.backgroundColor = UIColor(red:r, green: g, blue: b, alpha: 1.0)
            cell.textLabel?.text="Name: \(newMember)"
            cell.textLabel?.textColor=UIColor.whiteColor()
            return cell
    }

 
}



extension BlueToothViewController : BluetoothManagerDelegate {
    
    func connectedDevicesChanged(manager: BluetoothManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connections = connectedDevices
            self.memberTable.reloadData()
        }
    }
}