//
//  Constants.swift
//  fetchFreeApi
//
//  Created by Anton Honcharov on 02.03.2023.
//

import Foundation

struct K {
    static let urlDogs = "https://dog.ceo/api";
    // https://dog.ceo/api/breeds/list/all
    // https://dog.ceo/api/breed/bulldog/boston/images/random
    
    static let RequestHeaderField = "Content-Type"
    static let RequestHeaderValue = "application/json"
    
    enum RequestMethods: String {
        case GET = "GET"
        case POST = "POST"
    }
}
