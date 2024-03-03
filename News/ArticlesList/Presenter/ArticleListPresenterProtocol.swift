//
//  ArticleListPresenterProtocol.swift
//  News
//
//  Created by Imanol Ortiz on 3/3/24.
//

import Foundation

protocol ArticleListPresenterProtocol: AnyObject{
    func viewDidLoad()
    func showArticleDetails(article: ArticleEntity)
}

class ArticleListPresenter: ArticleListPresenterProtocol {
    
    weak var view: ArticlesListViewProtocol?
    
    var articleListRouter: ArticleListRouter
    
    var articleListInteractor: ArticleListInteractorProtocol

    init(articleListInteractor: ArticleListInteractorProtocol, articleListRouter: ArticleListRouter) {
        self.articleListInteractor = articleListInteractor
        self.articleListRouter = articleListRouter
    }

    func viewDidLoad() {
        view?.showLoading()
        Task{
            await articleListInteractor.fetchArticles()
        }
    }

    func showArticleDetails(article: ArticleEntity) {
        articleListRouter.showArticleDetail(article: article)
    }
}

extension ArticleListPresenter: ArticleListInteractorOutputProtocol {
    
    func articlesFetched(_ articles: [ArticleEntity]?) {
        view?.hideLoading()
        if let articles = articles {
            view?.showArticles(articles: articles)
        } else {
            view?.showErrorAlert()
        }
    }
    
}
