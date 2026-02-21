//
//  LanguagePickerView.swift
//  WhosWill
//
//  Picker for app locale (en / zh-Hans / zh-Hant).
//

import SwiftUI

struct LanguagePickerView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        Menu {
            ForEach(AppLocale.allCases) { locale in
                Button {
                    appState.setLocale(locale)
                } label: {
                    HStack {
                        Text(locale.displayName)
                        if appState.locale == locale {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "globe")
        }
        .accessibilityLabel("Language")
        .accessibilityHint("Change app language. Current: \(appState.locale.displayName)")
    }
}

#Preview {
    LanguagePickerView()
        .environment(AppState())
}
