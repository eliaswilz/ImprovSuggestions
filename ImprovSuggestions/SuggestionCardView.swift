import SwiftUI

struct SuggestionCardView<Content: View>: View {
    let content: Content
    var backgroundColor: Color = Color.theme.cardBackground
    var spacing: CGFloat = 16
    var padding: CGFloat = 32
    var trailingPadding: CGFloat? = nil
    
    init(
        backgroundColor: Color = Color.theme.cardBackground,
        spacing: CGFloat = 16,
        padding: CGFloat = 32,
        trailingPadding: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.spacing = spacing
        self.padding = padding
        self.trailingPadding = trailingPadding
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            content
        }
        .padding(padding)
        .ifLet(trailingPadding) { view, value in
            view.padding(.trailing, value)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

// Helper for conditional modifiers
extension View {
    @ViewBuilder
    func ifLet<V, Transform: View>(
        _ value: V?,
        @ViewBuilder transform: (Self, V) -> Transform
    ) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}

#Preview {
    ZStack {
        Color.theme.darkBackground.ignoresSafeArea()
        SuggestionCardView {
            Text("Sample Content")
                .font(.readableTitle)
                .foregroundStyle(Color.theme.offWhite)
        }
        .padding(32)
    }
}
