//
//  SearchBar.swift
//  MovieApp
//
//  Created by Hüseyin Bagana on 22.03.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//
   
import SwiftUI
struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var textChanged : () -> Void
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        var parent : SearchBar
        init(parent:SearchBar,text: Binding<String>) {
            self.parent = parent
            _text = text
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            self.text = ""
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
            parent.textChanged()
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            parent.textChanged()

        }
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }
        
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(parent:self,text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
