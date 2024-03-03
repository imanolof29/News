//
//  ArticleEntity.swift
//  News
//
//  Created by Imanol Ortiz on 2/3/24.
//

import Foundation

struct ArticleEntity: Decodable{
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
}
