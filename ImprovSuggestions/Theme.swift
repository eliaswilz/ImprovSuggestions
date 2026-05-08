import SwiftUI

struct Theme {
    let darkBackground = Color(red: 0.102, green: 0.102, blue: 0.102)
    let deepBlue = Color(red: 0.000, green: 0.349, blue: 0.471)
    let brightBlue = Color(red: 0.000, green: 0.412, blue: 0.616)
    let teal = Color(red: 0.000, green: 0.435, blue: 0.416)
    let darkRed = Color(red: 0.545, green: 0.000, blue: 0.000)
    let brightRed = Color(red: 0.706, green: 0.000, blue: 0.122)
    let offWhite = Color(red: 0.961, green: 0.949, blue: 0.925)
    let cardBackground = Color(red: 0.141, green: 0.141, blue: 0.141)
    let headerCardBackground = Color(red: 0.118, green: 0.165, blue: 0.188)
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
            .background(Color.theme.brightBlue)
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
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
                .foregroundStyle(Color.theme.brightBlue)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(Color.gray)
                .multilineTextAlignment(.leading)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.headerCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal, 16)
    }
}
