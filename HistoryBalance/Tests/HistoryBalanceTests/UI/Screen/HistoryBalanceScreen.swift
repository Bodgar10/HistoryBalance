
import Foundation
import XCTest

class HistoryBalanceScreen: XCTestCase {
 
    public let app = XCUIApplication()
     
    func getDescendentElementWith(identifier: String) -> XCUIElement {
        app.descendants(matching: .any)[identifier].firstMatch
    }
 
    var yourTextField: XCUIElement {
        getDescendentElementWith(identifier: "yourTextFieldIdentifier")
    }
 
    var yourButton: XCUIElement {
        getDescendentElementWith(identifier: "yourButtonIdentifier")
    }
}