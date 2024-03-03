//
//  ArticleDetailInteractor.swift
//  News
//
//  Created by Imanol Ortiz on 3/3/24.
//

import Foundation

protocol ArticleDetailInteractorProtocol: AnyObject {
    
    var article: ArticleEntity { get }
    
}

class ArticleDetailInteractor: ArticleDetailInteractorProtocol{
    
    var article: ArticleEntity
    
    init(article: ArticleEntity) {
        self.article = article
    }
    
}
