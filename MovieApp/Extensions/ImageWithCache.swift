//
//  UIImageVİewExtensions.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 23.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import SwiftUI
struct ImageWithCache<ImageView: View>: View {
    private let url: URL
    private let imageView: (Image) -> ImageView
    @State var image : UIImage?
    @ObservedObject private var loader: ImageLoaderViewModel = ImageLoaderViewModel()
    
    var body: some View {
        self.imageView(Image(uiImage: self.image ?? UIImage.init()))
        .onAppear {
            self.loader.fetchImage(atURL: self.url,completionImage: { image in
                self.image = image
            })
        }
        
    }
    
    init(url: URL,@ViewBuilder imageView: @escaping (Image) -> ImageView) {
        self.url = url
        self.imageView = imageView
    }
}
