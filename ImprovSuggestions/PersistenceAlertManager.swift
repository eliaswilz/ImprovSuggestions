import Foundation

struct PersistenceAlert: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}

final class PersistenceAlertManager: ObservableObject {
    static let shared = PersistenceAlertManager()

    @Published var currentAlert: PersistenceAlert?

    private init() { }

    func showSaveError(action: String, error: Error) {
        currentAlert = PersistenceAlert(
            title: "Unable to Save Changes",
            message: "\(action) Please try again.\n\n\(error.localizedDescription)"
        )
    }
}
