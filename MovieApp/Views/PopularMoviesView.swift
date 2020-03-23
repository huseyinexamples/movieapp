//
//  ContentView.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 22.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import SwiftUI
struct PopularMoviesView: View {
    @EnvironmentObject var moviesViewModel : MoviesViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var page = 1
    @State var isGrid = false
    @State var columns = 1
    @State var searchText :String = ""
    @State var filteredList : [Movie] = []
    @State var numItems : Int = 0
    var body: some View {
        NavigationView{
            Group{
                GeometryReader { geometry in
                    ScrollView(Axis.Set.vertical) {
                        VStack{
                            SearchBar(text: self.$searchText,textChanged: {
                                if self.searchText == ""{
                                    self.numItems = self.moviesViewModel.movieResponse.results.count
                                    self.filteredList = self.moviesViewModel.movieResponse.results
                                }
                                else{
                                    self.numItems = self.moviesViewModel.movieResponse.results.filter({ ($0.title ?? "").lowercased().contains(self.searchText.lowercased()) }).count
                                    self.filteredList = self.moviesViewModel.movieResponse.results.filter({ ($0.title ?? "").lowercased().contains(self.searchText.lowercased()) })
                                }
                                
                            })
                                .padding([.leading,.trailing],16)
                            MovieGrid(page: self.$page, isGrid: self.$isGrid, columns: self.$columns, filteredList: self.$filteredList, geometry: geometry,numItems:self.$numItems)
                                .id(UUID())
                            if self.searchText == ""{
                                Button(action: {
                                    self.page += 1
                                    self.moviesViewModel.getPopularMovies(page: self.page){
                                        self.numItems = self.moviesViewModel.movieResponse.results.count
                                        self.filteredList = self.moviesViewModel.movieResponse.results
                                    }
                                }) {
                                    VStack(alignment:.center){
                                        
                                        Text("Load More")
                                            .fontWeight(.semibold)
                                            .underline()
                                        Spacer()
                                            .frame(height:0)
                                    }
                                }
                            }
                        }
                        
                        
                    }
                }
                
                
                //                if false{
                //                    List{
                //                        SearchBar(text: self.$searchText)
                //                        ForEach(0..<self.moviesViewModel.movieResponse.results.count, id: \.self){ (index) in
                //                            Group{
                //                                if (self.moviesViewModel.movieResponse.results[index].title ?? "").contains(self.searchText) || self.searchText == ""{
                //                                    NavigationLink(destination:MovieDetailView(movie:self.$moviesViewModel.movieResponse.results[index])){
                //                                        MovieRow(movie: self.moviesViewModel.movieResponse.results[index],isGrid:false)
                //                                    }
                //                                    .buttonStyle(PlainButtonStyle())
                //                                }
                //                            }
                //
                //
                //                        }
                //                        if searchText == ""{
                //                            Button(action: {
                //                                self.page += 1
                //                                self.moviesViewModel.getPopularMovies(page: self.page)
                //                            }) {
                //                                VStack(alignment:.center){
                //
                //                                    Text("Load More")
                //                                        .fontWeight(.semibold)
                //                                        .underline()
                //                                    Spacer()
                //                                        .frame(height:0)
                //                                }
                //                            }
                //                        }
                //
                //                    }
                //                    .transition(.opacity)
                //
                //                }
                //                else{
                //
                //
                //
                //                    }
                
                //                    ScrollView(showsIndicators:false){
                //                        SearchBar(text: self.$searchText)
                //                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                //                        ForEach(0..<((self.moviesViewModel.movieResponse.results.filter({ ($0.title ?? "").contains(self.searchText)})).count / 2) , id: \.self){ (index) in
                //                                    HStack{
                //                                        Group{
                //                                            NavigationLink(destination:MovieDetailView(movie:self.$moviesViewModel.movieResponse.results[self.getIndicies(index: index,id: ).0])){
                //                                                MovieRow(movie: (self.moviesViewModel.movieResponse.results)[self.getIndicies(index: index).0],isGrid:true)
                //                                            }
                //                                            .buttonStyle(PlainButtonStyle())
                //                                            if index < self.moviesViewModel.movieResponse.results .count / 2{
                //                                                NavigationLink(destination:MovieDetailView(movie:self.$moviesViewModel.movieResponse.results[self.getIndicies(index: index).1])){
                //                                                    MovieRow(movie: (self.moviesViewModel.movieResponse.results)[self.getIndicies(index: index).1],isGrid:true)
                //                                                }
                //                                                .buttonStyle(PlainButtonStyle())
                //
                //                                            }
                //                                        }
                //
                //
                //
                //                            }
                //                            .frame(maxWidth:UIScreen.main.bounds.width)
                //
                //                        }
                //                        if searchText == ""{
                //                            Button(action: {
                //                                self.page += 1
                //                                self.moviesViewModel.getPopularMovies(page: self.page)
                //                            }) {
                //                                VStack(alignment:.center){
                //
                //                                    Text("Load More")
                //                                        .fontWeight(.semibold)
                //                                        .underline()
                //                                    Spacer()
                //                                        .frame(height:0)
                //                                }
                //                            }
                //                        }
                //                    }
                //                    .transition(.opacity)
                //                }
            }
            .navigationBarTitle(String.movies)
            .navigationBarItems(trailing:
                HStack{
                    Button(action: {
                        withAnimation {
                            self.isGrid.toggle()
                            if self.isGrid{
                                self.columns = 2
                            }
                            else{
                                self.columns = 1
                            }
                        }
                    }) {
                        HStack{
                            Spacer()
                            Image.init(systemName: self.isGrid ? "rectangle.grid.1x2.fill" : "square.grid.2x2.fill")
                                .foregroundColor(self.colorScheme == .light ? .black : .white)
                        }
                        
                    }
                    .frame(width:64,height:64)
                    
            } )
        }
        .accentColor(self.colorScheme == .light ? .black : .white)
        .onAppear {
            self.moviesViewModel.getPopularMovies(page: self.page){
                self.numItems = self.moviesViewModel.movieResponse.results.count
                self.filteredList = self.moviesViewModel.movieResponse.results
            }
            UITableView.appearance().tableFooterView = UIView()
            UITableView.appearance().separatorStyle = .none
            UITableViewCell.appearance().selectionStyle = .none
            
        }
    }
}
struct MovieGrid : View {
    @EnvironmentObject var moviesViewModel : MoviesViewModel
    @Binding var page : Int
    @Binding var isGrid : Bool
    @Binding var columns : Int
    @Binding var filteredList : [Movie]
    var geometry : GeometryProxy
    @Binding var numItems : Int
    
