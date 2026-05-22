import XCTest
@testable import ImprovSuggestions

final class SuggestionQueueManagerTests: XCTestCase {
    
    func testNextReturnsItem() {
        var manager = SuggestionQueueManager()
        let suggestions = [
            SuggestionItem(content: "Test 1", category: .object),
            SuggestionItem(content: "Test 2", category: .object)
        ]
        
        let item = manager.next(from: suggestions)
        XCTAssertNotNil(item)
        XCTAssertTrue(suggestions.contains { $0.id == item?.id })
    }
    
    func testNextHandlesEmptySuggestions() {
        var manager = SuggestionQueueManager()
        let item = manager.next(from: [])
        XCTAssertNil(item)
    }
    
    func testNextDoesNotRepeatImmediately() {
        var manager = SuggestionQueueManager()
        let suggestions = [
            SuggestionItem(content: "Test 1", category: .object),
            SuggestionItem(content: "Test 2", category: .object)
        ]
        
        let first = manager.next(from: suggestions)
        let second = manager.next(from: suggestions)
        
        XCTAssertNotEqual(first?.id, second?.id)
    }
    
    func testRefillsWhenEmpty() {
        var manager = SuggestionQueueManager()
        let suggestions = [SuggestionItem(content: "Test 1", category: .object)]
        
        let first = manager.next(from: suggestions)
        let second = manager.next(from: suggestions)
        
        XCTAssertNotNil(first)
        XCTAssertNotNil(second)
        XCTAssertEqual(first?.id, second?.id) // Only one item, so it must repeat
    }
    
    func testResetClearsQueue() {
        var manager = SuggestionQueueManager()
        let suggestions = [SuggestionItem(content: "Test 1", category: .object)]
        
        _ = manager.next(from: suggestions)
        manager.reset()
        
        // After reset, calling next should still work because it refills
        let afterReset = manager.next(from: suggestions)
        XCTAssertNotNil(afterReset)
    }
}
