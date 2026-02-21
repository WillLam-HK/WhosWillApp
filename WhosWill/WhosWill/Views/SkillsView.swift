//
//  SkillsView.swift
//  WhosWill
//
//  Skills & experience: overview stats, skill categories, experience list, languages.
//

import SwiftUI

struct SkillsView: View {
    @Environment(AppState.self) private var appState

    private var t: Translations { appState.t }
    private var categoriesMap: [String: String] {
        [
            "mobile": t.skills.categories.mobile,
            "ai": t.skills.categories.ai,
            "web": t.skills.categories.web,
            "tools": t.skills.categories.tools,
        ]
    }
    private var languageNames: [String: String] {
        [
            "english": t.skills.languageNames.english,
            "cantonese": t.skills.languageNames.cantonese,
            "mandarin": t.skills.languageNames.mandarin,
        ]
    }
    private var proficiencyMap: [String: String] {
        [
            "fullProfessional": t.skills.languageProficiency.fullProfessional,
            "native": t.skills.languageProficiency.native,
        ]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header

                    overviewSection

                    skillCategoriesSection

                    experienceSection

                    languagesSection

                    profileSource
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

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(t.skills.profile)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(Color.accentColor)
            Text(t.skills.title)
                .font(.title)
                .fontWeight(.bold)
            Text(t.skills.intro)
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private var overviewSection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                statCard(
                    value: "\(SkillsData.yearsExperience)+",
                    label: t.skills.yearsExperience
                )
                statCard(
                    value: "\(SkillsData.categories.flatMap(\.items).count)",
                    label: t.skills.technicalSkills
                )
            }
            statCard(
                value: "HKU",
                label: t.skills.education,
                fullWidth: true
            )
        }
    }

    private func statCard(value: String, label: String, fullWidth: Bool = false) -> some View {
        Group {
            if fullWidth {
                VStack(alignment: .leading, spacing: 4) {
                    Text(value)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(label)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text(value)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.accentColor)
                    Text(label)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(16)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var skillCategoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(t.skills.technicalSkills)
                .font(.headline)
            ForEach(SkillsData.categories) { category in
                VStack(alignment: .leading, spacing: 10) {
                    Text(categoriesMap[category.key] ?? category.key)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    ForEach(category.items) { item in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(item.name)
                                    .font(.subheadline)
                                Spacer()
                                Text("\(item.level)%")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            GeometryReader { geo in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.accentColor.opacity(0.3))
                                    .frame(width: geo.size.width * CGFloat(item.level) / 100, height: 8)
                            }
                            .frame(height: 8)
                        }
                    }
                }
                .padding(14)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var experienceSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(t.skills.experienceTitle)
                .font(.headline)
            VStack(spacing: 0) {
                ForEach(Array(t.skills.experience.enumerated()), id: \.offset) { _, job in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(job.role)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                Text(job.company)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("\(job.period) · \(job.duration)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 10)
                    }
                    Divider()
                }
            }
            .padding(14)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private var languagesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(t.skills.languagesTitle)
                .font(.headline)
            VStack(spacing: 12) {
                ForEach(SkillsData.languages) { lang in
                    HStack {
                        Text(languageNames[lang.nameKey] ?? lang.nameKey)
                            .font(.subheadline)
                        Spacer()
                        Text(proficiencyMap[lang.proficiencyKey] ?? lang.proficiencyKey)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.accentColor.opacity(0.5))
                            .frame(width: geo.size.width * CGFloat(lang.level) / 100, height: 6)
                    }
                    .frame(height: 6)
                }
            }
            .padding(14)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private var profileSource: some View {
        (Text(t.skills.profileSource) + Text(" ") + Text(t.skills.linkedInProfile).foregroundStyle(Color.accentColor))
            .font(.caption)
            .foregroundStyle(.secondary)
            .onTapGesture {
                if let url = URL(string: "https://www.linkedin.com/in/willlamwunyin/") {
                    UIApplication.shared.open(url)
                }
            }
    }
}

#Preview {
    SkillsView()
        .environment(AppState())
}
