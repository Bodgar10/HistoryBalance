import SwiftUI
import SwiftData
import HistoryBalance
import CashSwitchboard
import Common

@main
struct DemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HistoryCoordinator().start()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let modelContext = ModelContainerProvider.shared.mainContext
        
        ServiceLocator.register(NavigationService.self, factory: MockNavigationService())
        ServiceLocator.register(TransactionService.self, factory: MockTransactionService(modelContext: modelContext))
        return true
    }
}

public class MockTransactionService: TransactionService {
    
    private let modelContext: ModelContext
    public var id = UUID()
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    public func fetchTransactions() -> [CashSwitchboard.Transaction] {
        do {
            let descriptor = FetchDescriptor<CashSwitchboard.Transaction>(sortBy: [SortDescriptor(\.date)])
            return try modelContext.fetch(descriptor)
        } catch {}
        return []
    }
}

public class MockNavigationService: NavigationService {
    public var id = UUID()
    
    public func navigate(to destination: Common.Destination) {
        print("NAVIGATE TO: \(destination)")
    }
}

class ModelContainerProvider {
    static let shared: ModelContainer = {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
            let container = try ModelContainer(for: CashSwitchboard.Transaction.self, configurations: configuration)
            return container
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
}
