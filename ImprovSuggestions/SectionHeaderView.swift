import SwiftUI

struct SectionHeaderView: View {
    let text: String
    var color: Color = Color.theme.accentSage
    
    var body: some View {
        Text(text.uppercased())
            .font(.sectionLabel)
            .tracking(1.5)
            .foregroundStyle(color)
    }
}

#Preview {
    ZStack {
        Color.theme.darkBackground.ignoresSafeArea()
        SectionHeaderView(text: "Section Label")
    }
}
