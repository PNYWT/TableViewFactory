//
//  CustomTableViewCell.swift
//  TableViewFactory
//
//  Created by CallmeOni on 20/3/2568 BE.
//

import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(for indexPath: IndexPath)
}

class CustomTableViewCell: UITableViewCell {
    
    private var indexPath: IndexPath?
    weak var delegate: CustomTableViewCellDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(deleteButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: CellModel, indexPath: IndexPath, delegate: CustomTableViewCellDelegate?) {
        self.indexPath = indexPath
        self.delegate = delegate
        nameLabel.text = item.nameItem
    }
    
    @objc private func deleteButtonTapped() {
        guard let indexPath else { return }
        delegate?.didTapDeleteButton(for: indexPath)
    }
}

