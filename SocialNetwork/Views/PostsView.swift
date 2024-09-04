//
//  PostsView.swift
//  SocialNetwork
//
//  Created by Megha Wadhwa on 03/09/24.
//

import SwiftUI

struct PostsView: View {
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.subheadline)
                    Button(action: {
                        viewModel.toggleFavorite(post: post)
                    }) {
                        Image(systemName: viewModel.imageName(for: post))
                    }
                }
                .navigationTitle("Posts")
            }
        }
        .onAppear {
            viewModel.fetchPosts()
        }
    }
}
