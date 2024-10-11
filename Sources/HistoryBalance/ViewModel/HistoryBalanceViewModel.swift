//
//  HistoryBalanceViewModel.swift
//
//
//  Created by Bodgar Espinosa Miranda on 08/10/24.
//

import SwiftData
import SwiftUI
import CashSwitchboard
import Common

public class HistoryBalanceViewModel: ObservableObject {
    
    // MARK: Dependencies
    
    @Dependency var transactionService: TransactionService
    @Dependency var navigationService: NavigationService
    
    // MARK: Publishers
    
    var transactions: [CashSwitchboard.Transaction] = []
    var filteredTransactions: [CashSwitchboard.Transaction] = []
    @Published var filterOption: FilterOption = .lastMonth
    @Published var percentageChart: [(category: CashSwitchboard.Category, percentage: Double)] = []
    private var isSameMonth: String?
    private var isFirstTime = 2
    
    public enum FilterOption: Int {
        case lastMonth = 1
        case last3Months = 3
        case last6Months = 6
        case lastYear = 12
    }
    
    // MARK: Initializers
    
    public init() {
        loadTransactions()
    }
    
    // MARK: Public functions
    
    public func filteredTransactions(filterOption: FilterOption) {
        let filteredTransactions = transactions.filter{ isDateWithinLastMonths(date: $0.date, monthsBack: filterOption.rawValue)}
        let sortedTransactions = filteredTransactions.sorted { $0.date < $1.date }
        self.filteredTransactions = sortedTransactions
        isSameMonth = nil
        percentageChart = calculateCategoryPercentage()
    }
    
    public func validateDateSection(date: Date) -> Bool {
        if isSameMonth == nil || isSameMonth != date.getDateName() {
            isSameMonth = date.getDateName()
            return true
        }
        return false
    }
    
    // MARK: Private functions
    
    private func loadTransactions() {
        self.transactions = transactionService.fetchTransactions()
        let filteredTransactions =  transactions.filter { transaction in
            transaction.date.isSameMonthAndYear(dateCompare: Date())
        }
        let sortedTransactions = filteredTransactions.sorted { $0.date < $1.date }
        sumOneMonth()
        self.filteredTransactions = sortedTransactions
        percentageChart = calculateCategoryPercentage()
    }
    
    private func calculateCategoryPercentage() -> [(category: CashSwitchboard.Category, percentage: Double)] {
        let totalSpending = filteredTransactions.flatMap { $0 }
        let spendingByCategory = Dictionary(grouping: totalSpending) { $0.category }
            .map { (category, transactions) -> (CashSwitchboard.Category, Double) in
                let totalAmount = transactions.reduce(0) { $0 + $1.amount }
                return (category, totalAmount)
            }
        
        let totalAmount = spendingByCategory.reduce(0) { $0 + $1.1 }
        
        return spendingByCategory.map { (category, amount) -> (CashSwitchboard.Category, Double) in
            let percentage = totalAmount > 0 ? (amount / totalAmount) * 100 : 0
            return (category, percentage)
        }
    }
    
    func isDateWithinLastMonths(date: Date, monthsBack: Int) -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()
        
        guard let startOfCurrentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)) else {
            return false
        }
        
        guard let limitDate = calendar.date(byAdding: .month, value: -monthsBack + 1, to: startOfCurrentMonth) else {
            return false
        }
        
        return date >= limitDate && date < startOfCurrentMonth.addingTimeInterval(60 * 60 * 24 * 30)
    }
    
    func sumOneMonth() {
        let currentDate = Date()
        let calendar = Calendar.current

        let nextMonthDate = calendar.date(byAdding: .month, value: 1, to: currentDate)
        isSameMonth = nextMonthDate?.getDateName()
    }

}
