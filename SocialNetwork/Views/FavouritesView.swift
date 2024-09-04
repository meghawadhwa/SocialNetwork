//
//  FavouritesView.swift
//  SocialNetwork
//
//  Created by Megha Wadhwa on 03/09/24.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: PostsViewModel
    @State var commentsViewModel = CommentsViewModel()
    @State private var isCommentsViewPresented = false
    
    var body: some View {
        NavigationView {
            if viewModel.favoritePosts.isEmpty {
                VStack(alignment: .center) {
                    Text(FavouriteConstants.emptyHeader)
                        .font(.headline)
                        .padding(20)
                }
            } else {
                List(viewModel.favoritePosts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.subheadline)
                        Button(action: {
                            isCommentsViewPresented = true
                            self.commentsViewModel.post = post
                        }) {
                            Image(systemName: CommentsConstants.icon)
                        }
                    }
                    .navigationTitle(FavouriteConstants.title)
                }.sheet(isPresented: $isCommentsViewPresented) {
                    CommentsView(viewModel: self.commentsViewModel)
                }
            }
        }
    }
}
