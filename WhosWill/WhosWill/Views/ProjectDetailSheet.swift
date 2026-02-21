//
//  ProjectDetailSheet.swift
//  WhosWill
//
//  Full project detail (image, description, features, awards, links).
//

import SwiftUI

struct ProjectDetailSheet: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    let project: Project

    private var t: Translations { appState.t }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let urlString = project.images?.first, let url = URL(string: urlString) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            default:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 200)
                            }
                        }
                        .frame(maxHeight: 220)
                        .clipped()
                    }

                    Text(project.description)
                        .font(.body)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 8) {
                        ForEach(project.technologies, id: \.self) { tech in
                            Text(tech)
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }

                    if let features = project.features, !features.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(t.common.featuresSection)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            ForEach(features, id: \.self) { f in
                                HStack(alignment: .top, spacing: 6) {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(Color.accentColor)
                                    Text(f)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }

                    if let awards = project.awards, !awards.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(t.common.awardsSection)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            ForEach(awards, id: \.self) { a in
                                HStack(alignment: .top, spacing: 6) {
                                    Text("🏆")
                                    Text(a)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }

                    HStack(spacing: 16) {
                        if let urlString = project.externalUrl, let url = URL(string: urlString) {
                            Link(t.common.visitProject, destination: url)
                        }
                        if let urlString = project.githubUrl, let url = URL(string: urlString) {
                            Link(t.common.github, destination: url)
                        }
                        if let urlString = project.youtubeUrl, let url = URL(string: urlString) {
                            Link(t.common.video, destination: url)
                        }
                    }
                    .font(.subheadline)
                }
                .padding()
            }
            .navigationTitle(project.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(t.common.close) { dismiss() }
                        .accessibilityLabel(t.common.close)
                        .accessibilityHint("Closes the project detail")
                }
            }
            .accessibilityElement(children: .contain)
        }
    }
}

#Preview {
    ProjectDetailSheet(project: Project.baseProjects[0])
        .environment(AppState())
}
