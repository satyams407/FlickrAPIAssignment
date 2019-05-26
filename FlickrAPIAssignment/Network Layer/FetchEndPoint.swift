//
//  FetchEndPoint.swift
//  FlickrAPIAssignment
//
//  Created by Satyam Sehgal on 26/05/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

// Can have mutilple cases for fetch request for different api calls
enum FetchEndPoint {
    case fetchPhotos(searchText: String, pageNumber: Int)
}

extension FetchEndPoint {
    var baseURL: URL {
        guard let url = URL(string: AppURLConstants.basefetchURL) else {
            fatalError("url can't be made right now")
        }
        return url
    }
    
    var httpMethod: AppConstants.HTTPMethod {
        return .get
    }
  //https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=kittens
    var urlParameters: Parameters {
        switch self {
        case .fetchPhotos(let searchText, let pageNumber):
            return [
                KeyConstants.FetchPhotos.method.rawValue : "flickr.photos.search",
                KeyConstants.FetchPhotos.api_key.rawValue: "3e7cc266ae2b0e0d78e279ce8e361736",
                KeyConstants.FetchPhotos.nojsoncallback.rawValue: 1,
                KeyConstants.FetchPhotos.format.rawValue: "json",
                KeyConstants.FetchPhotos.per_page.rawValue: AppContext.pageSize,
                KeyConstants.FetchPhotos.safe_search.rawValue: 1,
                KeyConstants.FetchPhotos.sort.rawValue : "interestingness-desc",
                KeyConstants.FetchPhotos.page.rawValue: pageNumber,
                KeyConstants.FetchPhotos.text.rawValue: searchText
            ]
        }
    }
    
    func encode(request: inout URLRequest, urlParameters: Parameters?) {
        guard let urlParameters = urlParameters, let url = request.url  else { return }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in urlParameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
    }
}
