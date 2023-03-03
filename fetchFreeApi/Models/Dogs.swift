//
//  Dogs.swift
//  fetchFreeApi
//
//  Created by Anton Honcharov on 02.03.2023.
//

import Foundation

struct Dog: Codable {
    let breed: String;
}

struct DogListResp: Codable {
    let message: [String: [String]];
    let status: String;
}

struct DogImage: Codable {
    let message: String;
    let status: String;
}
