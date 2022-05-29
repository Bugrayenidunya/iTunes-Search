//
//  MediaType.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import Foundation

enum MediaType {
    case all
    case app
    case book
    case movie
    case music

    init?(segment: Int) {
        switch segment {
            case 0:
                self = .all
            case 1:
                self = .movie
            case 2:
                self = .music
            case 3:
                self = .app
            case 4:
                self = .book
            default:
                self = .all
        }
    }
}

extension MediaType {
    var value: String {
        switch self {
            case .all:
                return "all"
            case .app:
                return "software"
            case .book:
                return "ebook"
            case .movie:
                return "movie"
            case .music:
                return "music"
        }
    }
}
