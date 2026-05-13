import SwiftUI

struct Theme {
    let darkBackground = Color(red: 0.102, green: 0.102, blue: 0.102)
    let offWhite = Color(red: 1.000, green: 1.000, blue: 1.000)
    let accentPurple = Color(red: 0.529, green: 0.420, blue: 0.502)
    let accentSoftBlue = Color(red: 0.467, green: 0.529, blue: 0.765)
    let accentOlive = Color(red: 0.463, green: 0.494, blue: 0.306)
    let accentSage = Color(red: 0.557, green: 0.584, blue: 0.463)
    let accentDeepBlue = Color(red: 0.361, green: 0.400, blue: 0.608)
    let cardBackground = Color(red: 0.145, green: 0.145, blue: 0.145)
    let headerCardBackground = Color(red: 0.165, green: 0.165, blue: 0.165)
}

extension Color {
    static let theme = Theme()
}

extension Font {
    static let readableTitle = Font.system(size: 34, weight: .bold, design: .rounded)
    static let readableHeadline = Font.system(size: 24, weight: .semibold, design: .rounded)
    static let readableBody = Font.system(size: 20, weight: .regular, design: .rounded)
    static let suggestionTitle = Font.largeTitle.weight(.bold)
    static let sectionLabel = Font.caption.weight(.semibold)
}

struct PrimaryPillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.semibold))
            .tracking(0.8)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
            .background(Color.theme.accentDeepBlue)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.65), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PrimaryPillButtonStyle {
    static var primaryPill: PrimaryPillButtonStyle {
        PrimaryPillButtonStyle()
    }
}

struct ModeHeaderCard: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.caption.weight(.semibold))
                .tracking(1.5)
                .foregroundStyle(Color.theme.accentSoftBlue)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(Color.gray)
                .multilineTextAlignment(.leading)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.headerCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding(.horizontal, 16)
    }
}
