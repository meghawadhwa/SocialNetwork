//
//  MockNetworkManager.swift
//  SocialNetworkTests
//
//  Created by Megha Wadhwa on 04/09/24.
//

import RxSwift
import RxCocoa
@testable import SocialNetwork

// Mock network manager for testing
class MockNetworkManager: NetworkManager {
    var mockPosts: [Post] = []
    var mockComments: [Comment] = []
    
    override func fetchPosts() -> Observable<[Post]> {
        return Observable.just(mockPosts)
    }
    
    override func fetchComments(for postId: Int) -> Observable<[Comment]> {
        return Observable.just(mockComments)
    }
}
