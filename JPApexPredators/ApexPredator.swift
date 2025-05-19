//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Nithish on 19/05/25.
//

import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable{
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

enum APType : String, Decodable, CaseIterable, Identifiable {
    var id: APType {
        self
    }
    
    case all
    case land   // "land"
    case air
    case sea
    
    var background: Color {
        switch self {
        case .land:
                .brown
        case .air:
                .teal
        case .sea:
                .blue
        case .all:
                .black
        }
    }
    
    var icon: String {
        switch self {
        case .land:
            "square.stack.3d.up.fill"
        case .air:
            "leaf.fill"
        case .sea:
            "wind"
        case .all:
            "drop.fill"
        }
    }
}
