//
//  MovieVideoInteractor.swift
//  MovieApp
//
//  Created by bungkhus on 15/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class MovieVideoInteractor: BaseInteractor {
    
    fileprivate var currentPage = 1
    
    open var hasNext: Bool {
        return currentPage != -1
    }
    
    var videos: [Video] = [Video]()
    
    func loadKey() {
        videos.removeAll()
        if let key = storeKey,
            let keyedValue = realm.object(ofType: KeyedValue.self, forPrimaryKey: key as AnyObject),
            let value = keyedValue.value
        {
            let json = JSON.parse(value)
            for child in json.arrayValue {
                if let item = realm.object(ofType: Video.self, forPrimaryKey: child.rawValue as AnyObject) {
                    videos.append(Video(value: item))
                }
            }
        }
    }
    
    func refresh(id: Int64, success: @escaping () -> (Void), failure: @escaping (NSError) -> (Void)) {
        currentPage = 1
        nextWith(id: id, success: success, failure: failure)
    }
    
    func nextWith(id: Int64, success: @escaping () -> (Void), failure: @escaping (NSError) -> (Void)) {
        //var params = [String: String]()
        
        service.getMovieVideos(withId: id, params: params, page: currentPage, callback: { result in
            switch result {
            case let .success(pagination) :
                if pagination.currentPage == 1 || pagination.currentPage == 0 {
                    self.videos.removeAll()
                    
                    let dataForSaved = List(pagination.data).detachedArray()
                    self.saveListOfModels(data: dataForSaved)
                }
                if pagination.currentPage >= pagination.lastPage {
                    self.currentPage = -1
                } else {
                    self.currentPage = pagination.currentPage + 1
                }
                
                self.videos.append(contentsOf: pagination.data)
                success()
            case let .failure(error) :
                failure(error)
            }
        })
    }
    
}
