//
//  BaseCoreService.swift
//  BaseCore
//
//  Created by Rifat Firdaus on 11/18/16.
//  Copyright © 2016 Suitmedia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

open class BaseCoreService: NSObject {
    public static let instance = BaseCoreService()
    public var manager = BaseSessionManager()
    public var home = ""
    
    public func setup(home: String) {
        self.home = home
    }
    
    func getAgenda(params: [String : String], page: Int = 1, perPage: Int = 10, callback: @escaping (APIResult<Pagination<[Agenda]>>) -> (Void)) {
        var parameters: [String: AnyObject] = [:]
        for (key, value) in params {
            parameters[key] = value as AnyObject?
        }
        parameters["page"] = page as AnyObject?
        parameters["perPage"] = perPage as AnyObject?
        let request = manager.request(home + "/api/v1/schedules", method: .get, parameters: parameters)
        request.responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                let status = json["status"]
                let message = json["message"]
                let resultJson = json["result"]
                
                let total = resultJson["total"].intValue
                let currentPage = resultJson["current_page"].intValue
                let lastPage = resultJson["last_page"].intValue
                
                if status.exists() && status.intValue == 200 {
                    var items = [Agenda]()
                    for itemJson in resultJson["data"].arrayValue {
                        if let item = Agenda.with(json: itemJson) {
                            items.append(item)
                        }
                    }
                    let pagination = Pagination<[Agenda]>(total: total, currentPage: currentPage, lastPage: lastPage, data: items)
                    callback(.success(pagination))
                } else {
                    let error = NSError(domain: "Kongres PSSI", code: -1, userInfo: [NSLocalizedDescriptionKey: "\(message.object)"])
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

public class SuitmobileSessionManagerKongresPssi: BaseSessionManager {
    
    override public func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        var overidedHeaders = HTTPHeaders()
        overidedHeaders["X-PublicKey"] = "a2eef91f13e22ad4e0d9ccc6fc36726ff67eb4c8"
        overidedHeaders["X-HashKey"] = "826fa352f4a3e6b3d68c63e47203185b"
        if let headers = headers {
            for (key, value) in headers {
                overidedHeaders[key] = value
            }
        }
        
        var overidedParameters = [String: AnyObject]()
        //overidedParameters["api_usr"] = SuitmobileCoreService.API_USER as AnyObject
        //overidedParameters["api_pwd"] = SuitmobileCoreService.API_PASS as AnyObject
        if let parameters = parameters {
            for (key, value) in parameters {
                overidedParameters[key] = value as AnyObject?
            }
        }
        return super.request(url, method: method, parameters: overidedParameters, encoding: encoding, headers: overidedHeaders)
    }
    
    public override func download(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, to destination: DownloadRequest.DownloadFileDestination?) -> DownloadRequest {
        var overidedParameters = [String: AnyObject]()
        //overidedParameters["api_usr"] = SuitmobileCoreService.API_USER as AnyObject
        //overidedParameters["api_pwd"] = SuitmobileCoreService.API_PASS as AnyObject
        if let parameters = parameters {
            for (key, value) in parameters {
                overidedParameters[key] = value as AnyObject?
            }
        }
        
        return super.download(url, method: method, parameters: overidedParameters, to: destination)
    }
    
}

open class BaseSessionManager: SessionManager {
    
    convenience init() {
        let configuration = URLSessionConfiguration.default
        //Dotzu.sharedManager.addLogger(session: configuration)
        self.init(configuration:configuration)
    }
    
    override open func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        do {
            let urlRequest = URLRequest(url: try url.asURL())
            let request = try! encoding.encode(urlRequest, with: parameters)
            print("[\(method.rawValue)] \(request)")
        } catch {
            print("Error URL Request")
        }
        return super.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    override open func download(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, to destination: DownloadRequest.DownloadFileDestination?) -> DownloadRequest {
        do {
            let urlRequest = URLRequest(url: try url.asURL())
            let request = try! encoding.encode(urlRequest, with: parameters)
            print("[\(method.rawValue)] \(request)")
        } catch {
            print("Error URL Request")
        }
        return super.download(url, method: method, parameters: parameters, encoding: encoding, headers: headers, to: destination)
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
