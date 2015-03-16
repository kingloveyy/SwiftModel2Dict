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
        
        let json = loadJSON()
        let obj = SwiftDict2Model.sharedManager.objectWithDictionary(json, cls: SubModel.self) as! SubModel
        
        println("object.info.name !!!! " + obj.info!.name!)
        
        println("OTHER")
        for value in obj.other! {
            println(value.name)
        }
        
        println("OTHERS")
        for value in obj.others! {
            let o = value as! Info
            println(o.name)
        }
        
        println("Demo \(obj.demo!)")
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

