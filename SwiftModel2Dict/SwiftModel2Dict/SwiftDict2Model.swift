//
//  SwiftDict2Model.swift
//  SwiftModel2Dict
//
//  Created by King on 15/3/13.
//  Copyright (c) 2015年 king. All rights reserved.
//

import Foundation


@objc protocol DictModelProtocol {

    ///  自定义类映射表
    ///
    ///  :returns: 返回可选映射关系字典
    static func customeClassMapping() -> [String: String]?
}


class SwiftDict2Model {
    
    var modelCache = [String: [String: String]]()
    
    ///  加载完整类信息
    ///
    ///  :param: cls 模型类
    ///
    ///  :returns: 返回模型完整信息
    func fullModelInfo(cls: AnyClass) -> [String: String] {
    
        // 检测缓冲池
        if let cache = modelCache["\(cls)"] {
            return cache
        }
        
        var currentCls: AnyClass = cls
        
        var infoDict = [String: String]()
        while let parent: AnyClass = currentCls.superclass() {
            infoDict.merge(modelInfo(currentCls))
            currentCls = parent
        }
        
        
        
        return infoDict
    }
    
    ///  加载类信息
    ///
    ///  :param: cls 模型类
    ///
    ///  :returns: 模型类信息
    func modelInfo(cls: AnyClass) -> [String: String] {
        
        var count: UInt32 = 0
        let properties = class_copyPropertyList(cls, &count)
        
        // 检查类是否实现协议
        var mappingDict: [String: String]?
        if cls.respondsToSelector("customeClassMapping") {
            mappingDict = cls.customeClassMapping()
        }
        
        var infoDict = [String: String]()
        for i in 0..<count {
            let property = properties[Int(i)]
            
            // 获取属性名称
            let name = String.fromCString(property_getName(property))
            let type = mappingDict?[name!] ?? ""
            
            infoDict[name!] = type
        }
        
        free(properties)
        
        return infoDict
    }
}

extension Dictionary {
    mutating func merge<K, V>(dict: [K: V]) {
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
}
