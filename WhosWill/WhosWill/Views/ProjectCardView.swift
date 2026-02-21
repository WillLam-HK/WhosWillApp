//
//  ProjectCardView.swift
//  WhosWill
//
//  Card for one project (thumbnail, title, description, teasers, tech tags, actions).
//

import SwiftUI

struct ProjectCardView: View {
    @Environment(AppState.self) private var appState
    let project: Project
    var onViewDetails: (() -> Void)?

    private var t: Translations { appState.t }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let urlString = project.images?.first, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .overlay(Text(project.title).font(.caption).foregroundStyle(.secondary))
                    default:
                        Rectangle()
                            .fill(Color.gray.opacity(0.15))
                    }
                }
                .frame(height: 180)
                .clipped()
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(project.title)
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(project.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)

                if let award = project.awards?.first {
                    HStack(alignment: .top, spacing: 6) {
                        Text("🏆")
                        Text(award)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                } else if let feature = project.features?.first {
                    HStack(alignment: .top, spacing: 6) {
                        Image(systemName: "checkmark")
                            .font(.caption)
                            .foregroundStyle(Color.accentColor)
                        Text(feature)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(project.technologies, id: \.self) { tech in
                            Text(tech)
                                .font(.caption2)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }
                }

                HStack(spacing: 12) {
                    if onViewDetails != nil {
                        Button(action: { onViewDetails?() }) {
                            Text(t.common.viewDetails)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Color.accentColor)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    if let link = project.externalUrl, let url = URL(string: link) {
                        Link(t.common.visitProject, destination: url)
                            .font(.subheadline)
                    }
                    if let link = project.githubUrl, let url = URL(string: link) {
                        Link(t.common.github, destination: url)
                            .font(.subheadline)
                    }
                }
            }
            .padding(16)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(project.title). \(project.description)")
        .accessibilityHint("Double tap to view details")
    }
}

#Preview {
    ProjectCardView(project: Project.baseProjects[0], onViewDetails: {})
        .environment(AppState())
        .padding()
}
