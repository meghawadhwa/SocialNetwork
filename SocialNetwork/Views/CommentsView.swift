//
//  CommentsView.swift
//  SocialNetwork
//
//  Created by Megha Wadhwa on 04/09/24.
//

import SwiftUI

struct CommentsView: View {
    @ObservedObject var viewModel: CommentsViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.comments) { comment in
                VStack(alignment: .leading) {
                    Text(comment.name)
                        .font(.headline)
                    Text(comment.email)
                        .font(.subheadline)
                    Text(comment.body)
                        .font(.body)
                }
                .navigationTitle(CommentsConstants.title)
            }
        }
    }
}
