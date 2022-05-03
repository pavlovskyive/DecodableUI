//
//  DecodableViewsProvider.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 28.04.2022.
//

import SwiftUI

public protocol DecodableViewResolver {

    func resolve(from configuration: DecodableViewConfiguration) -> DecodableView?

}

public class DecodableViewsService {

    private var viewsRegistry = [String: DecodableView.Type]()

    public init(viewTypes: [DecodableView.Type] = []) {
        register(viewTypes)
    }

    public func register(_ viewTypes: [DecodableView.Type]) {
        for type in viewTypes {
            viewsRegistry["\(type)"] = type
        }
    }

}

extension DecodableViewsService: DecodableViewResolver {

    public func resolve(
        from configuration: DecodableViewConfiguration
    ) -> DecodableView? {
        guard let type = viewsRegistry[configuration.type],
              let view = type.init(from: configuration.nestedDecoder, viewResolver: self) else {
                  return nil
              }

        return view
    }

}
