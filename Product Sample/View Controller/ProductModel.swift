//
//  ProductModel.swift
//  Product Sample
//
//  Created by OmPrakash Jangid on 13/07/23.
//
import Foundation
import UIKit


// MARK: - UserList
class UserList: Codable {
    
    var products: [Product]?
    var total: Int?
    var skip: Int?
    var limit: Int?

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(products, forKey: .products)
        try container.encodeIfPresent(total, forKey: .total)
        try container.encodeIfPresent(skip, forKey: .skip)
        try container.encodeIfPresent(limit, forKey: .limit)
    }

}

// MARK: - Product
class Product : Codable {
    var id: Int?
    var title: String?
    var description: String?
    var price: Int?
    var discountPercentage: Double?
    var rating: Double?
    var stock: Int?
    var brand: String?
    var category: String?
    var thumbnail: String?
    var images: [String]?
    var isSelected: Bool? = false
    var Quentity: Int? = 0

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(discountPercentage, forKey: .discountPercentage)
        try container.encodeIfPresent(rating, forKey: .rating)
        try container.encodeIfPresent(stock, forKey: .stock)
        try container.encodeIfPresent(brand, forKey: .brand)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(thumbnail, forKey: .thumbnail)
        try container.encodeIfPresent(images, forKey: .images)
    }

}
