import SwiftData
import SwiftUI

struct FavoritesView: View {
    @Query(filter: #Predicate<SuggestionItem> { suggestion in
        suggestion.isFavorite == true
    }) private var favorites: [SuggestionItem]

    var body: some View {
        ZStack {
            Color.theme.darkBackground
                .ignoresSafeArea()

            if favorites.isEmpty {
                SuggestionCardView(spacing: 16) {
                    Text("FAVORITES")
                        .font(.sectionLabel)
                        .tracking(1.5)
                        .foregroundStyle(Color.theme.accentSage)

                    Text("No favorites yet")
                        .font(.readableTitle)
                        .foregroundStyle(Color.theme.offWhite)
                        .multilineTextAlignment(.leading)
                }
                .padding(32)
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 18) {
                        Text("FAVORITES")
                            .font(.sectionLabel)
                            .tracking(1.5)
                            .foregroundStyle(Color.theme.offWhite.opacity(0.65))

                        ForEach(favorites) { favorite in
                            SuggestionCardView(spacing: 12) {
                                Text(favorite.category.rawValue.uppercased())
                                    .font(.sectionLabel)
                                    .tracking(1.5)
                                    .foregroundStyle(Color.theme.accentSage)

                                Text(favorite.content)
                                    .font(.readableTitle)
                                    .foregroundStyle(Color.theme.offWhite)
                                    .multilineTextAlignment(.leading)
                                    .minimumScaleFactor(0.5)

                                if let secondaryContent = favorite.secondaryContent {
                                    Text(secondaryContent)
                                        .font(.title2.weight(.semibold))
                                        .foregroundStyle(Color.theme.offWhite.opacity(0.8))
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                    }
                    .padding(32)
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
        .modelContainer(for: SuggestionItem.self, inMemory: true)
}
