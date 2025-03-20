//
//  TableViewDataSource.swift
//  TableViewFactory
//
//  Created by CallmeOni on 20/3/2568 BE.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource, CustomTableViewCellDelegate {
    
    var data: [Section] = []
    
    private let cellProvider: (IndexPath) -> Void
    init(configure: @escaping (IndexPath) -> Void) {
        self.cellProvider = configure
    }
    
    func updateData(_ newData: [Section]) {
        self.data = newData
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewFactory.createViewCell(for: tableView, cellType: CustomTableViewCell.self, indexPath: indexPath)
        (cell as? CustomTableViewCell)?.configure(with: data[indexPath.section].item[indexPath.row], indexPath: indexPath, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].nameSection.title
    }
    
    func didTapDeleteButton(for indexPath: IndexPath) {
        cellProvider(indexPath)
    }
}
