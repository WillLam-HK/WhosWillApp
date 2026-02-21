//
//  HomeView.swift
//  WhosWill
//
//  Home: Hero + featured projects (first 2) + link to full projects.
//

import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) private var appState
    @State private var selectedProject: Project?
    @Binding var selectedTab: Int

    init(selectedTab: Binding<Int> = .constant(0)) {
        _selectedTab = selectedTab
    }

    private var t: Translations { appState.t }
    private var projects: [Project] { appState.projects() }
    private var featured: [Project] { Array(projects.prefix(2)) }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HeroView(tagline: t.hero.tagline)

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(t.home.work)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.accentColor)
                                Text(t.home.featuredProjects)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            Button {
                                selectedTab = 2
                            } label: {
                                HStack(spacing: 4) {
                                    Text(t.common.viewAll)
                                    Image(systemName: "arrow.right")
                                        .font(.caption)
                                }
                                .font(.subheadline)
                                .fontWeight(.medium)
                            }
                            .accessibilityLabel(t.common.viewAll)
                            .accessibilityHint("Opens the Projects tab")
                        }

                        ForEach(featured) { project in
                            ProjectCardView(project: project) {
                                selectedProject = project
                            }
                        }

                        Text(t.common.moreProjectsSoon)
                            .font(.caption)
                            .foregroundStyle(.secondary)
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
        }
        .onAppear {
            appState.reloadTranslations()
        }
    }
}

// Binding for tab selection from ContentView
struct HomeViewWithTab: View {
    @Environment(AppState.self) private var appState
    @Binding var selectedTab: Int

    var body: some View {
        HomeView(selectedTab: $selectedTab)
    }
}

#Preview {
    HomeView()
        .environment(AppState())
}
