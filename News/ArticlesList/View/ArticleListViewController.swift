//
//  ArticleListViewController.swift
//  News
//
//  Created by Imanol Ortiz on 2/3/24.
//

import UIKit

protocol ArticlesListViewProtocol: AnyObject {
    
    func showArticles(articles: [ArticleEntity])
    
    func showErrorAlert()
    
    func showLoading()
    
    func hideLoading()
    
}

class ArticleListViewController: UIViewController {
    
    var presenter: ArticleListPresenter?
    
    private var articles = [ArticleEntity]()
    
    lazy var articlesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.cellId)
        return tableView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        layout()
        presenter?.viewDidLoad()
    }
    
    private func setupNavigationBar(){
        navigationItem.title = "Articles"
    }
    
    
    private func layout(){
        view.backgroundColor = .systemBackground
        view.addSubview(articlesTableView)
        view.addSubview(activityIndicator)
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
        articlesTableView.delegate = self
        articlesTableView.dataSource = self
        articlesTableView.refreshControl = refreshControl
        NSLayoutConstraint.activate([
            //ARTICLES TABLEVIEW
            articlesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            articlesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            articlesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            articlesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            //ACTIVITY INDICATOR
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func refreshNews(_ sender: UIRefreshControl) {
        presenter?.viewDidLoad()
    }
    
}

extension ArticleListViewController: ArticlesListViewProtocol{
    
    func showLoading() {
        DispatchQueue.main.async{
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async{
            self.activityIndicator.stopAnimating()
            if self.refreshControl.isRefreshing{
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    
    func showArticles(articles: [ArticleEntity]) {
        self.articles = articles
        DispatchQueue.main.async{
            self.articlesTableView.reloadData()
        }
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Unable to load articles.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}

extension ArticleListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.cellId, for: indexPath) as! ArticleTableViewCell
        
        cell.setupArticle(articles[indexPath.row])
            
        return cell
    }
    
}

extension ArticleListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        presenter?.showArticleDetails(article: article)
    }
    
}


