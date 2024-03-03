//
//  ArticleListInteractor.swift
//  News
//
//  Created by Imanol Ortiz on 3/3/24.
//

import Foundation

protocol ArticleListInteractorProtocol: AnyObject{
    func fetchArticles() async
}

protocol ArticleListInteractorOutputProtocol: AnyObject{
    func articlesFetched(_ articles: [ArticleEntity]?)
}

class ArticleListInteractor : ArticleListInteractorProtocol{
    
    weak var presenter: ArticleListPresenter?
    
    func fetchArticles() async {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=API_KEY")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        let response = try! JSONDecoder().decode(ArticleResponseEntity.self, from: data)
        presenter?.articlesFetched(response.articles)
    }
    
}
