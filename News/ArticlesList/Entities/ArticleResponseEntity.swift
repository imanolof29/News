//
//  ArticleResponseEntity.swift
//  News
//
//  Created by Imanol Ortiz on 2/3/24.
//

import Foundation

struct ArticleResponseEntity: Decodable{
    let status: String
    let totalResults: Int
    let articles: [ArticleEntity]
}
