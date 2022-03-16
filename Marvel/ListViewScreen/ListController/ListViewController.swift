//
//  ListViewController.swift
//  Marvel
//
//  Created by Mayur Rangari on 10/03/22.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    let child = SpinnerViewController()
    var listViewModel = ListViewModel()
    var marvelList: ListModel?
    var result: [Result]?
    private var lastContentOffset: CGFloat = 0
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "MarvelListCell", bundle: nil), forCellReuseIdentifier: "MarvelListCell")
        self.retrieveDataFromApi()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tblView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: Any) {
        self.retrieveDataFromApi()
    }
}

//MARK: - Tavleview Datasource & Delegate method
extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelListCell", for: indexPath) as! MarvelListCell
        let result = result?[indexPath.row]
        let imageUrl : String = "\(result!.thumbnail!.path ?? "")/\(result!.urls![0].type ?? .detail).\(result!.thumbnail!.thumbnailExtension ?? .jpg)"
        let url = URL(string: imageUrl)
        if let data = try? Data(contentsOf: url!){
            cell.imgView.image = UIImage(data: data)
        }else{
            cell.imgView.image = UIImage(named: "imgNoImage")
        }
        cell.lblTitle?.text = result?.name ?? ""
        cell.lblDescription.text = result?.resultDescription ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MAIN_STORYBOARD.instantiateViewController(withIdentifier: "DetailController") as! DetailController
        detailVC.result = result![indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

private extension ListViewController{
    
    // MARK: - Api Call
    func retrieveDataFromApi() {
        self.loadSpinnerView()
        listViewModel.getDataFromApi(apiUrl: "\(Constants.baseUrl)\(Constants.charactersAPI)?ts=\(Constants.ts)&apikey=\(Constants.apiKey)&hash=\(Constants.hashKey)") { response, status in
            if status {
                self.marvelList = response
                self.result = self.marvelList?.data?.results
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationItem.title = "Characters"
                    self.tblView.reloadData()
                    self.removeSpinnerView()
                    self.refreshControl.endRefreshing()
                }
            }else{
                app_del.showToast(message: Constants.messageBody)
                self.removeSpinnerView()
                self.refreshControl.endRefreshing()
            }
        }
    }
}
