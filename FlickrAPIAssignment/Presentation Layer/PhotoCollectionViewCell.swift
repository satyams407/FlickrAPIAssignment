//
//  PhotoCollectionViewCell.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 26/05/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

typealias URLParamters = (farmID: Int, serverID: String, id: String, secret: String)

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView?
    
    func configureCell(with model: PhotoCellModel) {
        let imageUrlString = buildImageUrl((model.farmID, model.serverID, model.id, model.secret))
        photoImageView?.downloadFromLink(link: imageUrlString, contentMode: .scaleToFill)
    }
    
    private func buildImageUrl(_ idTuple: URLParamters) -> String {
        return "https://farm\(idTuple.0).staticflickr.com/\(idTuple.1)/\(idTuple.2)_\(idTuple.3).jpg"
    }
   
}
