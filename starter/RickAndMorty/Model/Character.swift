//
//  Character.swift
//  RickAndMorty
//
//  Created by Alisher on 08.10.2023.
//

import UIKit

struct Character: Decodable, Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: Gender
    let image: String
    let origin: CharacterOrigin
    
    enum CharacterStatus: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
        
        var color: UIColor {
            switch self {
            case .alive:   return .systemGreen
            case .dead:    return .systemRed
            case .unknown: return .systemGray
            }
        }
    }
    
    enum Gender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown = "unknown"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}

struct CharacterOrigin: Decodable {
    let name: String
}
