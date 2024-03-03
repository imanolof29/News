//
//  ArticleListRouter.swift
//  News
//
//  Created by Imanol Ortiz on 2/3/24.
//

import Foundation
import UIKit

class ArticleListRouter {
    
    weak var viewController: ArticleListViewController?
    
    static func build() -> ArticleListViewController{
        let router = ArticleListRouter()
        let interactor = ArticleListInteractor()
        let presenter = ArticleListPresenter(articleListInteractor: interactor, articleListRouter: router)
        let viewController = ArticleListViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
    func showArticleDetail(article: ArticleEntity) {
        let vc = ArticleDetailRouter.build(article: article)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
