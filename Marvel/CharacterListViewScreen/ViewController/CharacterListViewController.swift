//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Mayur Rangari on 10/03/22.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    @IBOutlet private weak var tblView: UITableView!
    
    let child = SpinnerViewController()
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
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
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
            self.loadSpinnerView()
            listViewModel.getDataFromApi(apiUrl: "\(Constants.baseUrl)\(Constants.charactersAPI)?ts=\(Constants.ts)&apikey=\(Constants.apiKey)&hash=\(Constants.hashKey)") {[weak self] response, status in
                if status {
                    self?.marvelList = response
                    if self?.marvelList != nil{
                    self?.result = self?.marvelList?.data?.results
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
                        self?.navigationItem.title = "Characters"
                        self?.tblView.reloadData()
                        self?.removeSpinnerView()
                        self?.refreshControl.endRefreshing()
                    }
                }else{
                    app_del.showToast(message: Constants.messageBody)
                    self?.removeSpinnerView()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
}

