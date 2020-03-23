//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 22.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import SwiftUI
struct MovieDetailView: View {
    @EnvironmentObject var moviesViewModel : MoviesViewModel
    @Binding var filteredList : [Movie]
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var movie : Movie
    var index : Int
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                ImageWithCache(url: URL(string: DataExecuter.Movie.moviePoster(width: 400, posterPath: movie.posterPath ?? "").builder().url) ?? URL.init(fileURLWithPath: "")) { (image) in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height:UIScreen.main.bounds.width)
                        .clipped()
                }
              
                    
                
                Text(movie.overview ?? "")
                    .multilineTextAlignment(.leading)
                    .padding([.leading,.trailing], 16)
                Text("Vote Count : \(movie.voteCount ?? 0)")
                    .fontWeight(.semibold)
                    .padding([.leading,.trailing], 16)
                
                Spacer()
            }
            
        }
        .navigationBarTitle(Text(movie.title ?? ""), displayMode: .inline)
        .navigationBarItems(trailing: VStack{
            Button(action: {
                self.filteredList[self.index].isFavorite.toggle()
                Helpers.setFavorite(id: self.movie.id, isFavorite: self.movie.isFavorite)
                
            }) {
                HStack{
                    Spacer()
                    Image.init(systemName: (self.movie.isFavorite ) ? "star.slash.fill" : "star" )
                }
            }
            .frame(width:64,height:64)
        })
    }
    func getIndex(by id:Int?) -> Int?{
        return self.moviesViewModel.movieResponse.results.firstIndex(where: { $0.id == id})
    }
}
