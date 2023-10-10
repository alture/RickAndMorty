//
//  CharacterList.swift
//  RickAndMorty
//
//  Created by Alisher on 08.10.2023.
//

import Foundation

struct CharacterList: Decodable {
    var info: CharacterInfo
    var results: [Character]
}

struct CharacterInfo: Decodable {
    var count: Int
    var pages: Int
    var next: String
    var prev: String?
}

