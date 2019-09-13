//
//  ParameterEncoding.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 13/09/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
