//
//  ViewController.swift
//  InfiniteScroll
//
//  Created by Николай Петров on 19.04.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    private let apiCaller = APICaller()

    private var tabelView: UITableView = {
        let tabelView = UITableView(frame: .zero, style: .grouped)
        tabelView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tabelView
    }()
    
    private var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabelView.frame = view.bounds
        apiCaller.fetcData(pagination: false) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.data.append(contentsOf: data)
                DispatchQueue.main.async {
                    self.tabelView.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = data[indexPath.row]
        
        
        cell.contentConfiguration = content
        return cell
    }
}

