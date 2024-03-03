//
//  ArticleDetailViewController.swift
//  News
//
//  Created by Imanol Ortiz on 3/3/24.
//

import UIKit

protocol ArticleDetailViewProtocol: AnyObject{
    func set(article: ArticleEntity)
}

class ArticleDetailViewController: UIViewController {
    
    var article: ArticleEntity?
    
    var presenter: ArticleDetailPresenterProtocol?
    
    private lazy var articleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
        
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter?.viewDidLoad()
    }
    
    private func layout(){
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        
        view.addSubview(descriptionLabel)
        
        view.addSubview(articleImage)
        
        NSLayoutConstraint.activate([
            
            articleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            articleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            articleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            articleImage.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }

}

extension ArticleDetailViewController: ArticleDetailViewProtocol{
    
    func set(article: ArticleEntity) {
        DispatchQueue.main.async{
            self.article = article
            self.titleLabel.text = article.title
            self.descriptionLabel.text = article.description
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                self.articleImage.kf.setImage(with: url)
            }
        }
    }
    
}
