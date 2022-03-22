//
//  DetailViewController.swift
//  Marvel
//
//  Created by Mayur Rangari on 10/03/22.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var lblDescription: UILabel!
    @IBOutlet private weak var lblTilte: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let flowLayout = ZoomAndSnapFlowLayout()
    var result: Result?
    private var comicsViewModel = ComicsViewModel()
    private var comicsData : ComicsModel?
    private var comicsResult  : [Results]?
    
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
        imageView.sd_setImage(with: URL(string: imageUrl),placeholderImage: UIImage(named: "imgNoImage"))
        lblTilte?.text = result?.name ?? ""
        lblDescription.text = result?.resultDescription ?? ""
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK: - CollectionView Datasource & Delegate method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicsResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MarvelCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarvelCollectionCell", for: indexPath) as! MarvelCollectionCell
        let model = comicsResult?[indexPath.row]
        cell.setupData(model: model)
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

private extension DetailViewController{
    
    // MARK: - Api Call
    func retrieveDataFromApi() {
        app_del.showSoftActivityIndicator(controller: self)
        comicsViewModel.getDataFromApi(apiUrl: "\(Constants.comicsAPI1)\(result!.id!)\(Constants.comicsAPI2)") { [weak self] response, status in
            if status{
                self?.comicsData = response
                self?.comicsResult = self?.comicsData?.data?.results
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
                    self?.navigationItem.title = "Details"
                    self?.collectionView.reloadData()
                    app_del.hideActivityIndicator()
                }
            }else{
                DispatchQueue.main.async {                        app_del.showToast(message: Constants.messageBody)
                }
                app_del.hideActivityIndicator()
            }
        }
    }
}

