//
//  AsyncImagePhase.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 03.05.2022.
//

import SwiftUI

public enum AsyncImagePhase {

    case loading
    case image(Image)
    case error(Error)

}
