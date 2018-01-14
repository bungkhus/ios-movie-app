//
//  PreferenceManager.swift
//  TestTabbed
//
//  Created by Chandra Welim on 7/13/17.
//  Copyright © 2017 Suitmedia. All rights reserved.
//

import UIKit

class PreferenceManager: NSObject {

    private static let MovieId = "MovieId"
    
    static let instance = PreferenceManager()
    
    private let userDefaults: UserDefaults
    
    override init() {
        userDefaults = UserDefaults.standard
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
//    var token: String? {
//        get {
//            return userDefaults.string(forKey: PreferenceManager.Token)
//        }
//        set(newToken) {
//            if let token = newToken {
//                userDefaults.set(token, forKey: PreferenceManager.Token)
//            } else {
//                userDefaults.removeObject(forKey: PreferenceManager.Token)
//            }
//        }
//    }
    
    var movieId: Int64? {
        get {
            if let number = userDefaults.object(forKey: PreferenceManager.MovieId) as? NSNumber {
                return number.int64Value
            }
            return 0
        }
        set(newUserId) {
            if let userId = newUserId {
                userDefaults.set(NSNumber(value: userId), forKey: PreferenceManager.MovieId)
            } else {
                userDefaults.removeObject(forKey: PreferenceManager.MovieId)
            }
        }
    }
    
}
