//
//  CharacterListContracts.swift
//  RickAndMorty
//
//  Created by Alisher on 7.10.2023.
//

import Foundation
import Combine

enum CharacterListState {
    case idle
    case loading
    case success(data: [Character])
    case error(Error)
}

protocol CharacterListViewModelType {
    func bind(input: CharacterListViewInput)
}

protocol CharacterListViewInput {
    var fetch: PassthroughSubject<Void, Error> { get }
    var loadMore: PassthroughSubject<Void, Error> { get }
}
