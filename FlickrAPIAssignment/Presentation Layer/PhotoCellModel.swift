//
//  PhotoCellModel.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 03/08/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

class PhotoCellModel {
    let farmID: Int
    let serverID, id, secret: String
   
    required init(with photo: Photo) {
        self.farmID = photo.farm
        self.id = photo.id
        self.secret = photo.secret
        self.serverID = photo.server
    }
}
