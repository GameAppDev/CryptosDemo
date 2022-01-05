//
// View.swift
// ViperExample
//
// Created on 19.12.2021.
// Copyright (c)  APPWOX. All rights reserved.
//
//
//

/*
 Talks with: Presenter
 Class, Protocol
 ViewController
 */
import Foundation
import UIKit

protocol AnyView {
    var presenter:AnyPresenter? {get set}
    
    func update(with cryptos:[CryptoResponse])
    func update(with error:String)
}

class CryptoViewController: UIViewController, AnyView {
    
    var presenter: AnyPresenter?
    
    var cryptos:[CryptoResponse] = []
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading..."
        label.font = UIFont.systemFont(ofSize: CGFloat(30))
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellow
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: (view.frame.width / 2 - 100), y: (view.frame.height / 2 - 25), width: 200, height: 50)
    }
    
    func update(with cryptos: [CryptoResponse]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
            self.tableView.isHidden = true
        }
    }
}

extension CryptoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor.yellow
        
        return cell
    }
}
