//
//  TableViewModel.swift
//  TableViewFactory
//
//  Created by CallmeOni on 20/3/2568 BE.
//

import Foundation
import Combine
import UIKit

class TableViewModel {
    @Published var dataArr: [Section] = []
    private var cancellables = Set<AnyCancellable>()
    
    let triggerReloadData = PassthroughSubject<Void, Never>()
    let triggerAddItem = PassthroughSubject<Section, Never>()
    let triggerRemove = PassthroughSubject<IndexPath, Never>()
    
    private var tableView: UITableView?
    private var dataSource: TableViewDataSource?
    init(tableView: UITableView? = nil, dataSource: TableViewDataSource? = nil) {
        self.tableView = tableView
        self.dataSource = dataSource
        setupBindings()
    }
    
    private func setupBindings() {
        $dataArr
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newData in
                self?.dataSource?.updateData(newData)
                self?.tableView?.reloadData()
            }
            .store(in: &cancellables)
        
        triggerReloadData
            .sink { [weak self] _ in
                self?.refreshData()
            }
            .store(in: &cancellables)
        
        triggerAddItem
            .sink { [weak self] newSection in
                self?.addItem(with: newSection)
            }
            .store(in: &cancellables)
        
        triggerRemove
            .sink { [weak self] indexPath in
                self?.removeItem(at: indexPath)
            }
            .store(in: &cancellables)
    }
    
    private func refreshData() {
        dataArr = [
            .init(nameSection: .fruits, item: [
                .init(nameItem: "Mango"), .init(nameItem: "Pineapple")
            ]),
            .init(nameSection: .animals, item: [
                .init(nameItem: "Cat"), .init(nameItem: "Tiger"), .init(nameItem: "Lion")
            ])
        ]
    }
    
    private func addItem(with newSection: Section) {
        if let index = dataArr.firstIndex(where: { $0.nameSection == newSection.nameSection }) {
            dataArr[index].item.append(contentsOf: newSection.item)
        } else {
            dataArr.append(newSection)
        }
    }
    
    private func removeItem(at indexPath: IndexPath) {
        guard indexPath.section < dataArr.count else {
            return
        }
        if dataArr[indexPath.section].item.count > 1 {
            dataArr[indexPath.section].item.remove(at: indexPath.row)
        } else {
            dataArr.remove(at: indexPath.section)
        }
    }
}
