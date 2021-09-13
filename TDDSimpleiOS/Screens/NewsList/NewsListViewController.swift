//
//  NewsListViewController.swift
//  TDDSimpleiOS
//
//  Created by Islam Md. Zahirul on 13/9/21.
//

import UIKit

class NewsListViewController: UIViewController {
    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Propertices
    var news: [NewsModel]!
    var delegateAndDataSource: NewsListDelegateAndDataSource<NewsModel, NewsTableViewCell>!
    
    var getNews: () -> [NewsModel] = {
        return []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "NewsList"
        reloadNewsList()
    }
    
    func setupDelegateAndDataSource() {
        delegateAndDataSource = NewsListDelegateAndDataSource(data: news, configCell: {[weak self] indexPath, model in
            
            let cell = self?.tableView?.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
            cell.newsTitle.text = model.title
            cell.newsDescription.text = model.description
            return cell
        })
        tableView.delegate = delegateAndDataSource
        tableView.dataSource = delegateAndDataSource
        
    }
    
    func reloadNewsList() {
        news = getNews()
        if delegateAndDataSource == nil {
            setupDelegateAndDataSource()
        }
        tableView.reloadData()
    }
}



