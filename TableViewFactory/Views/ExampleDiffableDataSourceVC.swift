//
//  ExampleDiffableDataSourceVC.swift
//  TableViewFactory
//
//  Created by CallmeOni on 21/3/2568 BE.
//

import UIKit

class ExampleDiffableDataSourceVC: UIViewController, UITableViewDelegate {
    
    private var tableView: UITableView!
    private lazy var dataSource = DiffableDataSource(tableView: tableView)
    
    private let itemMainA: [Rows] = [
        .rowsMainA(
            [
                .init(nameItem: "Main A-1"),
                .init(nameItem: "Main A-2")
            ]
        )]
    
    private let itemMainB: [Rows] = [
        .rowsMainB(
            [
                .init(nameItem: "Main B-1"),
                .init(nameItem: "Main B-2")
            ]
        )]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func applySnapShop() {
        var snapShot = NSDiffableDataSourceSnapshot<SectionDiff, Rows>()
        snapShot.appendSections([.mainA, .mainB])
        snapShot.appendItems(itemMainA, toSection: .mainA)
        snapShot.appendItems(itemMainB, toSection: .mainB)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    private func setupTableView() {
        tableView = TableViewFactory.createTableView(for: .plain, separatorStyle: .none, cellTypes: [CustomTableViewCell.self, CustomTableViewCell2.self])
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .rowsMainA(let items):
            print("Main A: \(items)")
        case .rowsMainB(let items):
            print("Main B: \(items)")
        }
    }
}
