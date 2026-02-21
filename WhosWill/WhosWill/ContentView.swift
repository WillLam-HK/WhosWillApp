//
//  ContentView.swift
//  WhosWill
//
//  Main tab navigation: Home, Skills, Projects, Contact.
//

import SwiftUI

struct ContentView: View {
    @State private var appState = AppState()
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Label(appState.t.nav.home, systemImage: "house.fill")
                }
                .tag(0)
                .accessibilityLabel(appState.t.nav.home)
                .accessibilityHint("Shows featured projects and tagline")

            SkillsView()
                .tabItem {
                    Label(appState.t.nav.skills, systemImage: "brain.head.profile")
                }
                .tag(1)
                .accessibilityLabel(appState.t.nav.skills)

            ProjectsListView()
                .tabItem {
                    Label(appState.t.nav.projects, systemImage: "folder.fill")
                }
                .tag(2)
                .accessibilityLabel(appState.t.nav.projects)

            ContactView()
                .tabItem {
                    Label(appState.t.nav.contact, systemImage: "envelope.fill")
                }
                .tag(3)
                .accessibilityLabel(appState.t.nav.contact)
        }
        .environment(appState)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Main navigation")
    }
}

#Preview {
    ContentView()
}
