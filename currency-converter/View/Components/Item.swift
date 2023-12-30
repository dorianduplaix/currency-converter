//
//  Item.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 29/12/2023.
//

import SwiftUI

struct Item: View {
    var withValue: Bool
    var currencyItem: CurrencyItem
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(.gray)
                .opacity(0.4)
                .frame(height: 60)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            HStack {
                VStack(spacing: 7) {
                    Text(currencyItem.symbol)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.headline.weight(.heavy))
                    Text(currencyItem.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 12))
                }
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                
                rightValue
            }
        }
    }
    
    @ViewBuilder
    private var rightValue: some View {
        if withValue {
            Text(currencyItem.value ?? "-")
                .frame(alignment: .trailing)
                .font(Font.headline.weight(.heavy))
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
        } else {
            rightArrow
        }

    }
    
    private var rightArrow: some View {
        Image("arrow-right-bold")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.white)
            .frame(width: 14, height: 14, alignment: .trailing)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
    }
}
