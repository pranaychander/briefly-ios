//
//  AIResultView.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import SwiftUI

struct AIResultView: View {
    
    @State var viewModel: AIResultViewModel

    var body: some View {
        VStack(spacing: 0) {

            // HEADER
            header

            Divider()

            // CONTENT
            content

            Divider()

            // ACTION BAR
            actionBar
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.generate()
        }
    }
}

private extension AIResultView {

    var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.action.title)
                .font(.headline)

            HStack(spacing: 6) {
                Image(systemName: "sparkles")
                    .foregroundColor(.cyan)

                Text("Created with BRU")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


private extension AIResultView {

    var content: some View {
        Group {
            if viewModel.isLoading {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("BRU is thinking…")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    Text(viewModel.output)
                        .font(.body)
                        .lineSpacing(6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
            }
        }
    }
}

private extension AIResultView {

    var actionBar: some View {
        HStack {
            Button {
                Task { await viewModel.generate() }
            } label: {
                Label("Regenerate", systemImage: "arrow.clockwise")
            }

            Spacer()

            Button {
                UIPasteboard.general.string = viewModel.output
            } label: {
                Label("Copy", systemImage: "doc.on.doc")
            }

            Button {
                share()
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
        }
        .font(.subheadline.weight(.medium))
        .padding()
    }
}

private extension AIResultView {

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
