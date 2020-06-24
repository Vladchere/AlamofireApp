//
//  Result.swift
//  AlamofireApp
//
//  Created by Vladislav on 23.06.2020.
//  Copyright © 2020 Vladislav Cheremisov. All rights reserved.
//

import Foundation

struct URLS: Decodable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
}

enum OrderBy: String, CaseIterable {
    case latest = "latest"
    case oldest = "oldest"
    case popular = "popular"
}

