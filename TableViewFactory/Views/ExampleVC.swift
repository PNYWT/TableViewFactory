//
//  OldSchoolVC.swift
//  TableViewFactory
//
//  Created by CallmeOni on 20/3/2568 BE.
//

import UIKit

class ExampleVC: UIViewController {
    
    private var tableView: UITableView!
    private var dataSource: TableViewDataSource!
    private var viewModel: TableViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.triggerReloadData.send(())
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
        let refreshButton = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshData))
        
        navigationItem.rightBarButtonItems = [addButton, refreshButton]
    }
    
    private func setupTableView() {
        tableView = TableViewFactory.createTableView(for: .plain, separatorStyle: .none, cellType: CustomTableViewCell.self)
        view.addSubview(tableView)
        tableView.frame = view.bounds
        dataSource = TableViewDataSource { [weak self] indexPath in
            self?.viewModel.triggerRemove.send(indexPath)
        }
        tableView.dataSource = dataSource
        viewModel = .init(tableView: tableView, dataSource: dataSource)
    }
}

extension ExampleVC {
    @objc private func addItem() {
        let item1 = Section.init(nameSection: .fruits, item: [.init(nameItem: "Banana")])
        let item2 = Section.init(nameSection: .animals, item: [.init(nameItem: "Fish")])
        viewModel.triggerAddItem.send(Bool.random() ? item1 : item2)
    }

    @objc private func refreshData() {
        viewModel.triggerReloadData.send()
    }
}
