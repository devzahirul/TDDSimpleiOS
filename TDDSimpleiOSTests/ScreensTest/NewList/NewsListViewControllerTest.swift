//
//  NewsListViewControllerTest.swift
//  TDDSimpleiOSTests
//
//  Created by Islam Md. Zahirul on 13/9/21.
//

import XCTest
@testable import TDDSimpleiOS

class NewsListViewControllerTest: XCTestCase {

    func test_canInitViewController() throws {
       let newsListVC = try makeSUT()
        XCTAssertNotNil(newsListVC)
    }

    func test_newsTableViewNotNil() throws {
        let newsListVC = try makeSUT()
        newsListVC.loadViewIfNeeded()
        XCTAssertNotNil(newsListVC.tableView)
    }
    
    func test_newsClouser() throws {
        let newsListVC = try makeSUT()
        newsListVC.loadViewIfNeeded()
        configNewsAndReload(newsListVC: newsListVC)
        XCTAssertEqual(newsListVC.news.count, 4)
    }
    
    func test_addDelegateAndDataSource() throws {
        let newsListVC = try makeSUT()
        newsListVC.loadViewIfNeeded()

        configNewsAndReload(newsListVC: newsListVC)
        let del = setupDelegateAndDataSource(newsListVC: newsListVC)
        
        
        XCTAssertEqual(newsListVC.tableView.numberOfRows(inSection: 0), 4)
    }
    
    func testGetCellUsingIdentifierAndNotNil() throws {
        let newsListVC = try makeSUT()
        newsListVC.loadViewIfNeeded()
        configNewsAndReload(newsListVC: newsListVC)
        
        let del = setupDelegateAndDataSource(newsListVC: newsListVC)
        
        XCTAssertEqual(newsListVC.tableView.numberOfRows(inSection: 0), 4)
        
        let cell = newsListVC.tableView.cellForRow(at:IndexPath(item: 0, section: 0)) as! NewsTableViewCell
        
        XCTAssertNotNil(cell.newsTitle)
    }
    
    func test4thCellTitleAndDescription() throws {
        let newsListVC = try makeSUT()
        newsListVC.loadViewIfNeeded()
        configNewsAndReload(newsListVC: newsListVC)
        
        let del = setupDelegateAndDataSource(newsListVC: newsListVC)
        
        XCTAssertEqual(newsListVC.tableView.numberOfRows(inSection: 0), 4)
        
        let cell = newsListVC.tableView.cellForRow(at:IndexPath(item: 3, section: 0)) as! NewsTableViewCell
        
        XCTAssertEqual(cell.newsTitle.text, newsListVC.news[3].title)
    }
    
    func testConfigDelegateAndDataSource() throws {
        let newsListVC = try makeSUT()
        
        
        
       // newsListVC.delegateAndDataSource = delegateAndDataSource
        
    }
}

//MARK:- Helper methods
extension NewsListViewControllerTest {
    private func makeSUT() throws -> NewsListViewController {
        let bundle = Bundle.init(for: NewsListViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialConstroller = sb.instantiateInitialViewController() as? UINavigationController
        
        return try XCTUnwrap(initialConstroller?.topViewController as? NewsListViewController)
    }
    
    private func configNewsAndReload(newsListVC: NewsListViewController) {
        newsListVC.getNews = {
            return [
                NewsModel(title: nil, description: nil),
                NewsModel(title: nil, description: "Only description!"),
                NewsModel(title: "", description: nil),
                NewsModel(title: "A title ", description: "A description!")
            ]
        }
        newsListVC.reloadNewsList()
    }
    
    func setupDelegateAndDataSource(newsListVC: NewsListViewController) -> ModelNewsDataSourceAndDelegate<NewsModel, NewsTableViewCell> {
        let delgateAndDataSource = ModelNewsDataSourceAndDelegate<NewsModel, NewsTableViewCell>(data: newsListVC.news, configCell: { indexPath, model in
            
            let cell = newsListVC.tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
            
            cell.newsTitle.text = model.title
            cell.newsDescription.text = model.description
            return cell
        })
        newsListVC.tableView.dataSource = delgateAndDataSource
        newsListVC.tableView.delegate = delgateAndDataSource
        return delgateAndDataSource
    }
}


class ModelNewsDataSourceAndDelegate<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate {
    typealias CellConfigurationCallback = (IndexPath, Model) -> Cell
    var data: [Model]
    var cellConfig: CellConfigurationCallback
    
    init(data: [Model], configCell: @escaping CellConfigurationCallback) {
        self.data = data
        self.cellConfig = configCell
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellConfig(indexPath, data[indexPath.row])
    }
}
