//
//  ApiService.swift
//  AlamofireDemo
//
//  Created by Ivan on 13.05.21.
//

import Foundation
import Alamofire
import Combine

class ApiService {
    static let BASE_URL = "https://jsonplaceholder.typicode.com/"
    
    func getComments() -> AnyPublisher<[Comment],AFError>{
        let publisher = AF.request(ApiService.BASE_URL + "comments",
                                   method: .get)
            .publishDecodable(type: [Comment].self)
        return publisher.value()
    }
}
