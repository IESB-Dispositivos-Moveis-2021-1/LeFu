//
//  MakeupModel.swift
//  LeFu
//
//  Created by Pedro Henrique on 07/10/21.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    static let brands = ["almay", "alva", "anna sui", "annabelle", "benefit", "boosh", "burt's bees", "butter london", "c'est moi", "cargo cosmetics", "china glaze", "clinique", "coastal classic creation", "colourpop", "covergirl", "dalish", "deciem", "dior", "dr. hauschka", "e.l.f.", "essie", "fenty", "glossier", "green people", "iman", "l'oreal", "lotus cosmetics usa", "maia's mineral galaxy", "marcelle", "marienatie", "maybelline", "milani", "mineral fusion", "misa", "mistura", "moov", "nudus", "nyx", "orly", "pacifica", "penny lane organics", "physicians formula", "piggy paint", "pure anada", "rejuva minerals", "revlon", "sally b's skin yummies", "salon perfect", "sante", "sinful colours", "smashbox", "stila", "suncoat", "w3llpeople", "wet n wild", "zorah", "zorah biocosmetiques"]
    static let tags = ["Canadian", "CertClean", "Chemical Free", "Dairy Free", "EWG Verified", "EcoCert", "Fair Trade", "Gluten Free", "Hypoallergenic", "Natural", "No Talc", "Non-GMO", "Organic", "Peanut Free Product", "Sugar Free", "USDA Organic", "Vegan", "alcohol free", "cruelty free", "oil free", "purpicks", "silicone free", "water free"]
    
    
    let id: Int?
    let brand, name, price, priceSign: String?
    let currency: String?
    let imageLink: String?
    let productLink, websiteLink: String?
    let productDescription: String?
    let rating: Int?
    let category, productType: String?
    let tagList: [String]?
    let createdAt, updatedAt: String?
    let productAPIURL: String?
    let apiFeaturedImage: String?
    let productColors: [ProductColor]?

    enum CodingKeys: String, CodingKey {
        case id, brand, name, price
        case priceSign = "price_sign"
        case currency
        case imageLink = "image_link"
        case productLink = "product_link"
        case websiteLink = "website_link"
        case productDescription = "description"
        case rating, category
        case productType = "product_type"
        case tagList = "tag_list"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case productAPIURL = "product_api_url"
        case apiFeaturedImage = "api_featured_image"
        case productColors = "product_colors"
    }
}

// MARK: - ProductColor
struct ProductColor: Codable {
    let hexValue, colourName: String?

    enum CodingKeys: String, CodingKey {
        case hexValue = "hex_value"
        case colourName = "colour_name"
    }
}
