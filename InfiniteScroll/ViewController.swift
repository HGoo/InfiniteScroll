//
//  ViewController.swift
//  InfiniteScroll
//
//  Created by Николай Петров on 19.04.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
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
        view.addSubview(tabelView)
        tabelView.dataSource = self
        tabelView.delegate = self
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = data[indexPath.row]
        cell.contentConfiguration = content

        return cell
    }
    
    private func createSpinerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spiner = UIActivityIndicatorView()
        spiner.center = footerView.center
        footerView.addSubview(spiner)
        spiner.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tabelView.contentSize.height - 100 - scrollView.frame.size.height) {
            //fetch more data
            guard !apiCaller.isPaginating else { return }
            
            self.tabelView.tableFooterView = createSpinerFooter()
            
            apiCaller.fetcData(pagination: true) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.tabelView.tableFooterView = nil
                }
                
                switch result {
                case .success(let moreData):
                    self.data.append(contentsOf: moreData)
                    DispatchQueue.main.async {
                        self.tabelView.reloadData()
                    }
                case .failure(_):
                    break
                }
                
            
            }
            print("fetch more data")
        }
    }
}

