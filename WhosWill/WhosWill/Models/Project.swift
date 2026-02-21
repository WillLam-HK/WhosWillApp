//
//  Project.swift
//  WhosWill
//
//  Project model aligned with web data/projects.
//

import Foundation

struct Project: Identifiable, Equatable {
    let id: String
    var title: String
    var description: String
    let technologies: [String]
    var images: [String]?
    var features: [String]?
    var awards: [String]?
    var githubUrl: String?
    var youtubeUrl: String?
    var externalUrl: String?
}

// MARK: - Static data (merged with locale translations in ViewModels)

extension Project {
    static let baseProjects: [Project] = [
        Project(
            id: "1",
            title: "SmartRehab",
            description: "A telerehabilitation mobile app that lets stroke survivors and other patients do guided exercises at home.",
            technologies: ["Mobile (iOS/Android)", "AI / Computer Vision", "React Native", "TypeScript"],
            images: ["https://placehold.co/800x450/e0e7ff/4f46e5?text=SmartRehab"],
            features: [
                "13 gross motor + 7 fine motor exercises with computer vision pose estimation",
                "Real-time feedback on exercise execution and motion accuracy",
                "Therapist portal for prescribing plans and monitoring progress & compliance",
                "Activity map and traffic-light system for completeness and compliance",
                "Home-based training — any time, any location; accessible on tablet and smartphone",
                "Designed for resource-limited settings where rehab services are scarce",
            ],
            awards: [
                "Gold Medal with Congratulations of the Jury — 49th Geneva International Exhibition of Inventions (2024)",
                "Supported by World Stroke Organization; feasibility trials in 7 countries",
            ],
            externalUrl: "https://www.remobility.net/smartrehab"
        ),
        Project(
            id: "2",
            title: "Air Guitar",
            description: "Motion-activated iOS app that uses the device's motion sensors to detect air-guitar gestures and generate guitar sounds.",
            technologies: ["Swift", "iOS", "Core Motion", "Audio"],
            images: ["https://placehold.co/800x450/e0e7ff/4f46e5?text=Air+Guitar"],
            features: [
                "Motion sensing via device sensors to detect air-guitar gestures",
                "Real-time guitar sound generation in response to gestures",
                "Play music through hand and arm movements without a physical instrument",
                "Built for Apple co-organized Mobile Application Innovation Contest",
            ],
            awards: [
                "First Class Award — China Collegiate Computing Contest, 3rd Mobile Application Innovation Contest (2018)",
                "Competition co-organized by Apple Inc. and Zhejiang University; 820+ teams, 591 submissions",
                "One of the first Hong Kong teams to win at this national contest",
            ],
            externalUrl: "https://www.eee.hku.hk/ce-students-teams-won-in-the-mobile-application-innovation-contest-china-collegiate-computing-contest/"
        ),
    ]
}
