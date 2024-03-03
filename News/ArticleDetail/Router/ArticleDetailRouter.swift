//
//  ArticleDetailRouter.swift
//  News
//
//  Created by Imanol Ortiz on 3/3/24.
//

import Foundation

class ArticleDetailRouter{
    
    static func build(article: ArticleEntity) -> ArticleDetailViewController {
        let interactor = ArticleDetailInteractor(article: article)
        let presenter = ArticleDetailPresenter(interactor: interactor)
        let viewController = ArticleDetailViewController()
        
        presenter.view = viewController
        viewController.presenter = presenter
        
        return viewController
    }
    
}
