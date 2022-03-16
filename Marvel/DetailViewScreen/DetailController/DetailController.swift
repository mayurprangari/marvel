//
//  DetailController.swift
//  Marvel
//
//  Created by Mayur Rangari on 10/03/22.
//

import UIKit

class DetailController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTilte: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let flowLayout = ZoomAndSnapFlowLayout()
    var result: Result?
    let child = SpinnerViewController()
    var comicsViewModel = ComicsViewModel()
    var comicsData : ComicsModel?
    var comicsResult  : [Results]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = UIColor.systemBlue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Setup Collection View
        collectionView.register(UINib(nibName: "MarvelCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MarvelCollectionCell")
        let cellSize = CGSize(width:210 , height:380)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        retrieveDataFromApi()
        setupData()
    }
    
    //MARK: - Setup Data
    func setupData(){
        let imageUrl : String = "\(result!.thumbnail!.path ?? "")/\(result!.urls![0].type ?? .detail).\(result!.thumbnail!.thumbnailExtension ?? .jpg)"
        let url = URL(string: imageUrl)
        if let data = try? Data(contentsOf: url!){
            imageView.image = UIImage(data: data)
        }else{
            imageView.image = UIImage(named: "imgNoImage")
        }
        lblTilte?.text = result?.name ?? ""
        lblDescription.text = result?.resultDescription ?? ""
    }
}
extension DetailController: UICollectionViewDelegate, UICollectionViewDataSource{
    //MARK: - CollectionView Datasource & Delegate method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicsResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MarvelCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarvelCollectionCell", for: indexPath) as! MarvelCollectionCell
        let model = comicsResult?[indexPath.row]
        cell.lblTitle.text = model?.title
        cell.lblIssueNo.text = "Issue number \(model?.issueNumber ?? 0)"
        let imageUrl : String = "\(model?.thumbnail?.path ?? "")/portrait_uncanny\(model?.thumbnail?.thumbnailExtension ?? ".jpg")"
        let url = URL(string: imageUrl)
        if let data = try? Data(contentsOf: url!){
            cell.imgView.image = UIImage(data: data)
        }else{
            cell.imgView.image = UIImage(named: "imgNoImage")
        }
        return cell
        
    }
    
    //MARK: - For Cell Highlight
     func collectionView(_ collectionView: UICollectionView,
                                willDisplay cell: UICollectionViewCell,
                                forItemAt indexPath: IndexPath) {
       cell.alpha = 0
       UIView.animate(withDuration: 0.8) {
           cell.alpha = 1
       }
   }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? MarvelCollectionCell {
                cell.imgView.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = .red
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? MarvelCollectionCell {
                cell.imgView.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }
    }
    
    
}

private extension DetailController{
    
    // MARK: - Api Call
    func retrieveDataFromApi() {
        self.loadSpinnerView()
        comicsViewModel.getDataFromApi(apiUrl: "\(Constants.baseUrl)\(Constants.charactersAPI)/\(result!.id!)/comics?ts=\(Constants.ts)&apikey=\(Constants.apiKey)&hash=\(Constants.hashKey)") { response, status in
            if status{
                self.comicsData = response
                self.comicsResult = self.comicsData?.data?.results
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationItem.title = "Details"
                    self.collectionView.reloadData()
                    self.removeSpinnerView()
                }
            }else{
                app_del.showToast(message: Constants.messageBody)
                self.removeSpinnerView()
            }
        }
    }
}

