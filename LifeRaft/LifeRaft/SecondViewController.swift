//
//  SecondViewController.swift
//  LifeRaft
//
//  Created by Sam Ginsburg on 11/6/15.
//  Copyright © 2015 sbg11. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let localNotification:UILocalNotification = UILocalNotification()
        let sender = SendNotification()
        sender.notify(localNotification,reason: "Test",note: "IT WORKS")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

