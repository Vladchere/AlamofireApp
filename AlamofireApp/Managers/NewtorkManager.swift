//
//  NewtorkManager.swift
//  AlamofireApp
//
//  Created by Vladislav on 23.06.2020.
//  Copyright © 2020 Vladislav Cheremisov. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchSearchPhoto(searchTerm: String,
                          page: Int,
                          perPage: Int,
                          completion: @escaping ([URLS]) -> Void) {
        var url = "https://api.unsplash.com/search/photos"
        url += "?query=\(searchTerm)"
        url += "&page=\(String(page))"
        url += "&per_page=\(String(perPage))"
        
        let headers: HTTPHeaders = [
            "Authorization":
            "Client-ID 8J_Nydt1h5gF5ANS5x1eM-VBGTnRk4xFCgCdIU4aGYs"
        ]
        
        AF.request(url, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let jsonData = value as? [String: Any] else { return }
                    
                    guard let results = jsonData["results"] as? [[String: Any]] else { return }
                    
                    var urlData: [[String: Any]] = []
                    var urls = [URLS]()
                    
                    for dictResult in results {
                        urlData.append(dictResult["urls"] as! [String : Any])
                    }
                    
                    for url in urlData {
                        let urlModel = URLS(raw: url["raw"] as? String,
                                            full: url["full"] as? String,
                                            regular: url["regular"] as? String,
                                            small: url["small"] as? String,
                                            thumb: url["thumb"] as? String)
                        urls.append(urlModel)
                    }
                    completion(urls)
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func fetchListPhotos(page: Int,
                         perPage: Int,
                         orderBy: OrderBy,
                         with completion: @escaping ([URLS]) -> Void) {
        
        var url = "https://api.unsplash.com/photos"
        url += "?page=\(String(page))"
        url += "&per_page=\(String(perPage))"
        url += "&order_by=\(orderBy)"
        
        let headers: HTTPHeaders = [
            "Authorization":
            "Client-ID 8J_Nydt1h5gF5ANS5x1eM-VBGTnRk4xFCgCdIU4aGYs"
        ]
        
        AF.request(url, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                    
                case .success(let value):
                    guard let jsonData = value as? [[String: Any]] else { return }
                    var urlData: [[String: Any]] = []
                    var urls = [URLS]()
                    
                    for dictResult in jsonData {
                        urlData.append(dictResult["urls"] as! [String : Any])
                    }
                    
                    for url in urlData {
                        let urlModel = URLS(raw: url["raw"] as? String,
                                            full: url["full"] as? String,
                                            regular: url["regular"] as? String,
                                            small: url["small"] as? String,
                                            thumb: url["thumb"] as? String)
                        urls.append(urlModel)
                    }
                    
                    completion(urls)
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
}
