//
//  LoginView.swift
//  SocialNetwork
//
//  Created by Megha Wadhwa on 02/09/24.
//

import SwiftUI
import RxSwift
import RxCocoa

struct LoginView: View {
    ///Environment variable to dismiss this sheet view
    @Environment(\.presentationMode) var presentationMode
    /// Observe the ViewModel
    @StateObject private var viewModel = LoginViewModel()
    /// SwiftUI state for button enabled state
    @State private var isLoginButtonEnabled: Bool = false
    
    private let disposeBag = DisposeBag()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                /// Email TextField
                TextField("Enter your email", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                /// Password TextField
                SecureField("Enter your password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                /// Login Button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isLoginButtonEnabled ? Color.blue : Color.gray) /// Use the SwiftUI state here
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!isLoginButtonEnabled) /// Use the SwiftUI state for the disabled state
            }
            .padding()
            .navigationTitle("Login")
        }
        .onAppear(perform: setupBindings)
    }
    
    /// Bind the ViewModel output to the SwiftUI state
    private func setupBindings() {
        viewModel.isLoginButtonEnabled
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { isEnabled in
                self.isLoginButtonEnabled = isEnabled
            })
            .disposed(by: disposeBag)
    }
}
