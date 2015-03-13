//
//  ViewController.swift
//  SwiftModel2Dict
//
//  Created by King on 15/3/12.
//  Copyright (c) 2015年 king. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        println(loadJSON())
        
        let tool = SwiftDict2Model()
        let demo: AnyObject = tool.objectWithDictionary(loadJSON(), cls: Model.self)!
        println(demo)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJSON() ->NSDictionary {
        let path = NSBundle.mainBundle().pathForResource("Model01.json", ofType: nil)
        let data = NSData(contentsOfFile: path!, options: NSDataReadingOptions.allZeros, error: nil)
        return NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.allZeros, error: nil) as! NSDictionary
    }


}

