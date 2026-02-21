package com.example.willlam.whoswill.data

data class Project(
    val id: String,
    val title: String,
    val description: String,
    val technologies: List<String>,
    val images: List<String>? = null,
    val features: List<String>? = null,
    val awards: List<String>? = null,
    val githubUrl: String? = null,
    val youtubeUrl: String? = null,
    val externalUrl: String? = null
) {
    companion object {
        val baseProjects: List<Project> = listOf(
            Project(
                id = "1",
                title = "SmartRehab",
                description = "A telerehabilitation mobile app that lets stroke survivors and other patients do guided exercises at home.",
                technologies = listOf("Mobile (iOS/Android)", "AI / Computer Vision", "React Native", "TypeScript"),
                images = listOf("https://placehold.co/800x450/e0e7ff/4f46e5?text=SmartRehab"),
                features = listOf(
                    "13 gross motor + 7 fine motor exercises with computer vision pose estimation",
                    "Real-time feedback on exercise execution and motion accuracy",
                    "Therapist portal for prescribing plans and monitoring progress & compliance",
                    "Activity map and traffic-light system for completeness and compliance",
                    "Home-based training — any time, any location; accessible on tablet and smartphone",
                    "Designed for resource-limited settings where rehab services are scarce"
                ),
                awards = listOf(
                    "Gold Medal with Congratulations of the Jury — 49th Geneva International Exhibition of Inventions (2024)",
                    "Supported by World Stroke Organization; feasibility trials in 7 countries"
                ),
                externalUrl = "https://www.remobility.net/smartrehab"
            ),
            Project(
                id = "2",
                title = "Air Guitar",
                description = "Motion-activated iOS app that uses the device's motion sensors to detect air-guitar gestures and generate guitar sounds.",
                technologies = listOf("Swift", "iOS", "Core Motion", "Audio"),
                images = listOf("https://placehold.co/800x450/e0e7ff/4f46e5?text=Air+Guitar"),
                features = listOf(
                    "Motion sensing via device sensors to detect air-guitar gestures",
                    "Real-time guitar sound generation in response to gestures",
                    "Play music through hand and arm movements without a physical instrument",
                    "Built for Apple co-organized Mobile Application Innovation Contest"
                ),
                awards = listOf(
                    "First Class Award — China Collegiate Computing Contest, 3rd Mobile Application Innovation Contest (2018)",
                    "Competition co-organized by Apple Inc. and Zhejiang University; 820+ teams, 591 submissions",
                    "One of the first Hong Kong teams to win at this national contest"
                ),
                externalUrl = "https://www.eee.hku.hk/ce-students-teams-won-in-the-mobile-application-innovation-contest-china-collegiate-computing-contest/"
            )
        )
    }
}
