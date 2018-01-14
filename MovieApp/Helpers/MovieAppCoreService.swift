//
//  MovieAppCoreService.swift
//  MovieAppCore
//
//  Created by Rifat Firdaus on 11/18/16.
//  Copyright © 2016 Suitmedia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

open class MovieAppCoreService: NSObject {
    public static let instance = MovieAppCoreService()
    public var manager = BaseSessionManager()
    public var home = ""
    
    public func setup(home: String) {
        self.home = home
    }
    
    func getMovieDetail(id: Int64, params: [String : String], callback: @escaping (APIResult<Movie>) -> (Void)) {
        var parameters: [String: AnyObject] = [:]
        for (key, value) in params {
            parameters[key] = value as AnyObject?
        }
        let request = manager.request(home + "/movie/\(id)", method: .get, parameters: parameters)
        request.responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                if json.exists(){
                    if let news = Movie.with(json: json) {
                        callback(.success(news))
                    } else {
                        let error = NSError(domain: "BaliUnited", code: -1, userInfo: [NSLocalizedDescriptionKey: "ERROR: Parsing JSON"])
                        print(error.localizedDescription)
                        callback(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "BaliUnited", code: -1, userInfo: [NSLocalizedDescriptionKey: "ERROR: json doesn't exist."])
                    print(error.localizedDescription)
                    callback(.failure(error))
                }
            case let .failure(error):
                print(error.localizedDescription)
                callback(.failure(error as NSError))
            }
        }
    }
    
    func getMovieNowPlaying(params: [String : String], page: Int = 1, callback: @escaping (APIResult<Pagination<[Movie]>>) -> (Void)) {
        var parameters: [String: AnyObject] = [:]
        for (key, value) in params {
            parameters[key] = value as AnyObject?
        }
        parameters["page"] = page as AnyObject?
        let request = manager.request(home + "/movie/now_playing", method: .get, parameters: parameters)
        request.responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                let resultJson = json["results"]
                let total = json["total_results"].intValue
                let currentPage = json["page"].intValue
                let lastPage = json["total_pages"].intValue
                
                if resultJson.arrayValue.count > 0 {
                    var items = [Movie]()
                    for itemJson in resultJson.arrayValue {
                        if let item = Movie.with(json: itemJson) {
                            items.append(item)
                        }
                    }
                    let pagination = Pagination<[Movie]>(total: total, currentPage: currentPage, lastPage: lastPage, data: items)
                    callback(.success(pagination))
                } else {
                    let error = NSError(domain: "The Movie DB", code: -1, userInfo: [NSLocalizedDescriptionKey: "Data doesn't exists."])
                    print(error.localizedDescription)
                    callback(.failure(error))
                }
            case let .failure(error):
                print(error.localizedDescription)
                callback(.failure(error as NSError))
            }
        }
    }
    
    func getMovieUpcoming(params: [String : String], page: Int = 1, callback: @escaping (APIResult<Pagination<[Movie]>>) -> (Void)) {
        var parameters: [String: AnyObject] = [:]
        for (key, value) in params {
            parameters[key] = value as AnyObject?
        }
        parameters["page"] = page as AnyObject?
        let request = manager.request(home + "/movie/upcoming", method: .get, parameters: parameters)
        request.responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                let resultJson = json["results"]
                let total = json["total_results"].intValue
                let currentPage = json["page"].intValue
                let lastPage = json["total_pages"].intValue
                
                if resultJson.arrayValue.count > 0 {
                    var items = [Movie]()
                    for itemJson in resultJson.arrayValue {
                        if let item = Movie.with(json: itemJson) {
                            items.append(item)
                        }
                    }
                    let pagination = Pagination<[Movie]>(total: total, currentPage: currentPage, lastPage: lastPage, data: items)
                    callback(.success(pagination))
                } else {
                    let error = NSError(domain: "The Movie DB", code: -1, userInfo: [NSLocalizedDescriptionKey: "Data doesn't exists."])
                    print(error.localizedDescription)
                    callback(.failure(error))
                }
            case let .failure(error):
                print(error.localizedDescription)
                callback(.failure(error as NSError))
            }
        }
    }
    
    func getMoviePopular(params: [String : String], page: Int = 1, callback: @escaping (APIResult<Pagination<[Movie]>>) -> (Void)) {
        var parameters: [String: AnyObject] = [:]
        for (key, value) in params {
            parameters[key] = value as AnyObject?
        }
        parameters["page"] = page as AnyObject?
        let request = manager.request(home + "/movie/popular", method: .get, parameters: parameters)
        request.responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                let resultJson = json["results"]
                let total = json["total_results"].intValue
                let currentPage = json["page"].intValue
                let lastPage = json["total_pages"].intValue
                
                if resultJson.arrayValue.count > 0 {
                    var items = [Movie]()
                    for itemJson in resultJson.arrayValue {
                        if let item = Movie.with(json: itemJson) {
                            items.append(item)
                        }
                    }
                    let pagination = Pagination<[Movie]>(total: total, currentPage: currentPage, lastPage: lastPage, data: items)
                    callback(.success(pagination))
                } else {
                    let error = NSError(domain: "The Movie DB", code: -1, userInfo: [NSLocalizedDescriptionKey: "Data doesn't exists."])
                    print(error.localizedDescription)
                    callback(.failure(error))
                }
            case let .failure(error):
                print(error.localizedDescription)
                callback(.failure(error as NSError))
            }
        }
    }
}

open class BaseSessionManager: SessionManager {
    
    convenience init() {
        let configuration = URLSessionConfiguration.default
        self.init(configuration:configuration)
    }
    
    override open func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        var overidedParameters = [String: AnyObject]()
        overidedParameters["api_key"] = ApiConfig.apiKey as AnyObject
        if let parameters = parameters {
            for (key, value) in parameters {
                overidedParameters[key] = value as AnyObject?
            }
        }
        do {
            let urlRequest = URLRequest(url: try url.asURL())
            let request = try! encoding.encode(urlRequest, with: overidedParameters)
            print("[\(method.rawValue)] \(request)")
        } catch {
            print("Error URL Request")
        }
        return super.request(url, method: method, parameters: overidedParameters, encoding: encoding, headers: headers)
    }
}

public struct Pagination<T> {
    public let total: Int
    public let currentPage: Int
    public let lastPage: Int
    public let data: T
    
    public init(total: Int, currentPage: Int, lastPage: Int, data: T) {
        self.total = total
        self.currentPage = currentPage
        self.lastPage = lastPage
        self.data = data
    }
}

public enum APIResult<T> {
    case success(T)
    case failure(NSError)
}
