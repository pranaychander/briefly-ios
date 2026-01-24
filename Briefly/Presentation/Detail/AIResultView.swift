//
//  AIResultView.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import SwiftUI

struct AIResultView: View {
    
    let article: Article
    let action: AIAction
    
    @State private var viewModel: AIResultViewModel
    
    init(article: Article, action: AIAction) {
        self.article = article
        self.action = action
        _viewModel = .init(wrappedValue: AIResultViewModel(article: article, action: action))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Generating…")
                    .padding()
            } else {
                ScrollView {
                    TextEditor(text: $viewModel.output)
                        .padding()
                        .frame(minHeight: 300)
                }
            }
            
            Divider()
            
            HStack {
                Button("Regenerate") {
                    viewModel.generate()
                }
                
                Spacer()
                
                Button("Copy") {
                    UIPasteboard.general.string = viewModel.output
                }
                
                Button("Share") {
                    share()
                }
            }
            .padding()
        }
        .navigationTitle(action.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.generate()
        }
    }
    
    func share() {
        
        let activityVC = UIActivityViewController(
            activityItems: [viewModel.output],
            applicationActivities: nil
        )
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}
