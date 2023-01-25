//
//  Coordinates.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//

/// the coordinate model
struct Coordinates: Codable {
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
    }
    
    init() {}
    
    init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
    
    func encode(from encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(latitude, forKey: .latitude)
    }
    
    init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        longitude = try keyedContainer.decodeIfPresent(Double.self, forKey: .longitude) ?? 0.0
        latitude = try keyedContainer.decodeIfPresent(Double.self, forKey: .latitude) ?? 0.0
        return
    }
    
    /// returns string combined with longitude, latitude to be used as query parameter while url encoding
    /// - Returns: string of Longitude, latitude
    func getQueryParameter() -> String {
        return [String(longitude), String(latitude)].joined(separator: ",")
    }
}
