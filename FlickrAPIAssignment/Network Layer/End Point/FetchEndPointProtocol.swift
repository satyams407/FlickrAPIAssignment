//
//  FetchEndPointProtocol.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 13/09/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

protocol FetchEndPointProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
}
