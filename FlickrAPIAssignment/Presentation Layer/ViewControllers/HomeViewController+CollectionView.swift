//
//  HomeViewController+CollectionView.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 26/05/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CellIdentifiers.photoCellectionCell.rawValue, for: indexPath)
        if let cell = collectionCell as? PhotoCollectionViewCell {
            cell.configureCell(with: photoDataSource[indexPath.row])
        }
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 30.0
        let availbleWidth = collectionView.frame.width - padding
        let height = (availbleWidth/itemsPerRow)
        return CGSize.init(width: availbleWidth/itemsPerRow, height: height)
    }
}
