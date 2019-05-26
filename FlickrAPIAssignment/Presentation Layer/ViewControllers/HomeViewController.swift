//
//  HomeViewController.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 26/05/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var footerActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var photoDataSource = [PhotoCellModel]()
    var debounceTimer: Timer?
    let fetchPhotoService = FetchPhotoService()
    var searchText: String = StringConstants.mountainKeyword // intialise for first result
    let itemsPerRow: CGFloat = 3.0
    var currentPageNumber = 1
    var fetchingMorePhotos = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetup()
        fetchPhotos()
    }
    
    private func screenSetup() {
        // MARK: Activity Indicator
        activityIndicatorView.startAnimating()
        activityIndicatorView.tintColor = .black
        activityIndicatorView.isHidden = false
        footerActivityIndicatorView.isHidden = true
        
        resultsCollectionView.isHidden = true
        searchBar.isHidden = true
        searchButton.isHidden = false
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        searchBar.isHidden = false
        searchButton.isHidden = true
        searchBar.showsCancelButton = true
        headingLabel.isHidden = true
        searchBar.placeholder = StringConstants.searchBarPlaceHolder
    }
    
    private func fetchPhotos() {
        updateUIWhileFetching()
        fetchPhotoService.fetchPhotos(with: .fetchPhotos(searchText: searchText, pageNumber: currentPageNumber), completionHandler: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .failure(let error):
                Utility.showAlert(message: error.errorMessage, onController: strongSelf)
            case .success(let photoResponseModel):
                for photoObject in photoResponseModel.photos.photo {
                    let cellModel = PhotoCellModel.init(with: photoObject)
                    strongSelf.photoDataSource.append(cellModel)
                }
            }
            DispatchQueue.main.async {
                strongSelf.resultsCollectionView.isHidden = false
                strongSelf.activityIndicatorView.isHidden = true
                strongSelf.resultsCollectionView.reloadData()
                strongSelf.activityIndicatorView.stopAnimating()
            }
        })
    }
    
    private func updateUIWhileFetching() {
        activityIndicatorView.startAnimating()
        resultsCollectionView.isHidden = true
        activityIndicatorView.isHidden = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offSetY > contentHeight - scrollView.frame.height*2 {
            if !fetchingMorePhotos  {
                footerActivityIndicatorView.isHidden = false
                footerActivityIndicatorView.startAnimating()
                currentPageNumber = currentPageNumber + 1
                beginMoreFetching()
            }
        }
    }
    
    private func beginMoreFetching() {
        fetchingMorePhotos = true
        fetchPhotoService.fetchPhotos(with: .fetchPhotos(searchText: searchText, pageNumber: currentPageNumber), completionHandler: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let photoResponseModel):
                for photoObject in photoResponseModel.photos.photo {
                    let cellModel = PhotoCellModel.init(with: photoObject)
                    strongSelf.photoDataSource.append(cellModel)
                }
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                strongSelf.resultsCollectionView.reloadData()
                strongSelf.footerActivityIndicatorView.stopAnimating()
                strongSelf.footerActivityIndicatorView.isHidden = true
                strongSelf.fetchingMorePhotos = false
            }
        })
    }
}

// MARK: SearchBar Delegate Methods
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.count > 2 {
            if let timer = debounceTimer {
                timer.invalidate()    // when search button is tapped multiple times
            }
            // start the timer
            debounceTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateSearchResult(_:)), userInfo: text, repeats: false)
        }
    }
    
    @objc func updateSearchResult(_ timer: Timer) {
        if let searchText = timer.userInfo as? String {
            photoDataSource.removeAll()
            self.searchText = searchText
            fetchPhotos()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        searchBar.isHidden = true
        searchButton.isHidden = false
        headingLabel.isHidden = false
        scrollToTop()
    }
    
    func scrollToTop() {
        UIView.animate(withDuration: 0.3, animations: {
        }, completion: { (_) in
            self.resultsCollectionView.contentOffset = CGPoint.init(x: 0, y: 0)
        })
    }
}
