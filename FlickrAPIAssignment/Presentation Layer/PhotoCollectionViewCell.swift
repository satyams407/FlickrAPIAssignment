//
//  PhotoCollectionViewCell.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 03/08/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

typealias URLParamters = (farmID: Int, serverID: String, id: String, secret: String)

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    var imageURL: URL!
    var indexPath: IndexPath!
    
    var rowLabel: UILabel = {
        let row = UILabel()
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()
    

    func configureCell(with model: PhotoCellModel) {
        let imageUrlString = buildImageUrl((model.farmID, model.serverID, model.id, model.secret))
        //photoImageView?.downloadFromLink(link: imageUrlString, contentMode: .scaleToFill)
        
        imageURL = URL(string: imageUrlString)!
        photoImageView?.image = UIImage(named: "placeHolderImage.png")
        ImageDownloaderAsync.sharedInstance.downLoadImageFromLink(urlLink: imageURL, indexPath: indexPath) { [weak self] (image, url, indexPath, error)  in
            guard let strongSelf = self else { return }
            if let indexPath = indexPath, indexPath == strongSelf.indexPath {
                DispatchQueue.main.async {
                    strongSelf.photoImageView.image = image
                }
            }
        }
    }
    
    func setRowLabel() {
        self.addSubview(rowLabel)
        rowLabel.text = "\(self.indexPath.row)"
        rowLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        rowLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rowLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
    }
    
    private func buildImageUrl(_ idTuple: URLParamters) -> String {
        return "https://farm\(idTuple.0).staticflickr.com/\(idTuple.1)/\(idTuple.2)_\(idTuple.3).jpg"
    }
}
