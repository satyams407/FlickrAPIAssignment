//
//  HTTPTask.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 13/09/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParamters: Parameters?, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParamters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
}
