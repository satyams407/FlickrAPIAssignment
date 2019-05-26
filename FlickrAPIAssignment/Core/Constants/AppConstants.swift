//
//  AppConstants.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 26/05/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

struct AppConstants {
    enum HTTPMethod : String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
    
    enum CellIdentifiers: String {
        case photoCellectionCell = "PhotoCollectionViewCell"
    }
    
    enum StoryBoards: String {
        case main = "Main"
    }
}
