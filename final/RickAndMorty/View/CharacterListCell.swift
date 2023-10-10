//
//  CharacterListCell.swift
//  RickAndMorty
//
//  Created by Alisher on 08.10.2023.
//

import UIKit

class CharacterListCell: UITableViewCell {
    static let identifier = String(describing: CharacterListCell.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.gray
        return label
    }()
    
    private lazy var statusRoundedView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 2.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lastLocationTitle: UILabel = {
        let label = UILabel()
        label.text = "Last known location:"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var lastLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleHStackView,
            lastLocationTitle,
            lastLocationLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 2.0
        stackView.setCustomSpacing(8.0, after: subtitleHStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var subtitleHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusRoundedView, subtitleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 4.0
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubviews([characterImageView, vStackView])
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            characterImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16.0),
            characterImageView.widthAnchor.constraint(equalToConstant: 80),
            characterImageView.heightAnchor.constraint(equalToConstant: 80),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            
            vStackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 8.0),
            vStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            statusRoundedView.heightAnchor.constraint(equalToConstant: 5),
            statusRoundedView.widthAnchor.constraint(equalToConstant: 5)
        ])
    }
    
    func configure(from character: Character) {
        titleLabel.text = character.name
        subtitleLabel.text = "\(character.status.rawValue) - \(character.species)"
        statusRoundedView.backgroundColor = character.status.color
        lastLocationLabel.text = character.origin.name
    }
    
    func setImage(image: UIImage) {
        characterImageView.image = image
    }
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
