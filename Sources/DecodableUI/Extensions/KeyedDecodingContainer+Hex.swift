//
//  KeyedDecodingContainer+Hex.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 29.04.2022.
//

import Foundation
import SwiftUI

public extension KeyedDecodingContainer {

    func decodeColorFromHexString(forKey key: Key) throws -> Color {
        let hexString = try decode(String.self, forKey: key)
        return Color.init(hex: hexString)
    }

}
