//
//  BaseInteractor.swift
//  MovieAppCore
//
//  Created by Rifat Firdaus on 11/18/16.
//  Copyright © 2016 Suitmedia. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

open class BaseInteractor {
    
    public var service = MovieAppCoreService.instance
    
    public var perPage: Int
    public var params: [String: String]
    public let storeKey: String?
    public var lastPage = 0
    public var nextPage = 1
    
    private var _realm: Realm?
    
    public var realm: Realm {
        if let realm = _realm {
            return realm
        }
        return try! Realm()
    }
    
    public init(perPage: Int = 10, params: [String: String] = [String: String](), storeKey: String? = nil) {
        self.perPage = perPage
        self.params = params
        self.storeKey = storeKey
    }
    
    public func saveModel(data: Object) {
        try! self.realm.write {
            self.realm.add(data, update: true)
        }
        if let key = storeKey {
            var separatedData = [AnyObject]()
            if let value = data.value(forKey: "identifier") {
                separatedData.append(value as AnyObject)
            }
            let json = JSON(separatedData)
            let string = json.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions(rawValue: 0))
            try! realm.write {
                let keyedValue = KeyedValue()
                keyedValue.key = key
                keyedValue.value = string
                self.realm.create(KeyedValue.self, value: keyedValue, update: true)
            }
        }
    }
    
    public func saveListOfModels(data: [Object]) {
        try! self.realm.write {
            self.realm.add(data, update: true)
        }
        if let key = storeKey {
            var separatedData = [AnyObject]()
            for item in data {
                if let value = item.value(forKey: "identifier") {
                    separatedData.append(value as AnyObject)
                }
            }
            let json = JSON(separatedData)
            let string = json.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions(rawValue: 0))
            try! realm.write {
                let keyedValue = KeyedValue()
                keyedValue.key = key
                keyedValue.value = string
                self.realm.create(KeyedValue.self, value: keyedValue, update: true)
            }
        }
    }
    
    public func removeAllModelsOf<T : RealmSwift.Object>(type: T.Type, filter: String? = nil) {
        if let filter = filter {
            let result = self.realm.objects(type).filter(filter)
            try! self.realm.write {
                self.realm.delete(result)
                print("\(type.description()) deleted, filter : \(filter)")
            }
        } else {
            let result = self.realm.objects(type)
            try! self.realm.write {
                self.realm.delete(result)
                print("\(type.description()) deleted")
            }
        }
    }

}
