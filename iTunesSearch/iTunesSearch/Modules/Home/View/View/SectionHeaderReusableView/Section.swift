//
//  Section.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

final class Section: Hashable {
    
    // MARK: Properties
    var id = UUID()
    var title: String
    var items: [HomeCollectionViewCellViewModel]
    
    // MARK: Init
    init(title: String, items: [HomeCollectionViewCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    // MARK: Functions
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}
