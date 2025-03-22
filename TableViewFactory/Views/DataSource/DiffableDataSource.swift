//
//  DiffableDataSource.swift
//  TableViewFactory
//
//  Created by CallmeOni on 21/3/2568 BE.
//

import Foundation
import UIKit

protocol CellModel {
    var nameItem: String { get }
}

enum SectionDiff: CaseIterable {
    case mainA
    case mainB
    
    var title: String {
        switch self {
        case .mainA:
            return "Main A"
        case .mainB:
            return "Main B"
        }
    }
}

enum Rows: Hashable {
    case rowsMainA([Row])
    case rowsMainB([Row])
    
    var items: [Row] {
        switch self {
        case .rowsMainA(let rows), .rowsMainB(let rows):
            return rows
        }
    }
}

struct Row: Hashable, CellModel {
    let id = UUID()
    let nameItem: String
}

class DiffableDataSource: UITableViewDiffableDataSource<SectionDiff, Rows> {
    
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, item in
            switch item {
            case .rowsMainA(let model):
                let cell = TableViewFactory.createViewCell(for: tableView, cellType: CustomTableViewCell.self, indexPath: indexPath)
                (cell as? CustomTableViewCell)?.configure(with: model[indexPath.row], indexPath: indexPath, delegate: nil)
                return cell
            case .rowsMainB(let model):
                let cell = TableViewFactory.createViewCell(for: tableView, cellType: CustomTableViewCell2.self, indexPath: indexPath)
                (cell as? CustomTableViewCell2)?.configure(with: model[indexPath.row], indexPath: indexPath)
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = SectionDiff.allCases[section]
        return header.title
    }
}
