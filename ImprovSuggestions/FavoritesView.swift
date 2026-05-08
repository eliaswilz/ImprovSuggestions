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
                VStack(alignment: .leading, spacing: 16) {
                    Text("FAVORITES")
                        .font(.sectionLabel)
                        .tracking(1.5)
                        .foregroundStyle(Color.theme.offWhite.opacity(0.55))

                    Text("No favorites yet")
                        .font(.suggestionTitle)
                        .foregroundStyle(Color.theme.offWhite)
                        .multilineTextAlignment(.leading)
                }
                .padding(32)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.theme.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(32)
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 18) {
                        Text("FAVORITES")
                            .font(.sectionLabel)
                            .tracking(1.5)
                            .foregroundStyle(Color.theme.offWhite.opacity(0.65))

                        ForEach(favorites) { favorite in
                            VStack(alignment: .leading, spacing: 12) {
                                Text(favorite.categoryEnum.rawValue.uppercased())
                                    .font(.sectionLabel)
                                    .tracking(1.5)
                                    .foregroundStyle(Color.theme.offWhite.opacity(0.55))

                                Text(favorite.content)
                                    .font(.suggestionTitle)
                                    .foregroundStyle(Color.theme.offWhite)
                                    .multilineTextAlignment(.leading)
                                    .minimumScaleFactor(0.65)

                                if let secondaryContent = favorite.secondaryContent {
                                    Text(secondaryContent)
                                        .font(.title2.weight(.semibold))
                                        .foregroundStyle(Color.theme.offWhite.opacity(0.8))
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .padding(32)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.theme.cardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
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
