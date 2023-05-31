//
//  Bundle+Extension.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/31/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import Foundation

extension Bundle {
    static func getBundleInfo(for key: String) -> String {
        let info: String = Bundle.main.infoDictionary![key] as? String ?? ""
        return info
    }
}

