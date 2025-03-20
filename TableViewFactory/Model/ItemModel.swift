//
//  Model.swift
//  TableViewFactory
//
//  Created by CallmeOni on 20/3/2568 BE.
//

import Foundation
/*
 // แบบ UITableViewDataSource ใช้เท่านี้ก็พอ
 struct Item {
 let name: String
 let section: SectionType
 }
 
 enum SectionType: Int, CaseIterable {
 case fruits = 0
 case animals
 }
 */

// Hashable สำหรับ UITableViewDiffableDataSource

struct Section {
    let nameSection: SectionType
    var item: [Item]
}

struct Item {
    let nameItem: String
}

enum SectionType: Int, CaseIterable {
    case fruits = 0
    case animals
    
    var title: String {
        switch self {
        case .fruits: return "Fruits"
        case .animals: return "Animals"
        }
    }
}
