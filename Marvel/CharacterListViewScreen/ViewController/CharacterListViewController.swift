//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Mayur Rangari on 10/03/22.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    @IBOutlet private weak var tblView: UITableView!
    
    private var listViewModel = CharacterListViewModel()
    private var marvelList: CharacterListModel?
    private var result: [Result]?
    private var lastContentOffset: CGFloat = 0
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "CharacterListCell", bundle: nil), forCellReuseIdentifier: "CharacterListCell")
        self.retrieveDataFromApi()
        pullToRefreshSetting()
    }
    
    //MARK:- Pull to Refresh Actions
    func pullToRefreshSetting(){
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tblView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: Any) {
        self.retrieveDataFromApi()
    }
}

//MARK: - Tavleview Datasource & Delegate method
extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterListCell", for: indexPath) as! CharacterListCell
        let result = result?[indexPath.row]
        cell.setupData(result: result!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.result = result![indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

private extension CharacterListViewController{
    
    // MARK: - Api Call
    func retrieveDataFromApi() {
        app_del.showSoftActivityIndicator(controller: self)
        listViewModel.getDataFromApi(apiUrl: Constants.charactersAPI) {[weak self] response, status in
            if status {
                self?.marvelList = response
                if self?.marvelList != nil{
                    self?.result = self?.marvelList?.data?.results
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
                        self?.navigationItem.title = "Characters"
                        self?.tblView.reloadData()
                        app_del.hideActivityIndicator()
                        self?.refreshControl.endRefreshing()
                    }
                }else{
                    DispatchQueue.main.async {                        app_del.showToast(message: Constants.messageBody)
                    }
                    app_del.hideActivityIndicator()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
}

