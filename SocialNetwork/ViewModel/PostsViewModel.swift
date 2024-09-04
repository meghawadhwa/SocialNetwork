//
//  PostsViewModel.swift
//  SocialNetwork
//
//  Created by Megha Wadhwa on 03/09/24.
//

import Combine
import RxSwift
import RxCocoa
import RealmSwift

/// ViewModel for managing posts and their favorite status
class PostsViewModel: ObservableObject {
    
    /// Published array of all posts
    @Published var posts: [Post] = []
    
    /// Published array of favorite posts
    @Published var favoritePosts: [Post] = []
    
    private let networkManager: NetworkManager
    private let realm: Realm
    private let disposeBag: DisposeBag
    
    /// Initializes the ViewModel with necessary dependencies.
    /// - Parameters:
    ///   - networkManager: The network manager used for fetching posts.
    ///   - disposeBag: DisposeBag for managing RxSwift subscriptions.
    init(networkManager: NetworkManager = NetworkManager.shared,
         disposeBag: DisposeBag = DisposeBag(),
         realm: Realm = try! Realm()) {
        // Initialize Realm
        self.realm = realm
        self.networkManager = networkManager
        self.disposeBag = disposeBag
        // Fetch posts from local storage on initialization
        fetchLocalPosts()
    }
    
    /// Fetches posts from the network if not already fetched and saves them locally.
    func fetchPosts() {
        guard posts.isEmpty else { return }
        networkManager.fetchPosts()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] posts in
                self?.savePostsToLocal(posts)
                self?.fetchLocalPosts()
            }, onError: { error in
                print("Error fetching posts: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    /// Toggles the favorite status of a post and updates it in local storage.
    /// - Parameter post: The post whose favorite status will be toggled.
    func toggleFavorite(post: Post) {
        do {
            try realm.write {
                post.isFavorite.toggle()
                realm.add(post, update: .modified)
            }
            fetchLocalPosts()
        } catch {
            print("Error updating favorite status: \(error)")
        }
    }
    
    /// Saves posts to the local Realm database.
    /// - Parameter posts: Array of posts to be saved.
    private func savePostsToLocal(_ posts: [Post]) {
        do {
            try realm.write {
                realm.add(posts, update: .modified)
            }
        } catch {
            print("Error saving posts to local: \(error)")
        }
    }
    
    /// Fetches posts from local Realm storage and updates `posts` and `favoritePosts`.
    private func fetchLocalPosts() {
        let allPosts = realm.objects(Post.self)
        posts = Array(allPosts)
        favoritePosts = Array(allPosts.filter("isFavorite == true"))
    }
    
    /// Returns the appropriate image name for a post based on its favorite status.
    /// - Parameter post: The post for which the image name is requested.
    /// - Returns: The image name as a `String`.
    func imageName(for post: Post) -> String {
        favoritePosts.contains(where: { $0.id == post.id }) ? FavouriteConstants.selectedIcon : FavouriteConstants.unselectedIcon
    }
}
