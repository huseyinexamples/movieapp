//
//  ImageLoaderViewModel.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 23.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import SwiftUI
import Combine
class ImageLoaderViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    
    static let cache = NSCache<NSURL, UIImage>()

    func fetchImage(atURL url: URL,completionImage : @escaping (UIImage?)->Void) {
        
        if let image = ImageLoaderViewModel.cache.object(forKey: url as NSURL){
            completionImage(image)
            return
        }
        
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        cancellable = urlSession.dataTaskPublisher(for: urlRequest)
            .map { UIImage(data: $0.data) }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
            }) { image in
                if let image = image {
                    completionImage(image)
                    ImageLoaderViewModel.cache.setObject(image, forKey: url as NSURL)
                }
        }
    }
}
