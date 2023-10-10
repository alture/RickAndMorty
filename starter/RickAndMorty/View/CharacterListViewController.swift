//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Alisher on 08.10.2023.
//

import UIKit
import Combine

final class CharacterListViewController: UIViewController {
    
    private let viewModel: CharacterListViewModel = CharacterListViewModel()
    
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Character>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Character>
    
    private var dataSource: DataSource! = nil
    private var currentSnapshot: Snapshot! = nil
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.identifier)
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureDataSource()
        setupNavigationBar()
        setupView()
        bindViewModel()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Rick and Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
    
    private func setupView() {
        view.addSubviews([tableView, activityIndicator])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func bindViewModel() {
        // Создаем связку с ViewModel
    }
    
    
    private func render(with state: CharacterListState) {
        switch state {
        case .idle:
            // Отправляем событие для нашего subject
            break
        case .loading:
            activityIndicator.startAnimating()
        case .success(let data):
            activityIndicator.stopAnimating()
            applySnapshots(data)
        case .error(let error):
            if activityIndicator.isAnimating { activityIndicator.stopAnimating() }
            print("error: \(error.localizedDescription)")
        }
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier:  CharacterListCell.identifier,
                for: indexPath) as? CharacterListCell
            else {
                return nil
            }
            
            cell.configure(from: item)
            cell.selectionStyle = .none
            // Загрузка изображение

            return cell
        })
    }
    
    private func applySnapshots(_ characters: [Character]) {
        currentSnapshot = Snapshot()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(characters, toSection: .main)
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.characters.count - 1 {
            // Подгружаем данные
        }
    }
}

