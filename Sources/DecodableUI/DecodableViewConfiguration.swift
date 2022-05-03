//
//  DecodableViewConfiguration.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 28.04.2022.
//

import Foundation

public struct DecodableViewConfiguration: Decodable {

    let type: String
    let nestedDecoder: Decoder?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(String.self, forKey: .type)
        nestedDecoder = try? container.superDecoder(forKey: .parameters)
    }

}

private extension DecodableViewConfiguration {

    enum CodingKeys: String, CodingKey {
        case type
        case parameters
    }

}
