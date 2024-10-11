//
//  HistoryBalanceView.swift
//
//
//  Created by Bodgar Espinosa Miranda on 08/10/24.
//

import SwiftUI
import CashSwitchboard
import Charts
import DesignSystem

public struct HistoryBalanceView: View {
    @ObservedObject private var viewModel: HistoryBalanceViewModel
    
    public init(viewModel: HistoryBalanceViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    PieChartView(categoriesPercentage: viewModel.percentageChart)
                        .frame(height: 250)
                    ForEach(viewModel.filteredTransactions, id: \.self) { historyBalance in
                        VStack {
                            if viewModel.validateDateSection(date: historyBalance.date) {
                                HStack {
                                    GenericText(configuration: .init(title: historyBalance.date.getDateName(), sizeTitle: .large, isBold: true))
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .padding(Sizes.medium.rawValue)
                                .background(Color(UIColor.systemGray6))
                            }
                            CellInfoView(icon: historyBalance.iconName, titleConfiguration: .init(title: historyBalance.category.rawValue, sizeTitle: .large, isBold: true), subtitleConfiguration: .init(title: historyBalance.subcategory), thirdTitleConfiguration: .init(title: historyBalance.amount.currencyFormat(), colorTitle: historyBalance.colorAmount, isBold: true))
                        }
                    }
                }
                .navigationTitle("Historial")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: {
                                viewModel.filteredTransactions(filterOption: .lastMonth)
                            }) {
                                Text("1 Mes")
                            }
                            Button(action: {
                                viewModel.filteredTransactions(filterOption: .last3Months)
                            }) {
                                Text("3 Meses")
                            }
                            Button(action: {
                                viewModel.filteredTransactions(filterOption: .last6Months)
                            }) {
                                Text("6 meses")
                            }
                            Button(action: {
                                viewModel.filteredTransactions(filterOption: .lastYear)
                            }) {
                                Text("1 Año")
                            }
                        } label: {
                            Text("Filtrar")
                        }
                    }
                }
            }
        }
    }
}

public struct PieChartView: View {
    let categoriesPercentage: [(category: CashSwitchboard.Category, percentage: Double)]

    public var body: some View {
        Chart(categoriesPercentage, id: \.category) { item in
            SectorMark(
                angle: .value("Percentage", item.percentage),
                innerRadius: .ratio(0.5),
                angularInset: 1.0
            )
            .foregroundStyle(by: .value("Category", item.category.rawValue))
        }
        .chartLegend(.automatic)
    }
}

struct TransactionsListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HistoryBalanceViewModel()
        viewModel.transactions = CashSwitchboard.Transaction.exampleTransactions()
        viewModel.filteredTransactions(filterOption: .lastYear)

        return HistoryBalanceView(viewModel: viewModel)
    }
}

extension CashSwitchboard.Transaction {
    static func exampleTransactions() -> [CashSwitchboard.Transaction] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"

        return [
            CashSwitchboard.Transaction(category: .cash, subcategory: "Groceries", amount: 100, date: formatter.date(from: "2024/09/10")!),
            CashSwitchboard.Transaction(category: .debit, subcategory: "Utilities", amount: 200, date: formatter.date(from: "2024/08/10")!),
            CashSwitchboard.Transaction(category: .credit, subcategory: "Entertainment", amount: 150, date: formatter.date(from: "2024/07/01")!),
            CashSwitchboard.Transaction(category: .salary, subcategory: "Salary", amount: 2000, date: formatter.date(from: "2024/09/01")!),
            CashSwitchboard.Transaction(category: .loan, subcategory: "Loan Payment", amount: 500, date: formatter.date(from: "2024/08/15")!)
        ]
    }
}
