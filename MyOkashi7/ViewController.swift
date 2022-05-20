//
//  ViewController.swift
//  MyOkashi7
//
//  Created by 澤田世那 on 2022/05/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private var itemList: [(name: String, maker: String, link: URL, image: URL)] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchText: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemTableViewCell.nib, forCellReuseIdentifier: ItemTableViewCell.identifier)
        searchText.delegate = self
        searchText.placeholder = "お菓子の名前を入力してください"
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath)
        // swiftlint:disable:next force_cast
        as! ItemTableViewCell
        cell.configure(item: itemList[indexPath.row])
        
        return cell
    }

}

