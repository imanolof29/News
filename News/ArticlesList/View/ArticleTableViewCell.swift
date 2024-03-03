//
//  ArticleTableViewCell.swift
//  News
//
//  Created by Imanol Ortiz on 3/3/24.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    
    static let cellId = "articleCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let articleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupArticle(_ article: ArticleEntity){
        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            articleImage.kf.setImage(with: url)
        }
        titleLabel.text = article.title
    }
    
    private func layout(){
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(articleImage)
        
        NSLayoutConstraint.activate([
            // Restricciones para articleImage
            articleImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            articleImage.heightAnchor.constraint(equalToConstant: 200),

            // Restricciones para titleLabel
            titleLabel.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }

}
