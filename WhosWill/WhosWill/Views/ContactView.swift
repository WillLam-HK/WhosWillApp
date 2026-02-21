//
//  ContactView.swift
//  WhosWill
//
//  Contact: intro, email link, LinkedIn link (no form submission in app).
//

import SwiftUI

private let email = "wunyinwilliam@icloud.com"
private let linkedInURL = "https://www.linkedin.com/in/willlamwunyin/"

struct ContactView: View {
    @Environment(AppState.self) private var appState

    private var t: Translations { appState.t }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(t.contact.getInTouch)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.accentColor)
                        Text(t.contact.title)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(t.contact.intro)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text(t.contact.orEmail)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        if let url = URL(string: "mailto:\(email)") {
                            Link(email, destination: url)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .accessibilityLabel("Email \(email)")
                                .accessibilityHint("Opens mail app")
                        }

                        Text("\(t.contact.connectLinkedIn) LinkedIn")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        if let url = URL(string: linkedInURL) {
                            Link("LinkedIn", destination: url)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .accessibilityLabel("Open LinkedIn profile")
                                .accessibilityHint("Opens in browser")
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Text("© \(Calendar.current.component(.year, from: Date())) Will Lam · \(t.footer.copyright)")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    LanguagePickerView()
                }
            }
            .onAppear {
                appState.reloadTranslations()
            }
        }
    }
}

#Preview {
    ContactView()
        .environment(AppState())
}
