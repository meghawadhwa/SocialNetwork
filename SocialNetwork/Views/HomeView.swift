//
//  HomeView.swift
//  SocialNetwork
//
//  Created by Megha Wadhwa on 03/09/24.
//

import SwiftUI

struct HomeView: View {
    @State private var isLoginPresented = false
    @StateObject private var viewModel = PostsViewModel()

    var body: some View {
        TabView {
            PostsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: PostConstants.tabIcon)
                    Text(PostConstants.title)
                }
            FavoritesView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: FavouriteConstants.selectedIcon)
                    Text(FavouriteConstants.title)
                }
        }
        .onAppear {
            /// Show the login modal when the view appears
            isLoginPresented = true
        }
        .fullScreenCover(isPresented: $isLoginPresented) {
            LoginView()
        }
    }
}

#Preview {
    HomeView()
}

