//
//  DecodableView.swift
//  Thesis
//
//  Created by Vsevolod Pavlovskyi on 28.04.2022.
//

import SwiftUI

public protocol DecodableView {

    var anyView: AnyView { get }

    init?(from decoder: Decoder?, viewResolver: DecodableViewResolver)

}
