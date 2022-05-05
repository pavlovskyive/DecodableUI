//
//  ImageLoader.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 03.05.2022.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {

    @Published var phase: AsyncImagePhase = .loading
    private let url: URL

    private var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancel()
    }

}

extension ImageLoader {

    #if os(iOS)
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .tryMap {
                guard let image = $0 else {
                    throw LoaderError.invalidData
                }
                return image
            }
            .map {
                Image(uiImage: $0)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.phase = .error(error)
                default:
                    return
                }
            } receiveValue: { [weak self] in
                self?.phase = .image($0)
            }
    }
    #endif
    
    #if os(macOS)
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { NSImage(data: $0.data) }
            .tryMap {
                guard let image = $0 else {
                    throw LoaderError.invalidData
                }
                return image
            }
            .map {
                Image(nsImage: $0)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.phase = .error(error)
                default:
                    return
                }
            } receiveValue: { [weak self] in
                self?.phase = .image($0)
            }
    }
    #endif

    func cancel() {
        cancellable?.cancel()
    }

}

private extension ImageLoader {

    enum LoaderError: Error {
        case invalidData
    }

}
