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
        if let searchWord = searchText.text {
            fetchURL(keyword: searchWord)
        }
    }
    
    func fetchURL(keyword: String) {
        guard let keywordEncode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        guard let requestURL = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keywordEncode)&max=10&order=r") else {
            return
        }
        
        let request = URLRequest(url: requestURL)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            session.finishTasksAndInvalidate()
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                print(json)
            } catch {
                print("エラーが出ました")
            }
        })
        task.resume()
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

extension ViewController {
    struct ItemJson: Codable {
        let name: String?
        let maker: String?
        let url: URL?
        let image: URL?
    }
    
    struct ResultJson: Codable {
        let item: [ItemJson]?
    }
}

