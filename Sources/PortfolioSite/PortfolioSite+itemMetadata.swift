//
//  PortfolioSite+itemMetadata.swift
//  
//
//  Created by Nickolay Truhin on 09.05.2022.
//

import Foundation
import Publish

extension PortfolioSite {
    public struct ItemMetadata: MultiLanguageWebsiteItemMetadata {
        var project: ProjectMetadata?
        var event: EventMetadata?
        var career: CareerMetadata?
        var book: BookMetadata?
        var achievement: AchievementMetadata?
        
        var videos: [String]?
        var logo: String?
        var singleImage: String?
        var endDate: String?
        public var alternateLinkIdentifier: String?
    }
}

extension PortfolioSite.ItemMetadata {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter
    }()
    
    var parsedEndDate: Date? {
        if let endDate = endDate {
            return PortfolioSite.ItemMetadata.dateFormatter.date(from: endDate)
        }
        return nil
    }
}
