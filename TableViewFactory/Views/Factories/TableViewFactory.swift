//
//  TableViewFactory.swift
//  TableViewFactory
//
//  Created by CallmeOni on 20/3/2568 BE.
//

import UIKit

class TableViewFactory {
    static func createTableView<Cell: UITableViewCell>(
        for style: UITableView.Style,
        separatorStyle: UITableViewCell.SeparatorStyle,
        cellType: Cell.Type
    ) -> UITableView {
        let tableView = UITableView(frame: .zero, style: style)
        tableView.separatorStyle = separatorStyle
        tableView.register(cellType, forCellReuseIdentifier: String(describing: cellType))
        return tableView
    }
    
    static func createViewCell<Cell: UITableViewCell>(for tableView: UITableView, cellType: Cell.Type, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}