    var body : some View{
        VStack(spacing: 0) {
            if numItems == 0 || self.filteredList.count == 0{
                Text("No Data Found")
            }
            else{
                ForEach(0 ..< (self.numItems / self.columns),id:\.self) { row in
                    HStack(spacing: 0) {
                        Group{
                            ForEach(0 ... (self.columns - 1),id:\.self) { column in
                                ZStack{
                                    NavigationLink(destination:MovieDetailView(filteredList: self.$filteredList, movie: self.filteredList[self.index(row: row, column: column)], index: self.index(row: row, column: column))){
                                        MovieRow(movie: self.filteredList[self.index(row: row, column: column)],isGrid:false)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding([.trailing,.leading], 8)
                                .padding(.bottom, 16)
                                .frame(width: self.geometry.size.width/CGFloat(self.columns) - 16)
                                .id(self.index(row: row, column: column, isBottom: true))
                                
                            }
                        }
                    }
                    .clipped()
                }
                
                HStack(spacing: 0) {
                    ForEach(0 ..< (self.numItems % self.columns),id:\.self) { column in
                        ZStack{
                            NavigationLink(destination:MovieDetailView(filteredList: self.$filteredList,movie:self.filteredList[self.index(row: 0, column: column, isBottom: true)],index: self.index(row: 0, column: column, isBottom: true))){
                                MovieRow(movie: self.filteredList[self.index(row: 0, column: column, isBottom: true)],isGrid:true)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }                        
                        .padding([.trailing,.leading], 8)
                        .padding(.bottom, 16)
                        .frame(width: self.geometry.size.width/CGFloat(self.columns) - 16)
                        .id(self.index(row: 0, column: column, isBottom: true))
                        
                    }
                }
                .clipped()
                
            }
        }
    }
    func index(row:Int,column:Int,isBottom : Bool = false) -> Int {
        return isBottom ? ((self.numItems / self.columns) * self.columns) + column : (row * self.columns) + column
    }
}
struct MovieRow : View{
    let screenWidth = UIScreen.main.bounds.width
    let movie : Movie?
    var height : CGFloat{
        return  (screenWidth / (isGrid ? 1 : 2))
    }
    var isGrid : Bool
    var body : some View{
        ZStack(alignment: .bottom){
            ImageWithCache(url: URL(string: DataExecuter.Movie.moviePoster(width: 400, posterPath: movie?.posterPath ?? "").builder().url) ?? URL.init(fileURLWithPath: "")) { (image) in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight:self.isGrid ? .infinity : self.height)
                    .clipped()
                    .transition(.opacity)
            }
            
            Text(movie?.title ?? "")
                .foregroundColor(Color.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .multilineTextAlignment(isGrid ? .center : .leading)
                .background(Rectangle.init().foregroundColor(.black).opacity(0.80))
            VStack{
                HStack{
                    Spacer()
                    if self.movie?.isFavorite ?? false{
                        Image.init(systemName:"star.fill")
                            .padding([.top,.trailing], 8)
                            .foregroundColor(Color.orange)
                    }
                }
                Spacer()
            }
        }
        .contentShape(Rectangle())
        .clipped()
        
    }
}
