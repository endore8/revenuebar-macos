//
//  PurchaseProView.swift
//  Revenue Bar
//
//  Created by Oleh on 12/09/2024.
//

import SwiftUI

struct PurchaseProView: View {
    
    let onDone: VoidClosure
    let onDismiss: VoidClosure
    
    var body: some View {
        VStack(spacing: .Spacing.none) {
            HeaderView(
                title: "Become Pro",
                onDismiss: self.onDismiss
            )
            self.contentView
            FooterView()
        }
        .task {
            self.viewModel.load()
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        HStack(alignment: .top,
               spacing: .Spacing.compact) {
            VStack(alignment: .leading,
                   spacing: .Spacing.compact) {
                Text("• Unlimited projects")
                Text("• All future features")
                Text("• Support indie development")
            }
            .font(.body)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            ZStack {
                if self.viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .controlSize(.regular)
                }
                else if let products = self.viewModel.products {
                    VStack(spacing: .Spacing.compact) {
                        ForEach(products, id: \.package.identifier) { product in
                            Button(action: { self.viewModel.purchase(product: product) }) {
                                VStack(alignment: .leading,
                                       spacing: .Spacing.small) {
                                    HStack(spacing: .Spacing.compact) {
                                        Text(product.localizedPrice)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        ProgressView()
                                            .controlSize(.small)
                                            .frame(height: .zero)
                                            .progressViewStyle(CircularProgressViewStyle())
                                            .tint(.white)
                                            .hidden(if: self.viewModel.purchasingProductId != product.id)
                                    }
                                    Rectangle()
                                        .frame(height: .one)
                                        .foregroundColor(.white)
                                        .opacity(.Opacity.mild)
                                        .frame(maxWidth: 100)
                                    Text(product.localizedPeriodTitle ?? .empty)
                                        .font(.body)
                                        .opacity(.Opacity.dimmed)
                                }
                                .padding(.Padding.inner)
                                .foregroundStyle(.white)
                                .background(.pink.gradient)
                                .clipShape(RoundedRectangle(cornerRadius: .CornerRadius.four))
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                else if let error = self.viewModel.loadingError {
                    Text("Something went wrong")
                        .font(.body)
                        .foregroundStyle(.red)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, .Padding.inner)
        .padding(.vertical, .Padding.middle)
    }
        
    @Environment(PurchaseProViewModel.self)
    private var viewModel
}

extension ProPurchaseProduct {
    
    fileprivate var localizedPeriodTitle: String? {
        switch self.package.packageType {
        case .lifetime: "Lifetime"
        case .annual: "Year"
        case .monthly: "Monthly"
        default: nil
        }
    }
    
    fileprivate var localizedPrice: String {
        self.package.localizedPriceString
    }
}
