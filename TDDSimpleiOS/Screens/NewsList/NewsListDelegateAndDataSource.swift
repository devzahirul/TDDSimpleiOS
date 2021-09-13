//
//  NewsListDelegateAndDataSource.swift
//  TDDSimpleiOS
//
//  Created by Islam Md. Zahirul on 13/9/21.
//

import UIKit

class NewsListDelegateAndDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDelegate, UITableViewDataSource {
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

