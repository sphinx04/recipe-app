//
//  SearchListItemView.swift
//  recipe-app
//
//  Created by Sphinx04 on 30.07.23.
//

import Foundation
import SwiftUI

struct SearchListItemView: View {
    var name: String
    var action: () -> ()
    
    @Environment(\.dismissSearch) var dismissSearch
    
    var body: some View {
        HStack {
            Text(name)
            
            Spacer()
            
            Button {
                dismissSearch()
                action()
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
