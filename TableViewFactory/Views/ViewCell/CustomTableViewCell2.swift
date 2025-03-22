//
//  File.swift
//  TableViewFactory
//
//  Created by CallmeOni on 21/3/2568 BE.
//

import UIKit

class CustomTableViewCell2: UITableViewCell {
    
    private var indexPath: IndexPath?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: CellModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        nameLabel.text = item.nameItem + "\(indexPath.row)"
    }
}
