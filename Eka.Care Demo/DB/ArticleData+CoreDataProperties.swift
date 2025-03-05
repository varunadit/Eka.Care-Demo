//
//  ArticleData+CoreDataProperties.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/5/25.
//
//

import Foundation
import CoreData


extension ArticleData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleData> {
        return NSFetchRequest<ArticleData>(entityName: "ArticleData")
    }

    @NSManaged public var title: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
}

extension ArticleData : Identifiable {

}
