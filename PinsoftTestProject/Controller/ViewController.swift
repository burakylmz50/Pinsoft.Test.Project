//
//  ViewController.swift
//  PinsoftTestProject
//
//  Created by Burak Yılmaz on 24.06.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController, HomePageViewModelDelegate,UISearchBarDelegate {
    
    var queue = OperationQueue()
    
    func homePagerequestCompleted() {
        removeSpinner()
    }
    var movieDetail = MovieDetailVC()
    fileprivate let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    func setCollectionView(){
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.snp.makeConstraints { (make) -> Void in
            collectionView.layer.cornerRadius = 10.0
            make.top.equalTo(view).offset(150)
            make.bottom.leading.trailing.equalTo(view).offset(0)
        }
    }
    
    let errFindMovie : UILabel = {
        let errFindMovie = UILabel()
        return errFindMovie
    }()
    
    private func  errFindMovieContraints(){
        self.view.addSubview(errFindMovie)
        errFindMovie.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    let searchBar:UISearchBar = UISearchBar()
    private func setSearchBar(){
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(50)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(50)
        }
        searchBar.backgroundColor = UIColor.red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
        setSearchBar()
        errFindMovieContraints()
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.keyboardType = UIKeyboardType.alphabet
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .words
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homePageViewModel.MyArray.removeAll()
        showSpinner(onView: view)
        queue.addOperation { () -> Void in
            self.homePageViewModel.getData(a: searchText, completionHandler: {
                response in
                self.homePageViewModel.MyArray = response
                self.removeSpinner()
            })
            OperationQueue.main.addOperation({
                // UI_Update()
                self.collectionView.reloadData()
            })
        }
    }
    lazy var homePageViewModel: HomePageViewModel = {
        let homePageVM = HomePageViewModel()
        homePageVM.delegate = self
        return homePageVM
    }()
    
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePageViewModel.MyArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.posterImage.image = nil
        
        if(homePageViewModel.MyArray[0].response == "True"){
            errFindMovie.isHidden = true
            collectionView.isHidden = false
            let a = homePageViewModel.MyArray[indexPath.row].poster
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0) {
                    cell.posterImage.alpha = 1
                }
                
                if(a != "N/A"){
                    cell.posterImage.loadImageAsync(with: a!, completed: {})
                }
                else{
                    cell.posterImageBack.text = "NO IMAGE"
                    cell.isUserInteractionEnabled = false
                }
                cell.isUserInteractionEnabled = true
            }
        }
        else{
            print("sonuç bulunamadı")
            collectionView.isHidden = true
            errFindMovie.isHidden = false
            errFindMovie.text = "Sonuç Bulunamadı"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 350, height: 263)
    }
    
    //TODO: Cell'lerin kenarlara olan uzaklıkları
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieDetail.movieDetailArray.removeAll()
        movieDetail.movieDetailArray.append(homePageViewModel.MyArray[indexPath.item])
        Analytics.logEvent("Variable", parameters: ["Title": homePageViewModel.MyArray[indexPath.item].title!, "Year": homePageViewModel.MyArray[indexPath.item].year!, "Rated": homePageViewModel.MyArray[indexPath.item].rated!, "Released": homePageViewModel.MyArray[indexPath.item].released!, "Runtime": homePageViewModel.MyArray[indexPath.item].runtime!, "Director": homePageViewModel.MyArray[indexPath.item].director!, "Writer": homePageViewModel.MyArray[indexPath.item].writer!, "Language": homePageViewModel.MyArray[indexPath.item].language!, "imdbRating": homePageViewModel.MyArray[indexPath.item].imdbRating!])
        self.present(movieDetail, animated: true, completion: nil)
    }
    
}
