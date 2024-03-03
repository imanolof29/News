//
//  ArticleDetailPresenter.swift
//  News
//
//  Created by Imanol Ortiz on 3/3/24.
//

import Foundation

protocol ArticleDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class ArticleDetailPresenter: ArticleDetailPresenterProtocol{
    
    weak var view: ArticleDetailViewProtocol?
    
    private let interactor: ArticleDetailInteractorProtocol
    
    init(interactor: ArticleDetailInteractorProtocol){
        self.interactor = interactor
    }
    
    func viewDidLoad(){
        view?.set(article: interactor.article)
    }
    
}
