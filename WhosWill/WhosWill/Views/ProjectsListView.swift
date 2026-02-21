//
//  ProjectsListView.swift
//  WhosWill
//
//  Full projects list with detail sheet.
//

import SwiftUI

struct ProjectsListView: View {
    @Environment(AppState.self) private var appState
    @State private var selectedProject: Project?

    private var t: Translations { appState.t }
    private var projects: [Project] { appState.projects() }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(t.projects.portfolio)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.accentColor)
                        Text(t.projects.title)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(t.common.moreProjectsLater)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    ForEach(projects) { project in
                        ProjectCardView(project: project) {
                            selectedProject = project
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    LanguagePickerView()
                }
            }
            .sheet(item: $selectedProject) { project in
                ProjectDetailSheet(project: project)
            }
            .onAppear {
                appState.reloadTranslations()
            }
        }
    }
}

#Preview {
    ProjectsListView()
        .environment(AppState())
}
