//
//  Int+Extension.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/31/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import Foundation

extension Int {
    func convertToHoursAndMinutes() -> (hours: Int, minutes: Int) {
        let hours = self / 60
        let remainingMinutes = self % 60
        
        return (hours, remainingMinutes)
    }
}
