//
//  ISSPosition.swift
//  ISSLocation
//
//  Created by David Amezcua on 5/16/24.
//

struct ISSPositionResponse: Codable {
    let message: String
    let timestamp: Int
    let issPosition: ISSPosition

    enum CodingKeys: String, CodingKey {
        case message, timestamp
        case issPosition = "iss_position"
    }
}

struct ISSPosition: Codable {
    let latitude: String
    let longitude: String
}
