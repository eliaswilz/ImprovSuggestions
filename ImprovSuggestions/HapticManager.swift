import UIKit

enum HapticManager {
    private static var generators: [UIImpactFeedbackGenerator.FeedbackStyle: UIImpactFeedbackGenerator] = [:]

    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = generators[style] ?? UIImpactFeedbackGenerator(style: style)
        generators[style] = generator
        generator.prepare()
        generator.impactOccurred()
    }
}
