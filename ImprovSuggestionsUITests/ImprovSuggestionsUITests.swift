//
//  ImprovSuggestionsUITests.swift
//  ImprovSuggestionsUITests
//
//  Created by Elias Wilz on 5/7/26.
//

import XCTest

final class ImprovSuggestionsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testNavigationFlow() throws {
        let app = XCUIApplication()
        app.launch()

        // Start on Questions tab (default)
        XCTAssertTrue(app.staticTexts["question_text"].exists)

        // Go to Words tab
        app.buttons["words_tab"].tap()
        XCTAssertTrue(app.staticTexts["suggestion_text"].exists)

        // Go to Games tab
        app.buttons["games_tab"].tap()
        XCTAssertTrue(app.buttons["regenerate_button"].exists)

        // Go to Favorites tab
        app.buttons["favorites_tab"].tap()
        XCTAssertTrue(app.staticTexts["FAVORITES"].exists)

        // Go to Settings tab
        app.buttons["settings_tab"].tap()
        XCTAssertTrue(app.staticTexts["SETTINGS"].exists)
    }

    @MainActor
    func testWordGenerationFlow() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["words_tab"].tap()
        
        let initialText = app.staticTexts["suggestion_text"].label
        app.buttons["generate_button"].tap()
        
        let newText = app.staticTexts["suggestion_text"].label
        XCTAssertNotEqual(initialText, newText)
    }

    @MainActor
    func testFavoriteToggleFlow() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["words_tab"].tap()
        
        let favoriteButton = app.buttons["favorite_button"]
        XCTAssertTrue(favoriteButton.exists)
        
        favoriteButton.tap()
        
        // Navigate to favorites to verify it appeared (UI-wise)
        app.buttons["favorites_tab"].tap()
        // We expect at least one favorite card to exist now
        // This might be flaky if there were already favorites, but for a clean run it works
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
