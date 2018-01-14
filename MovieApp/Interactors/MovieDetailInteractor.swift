//
//  MovieDetailInteractor.swift
//  MovieApp
//
//  Created by bungkhus on 14/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class MovieDetailInteractor: BaseInteractor {
    
    var movie: Movie?
    
    // load detail from realm
    //
    func loadWith(id: Int64) {
        let result = realm.objects(Movie.self).filter("identifier==\(id)").first
        if let dataRealm = result {
            let data = Movie(value: dataRealm)
            self.movie = data
        }
    }
    
    // Detail
    //
    func refresh(withId id: Int64, success: @escaping () -> (Void), failure: @escaping (NSError) -> (Void)) {
        service.getMovieDetail(id: id, params: params, callback: { result in
            switch result {
            case let .success(movie) :
                self.movie = movie
                self.saveModel(data: movie)
                success()
            case let .failure(error) :
                failure(error)
            }
        })
    }
    
}
