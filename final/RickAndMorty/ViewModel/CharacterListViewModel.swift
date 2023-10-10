//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Alisher on 08.10.2023.
//

import UIKit
import Combine

final class CharacterListViewModel {
    @Published var state: CharacterListState = .idle
    var characters: [Character] = []
    private var cancellables: Set<AnyCancellable> = []
    private var nextUrl: String?
    
    
    func loadData()  {
        let url: URL
        
        if let nextUrl {
            url = URL(string: nextUrl)!
        } else {
            url = URL(string: "https://rickandmortyapi.com/api/character")!
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CharacterList.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { [weak self] output in
                self?.nextUrl = output.info.next
            })
            .map(\.results)
            .reduce(characters, { accum, next in
                accum + next
            })
            .print()
            .sink { [weak self] error in
                if case let .failure(error) = error {
                    self?.state = .error(error)
                }
            } receiveValue: { [weak self] in
                guard let self else { return }
                self.characters = $0
                self.state = .success(data: $0)
            }
            .store(in: &cancellables)
    }
}

extension CharacterListViewModel: CharacterListViewModelType {
    func bind(input: CharacterListViewInput) {
        let fetch = input
            .fetch
            .handleEvents(receiveOutput: { _ in
                self.state = .loading
            })

        let loadMore = input
            .loadMore
            .handleEvents(receiveSubscription: { subs in
                print("LoadMore - Subscription: \(subs.combineIdentifier)")
            }, receiveOutput: { _ in
                print("LoadMore - in output handler")
            }, receiveCompletion: { _ in
                print("LoadMore - in completion handler")
            }, receiveCancel: {
                print("LoadMore - received cancel")
            }, receiveRequest: { (demand) in
                print("LoadMore - received demand: \(demand.description)")
            })
        
        Publishers.Merge(fetch, loadMore)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] _ in
                self?.loadData()
            })
            .store(in: &cancellables)
    }
}
