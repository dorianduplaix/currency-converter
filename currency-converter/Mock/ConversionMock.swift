//
//  ConversionMock.swift
//  currency-converter
//
//  Created by Dorian Duplaix on 07/11/2023.
//

import Foundation

let conversionMock = """
{
  "disclaimer": "https://openexchangerates.org/terms/",
  "license": "https://openexchangerates.org/license/",
  "request": {
    "query": "/convert/19999.95/GBP/EUR",
    "amount": 19999.95,
    "from": "GBP",
    "to": "EUR"
  },
  "meta": {
    "timestamp": 1449885661,
    "rate": 1.383702
  },
  "response": 27673.975864
}
""".data(using: .utf8)

let currenciesMock = """
{"RUB": "Russian Ruble", "AED": "United Arab Emirates Dirham", "NOK": "Norwegian Krone", "KHR": "Cambodian Riel", "TZS": "Tanzanian Shilling", "KWD": "Kuwaiti Dinar", "STN": "São Tomé and Príncipe Dobra", "TND": "Tunisian Dinar", "QAR": "Qatari Rial", "INR": "Indian Rupee", "LBP": "Lebanese Pound", "BTC": "Bitcoin", "BYN": "Belarusian Ruble", "IMP": "Manx pound", "SLL": "Sierra Leonean Leone", "MRU": "Mauritanian Ouguiya", "BGN": "Bulgarian Lev", "MMK": "Myanma Kyat", "GEL": "Georgian Lari", "KPW": "North Korean Won", "GHS": "Ghanaian Cedi", "CUP": "Cuban Peso", "SEK": "Swedish Krona", "DKK": "Danish Krone", "MWK": "Malawian Kwacha", "SCR": "Seychellois Rupee", "BRL": "Brazilian Real", "TTD": "Trinidad and Tobago Dollar", "HTG": "Haitian Gourde", "CLP": "Chilean Peso", "CVE": "Cape Verdean Escudo", "GYD": "Guyanaese Dollar", "NAD": "Namibian Dollar", "AUD": "Australian Dollar", "TMT": "Turkmenistani Manat", "LSL": "Lesotho Loti", "BMD": "Bermudan Dollar", "THB": "Thai Baht", "ZAR": "South African Rand", "AZN": "Azerbaijani Manat", "EUR": "Euro", "CDF": "Congolese Franc", "XOF": "CFA Franc BCEAO", "KYD": "Cayman Islands Dollar", "AMD": "Armenian Dram", "DZD": "Algerian Dinar", "IQD": "Iraqi Dinar", "TJS": "Tajikistani Somoni", "AFN": "Afghan Afghani", "MZN": "Mozambican Metical", "FKP": "Falkland Islands Pound", "ARS": "Argentine Peso", "IDR": "Indonesian Rupiah", "SDG": "Sudanese Pound", "XPF": "CFP Franc", "CAD": "Canadian Dollar", "BZD": "Belize Dollar", "UGX": "Ugandan Shilling", "EGP": "Egyptian Pound", "MKD": "Macedonian Denar", "MYR": "Malaysian Ringgit", "ANG": "Netherlands Antillean Guilder", "MNT": "Mongolian Tugrik", "BAM": "Bosnia-Herzegovina Convertible Mark", "BWP": "Botswanan Pula", "FJD": "Fijian Dollar", "SAR": "Saudi Riyal", "MVR": "Maldivian Rufiyaa", "BTN": "Bhutanese Ngultrum", "GTQ": "Guatemalan Quetzal", "XAF": "CFA Franc BEAC", "SSP": "South Sudanese Pound", "ALL": "Albanian Lek", "JMD": "Jamaican Dollar", "HRK": "Croatian Kuna", "XAU": "Gold Ounce", "CZK": "Czech Republic Koruna", "LYD": "Libyan Dinar", "MAD": "Moroccan Dirham", "KGS": "Kyrgystani Som", "ISK": "Icelandic Króna", "PAB": "Panamanian Balboa", "ILS": "Israeli New Sheqel", "ZMW": "Zambian Kwacha", "RWF": "Rwandan Franc", "CRC": "Costa Rican Colón", "DOP": "Dominican Peso", "HKD": "Hong Kong Dollar", "PYG": "Paraguayan Guarani", "NZD": "New Zealand Dollar", "ERN": "Eritrean Nakfa", "SYP": "Syrian Pound", "RON": "Romanian Leu", "HNL": "Honduran Lempira", "UAH": "Ukrainian Hryvnia", "DJF": "Djiboutian Franc", "JOD": "Jordanian Dinar", "BHD": "Bahraini Dinar", "SHP": "Saint Helena Pound", "CHF": "Swiss Franc", "NPR": "Nepalese Rupee", "MGA": "Malagasy Ariary", "SZL": "Swazi Lilangeni", "VUV": "Vanuatu Vatu", "VEF": "Venezuelan Bolívar Fuerte (Old)", "SVC": "Salvadoran Colón", "PHP": "Philippine Peso", "UZS": "Uzbekistan Som", "BSD": "Bahamian Dollar", "LKR": "Sri Lankan Rupee", "PLN": "Polish Zloty", "KZT": "Kazakhstani Tenge", "GNF": "Guinean Franc", "MDL": "Moldovan Leu", "CNH": "Chinese Yuan (Offshore)", "XAG": "Silver Ounce", "RSD": "Serbian Dinar", "KMF": "Comorian Franc", "LAK": "Laotian Kip", "XPT": "Platinum Ounce", "BDT": "Bangladeshi Taka", "GIP": "Gibraltar Pound", "GGP": "Guernsey Pound", "WST": "Samoan Tala", "AOA": "Angolan Kwanza", "NGN": "Nigerian Naira", "KRW": "South Korean Won", "XPD": "Palladium Ounce", "GBP": "British Pound Sterling", "SGD": "Singapore Dollar", "OMR": "Omani Rial", "UYU": "Uruguayan Peso", "MXN": "Mexican Peso", "PGK": "Papua New Guinean Kina", "AWG": "Aruban Florin", "CUC": "Cuban Convertible Peso", "JEP": "Jersey Pound", "NIO": "Nicaraguan Córdoba", "TRY": "Turkish Lira", "MUR": "Mauritian Rupee", "LRD": "Liberian Dollar", "PKR": "Pakistani Rupee", "BIF": "Burundian Franc", "GMD": "Gambian Dalasi", "XCD": "East Caribbean Dollar", "HUF": "Hungarian Forint", "ZWL": "Zimbabwean Dollar", "PEN": "Peruvian Nuevo Sol", "TOP": "Tongan Pa\'anga", "CNY": "Chinese Yuan", "BND": "Brunei Dollar", "TWD": "New Taiwan Dollar", "USD": "United States Dollar", "STD": "São Tomé and Príncipe Dobra (pre-2018)", "BOB": "Bolivian Boliviano", "SOS": "Somali Shilling", "KES": "Kenyan Shilling", "ETB": "Ethiopian Birr", "JPY": "Japanese Yen", "VND": "Vietnamese Dong", "BBD": "Barbadian Dollar", "COP": "Colombian Peso", "MOP": "Macanese Pataca", "CLF": "Chilean Unit of Account (UF)", "XDR": "Special Drawing Rights", "YER": "Yemeni Rial", "VES": "Venezuelan Bolívar Soberano", "IRR": "Iranian Rial", "SRD": "Surinamese Dollar", "SBD": "Solomon Islands Dollar"}
""".data(using: .utf8)

let conversionRatesMock = """
{"timestamp": 1703948533, "base": "USD",
"rates": {
"RWF": 1259.06151, "SBD": 8.427507, "KPW": 900.0, "IQD": 1309.083017, "ZWL": 322.0, "CUP": 25.75, "FKP": 0.784929, "HKD": 7.81045, "SOS": 571.515456, "PYG": 7285.230594, "COP": 3881.308455, "SSP": 130.26, "STN": 22.120498, "KZT": 456.973184, "CAD": 1.32635, "HNL": 24.675641, "PEN": 3.693007, "BDT": 109.753763, "IDR": 15390.1, "ISK": 136.0, "BRL": 4.852499, "KWD": 0.30728, "BIF": 2848.769896, "XPF": 107.938804, "PHP": 55.399998, "OMR": 0.384952, "EUR": 0.904527, "SVC": 8.750689, "MXN": 16.9712, "MDL": 17.298133, "GYD": 209.389684, "MAD": 9.898878, "XPT": 0.00100578, "EGP": 30.9017, "XAF": 593.330932, "ALL": 93.537265, "ZAR": 18.300655, "RON": 4.5066, "NIO": 36.602653, "XAU": 0.00048476, "LKR": 323.916369, "UAH": 38.025046, "NZD": 1.581278, "XCD": 2.70255, "BGN": 1.771495, "QAR": 3.646361, "SAR": 3.75, "STD": 22281.8, "HRK": 6.82642, "CRC": 519.592162, "MWK": 1683.463314, "AUD": 1.467352, "DKK": 6.7547, "CZK": 22.38225, "XDR": 0.745145, "NOK": 10.216308, "UYU": 39.068992, "TJS": 10.945665, "GMD": 67.325, "KGS": 89.0853, "LSL": 18.469624, "UZS": 12339.647325, "PAB": 1.0, "SDG": 601.0, "CUC": 1.0, "XOF": 593.330932, "VND": 24268.902622, "CNY": 7.0796, "KES": 157.01, "PGK": 3.745092, "JMD": 154.507988, "SHP": 0.784929, "MUR": 44.02, "BSD": 1.0, "GEL": 2.69, "NAD": 18.469624, "AFN": 70.641134, "IMP": 0.784929, "CVE": 99.555783, "NPR": 133.107308, "MRU": 39.220643, "SCR": 13.446026, "ETB": 56.319965, "CHF": 0.840895, "RUB": 89.249994, "MVR": 15.4, "BTC": 2.3813507e-05, "BAM": 1.765848, "AZN": 1.7, "KHR": 4085.533818, "KMF": 445.149612, "MNT": 3450.0, "BTN": 83.190676, "GGP": 0.784929, "LBP": 15030.798551, "TND": 3.06425, "AED": 3.672755, "GHS": 11.965511, "USD": 1.0, "XPD": 0.00090852, "MOP": 8.047094, "CLP": 881.074367, "AMD": 404.492637, "AWG": 1.8, "TMT": 3.51, "IRR": 42017.5, "ARS": 806.848165, "WST": 2.8, "SGD": 1.3207, "FJD": 2.19495, "ANG": 1.802398, "SZL": 18.458427, "TRY": 29.476298, "GNF": 8599.113305, "AOA": 828.8, "ZMW": 25.735826, "SLL": 20969.5, "ERN": 15.0, "TWD": 30.68355, "ILS": 3.60085, "HTG": 131.88332, "MZN": 63.899991, "INR": 83.21895, "BHD": 0.376935, "KYD": 0.833446, "CNH": 7.12908, "BMD": 1.0, "NGN": 896.64, "VES": 35.845686, "YER": 250.249998, "DZD": 134.326, "KRW": 1294.53, "TZS": 2510.0, "TOP": 2.330633, "SYP": 2512.53, "PLN": 3.93682, "JEP": 0.784929, "MYR": 4.595, "LRD": 188.475008, "BWP": 13.405925, "GTQ": 7.823363, "VUV": 118.722, "UGX": 3780.358763, "BOB": 6.910437, "LYD": 4.765388, "SRD": 36.7455, "MKD": 55.738492, "RSD": 106.222, "BND": 1.319465, "HUF": 347.19, "MGA": 4608.183819, "SEK": 10.07275, "JPY": 141.02502648, "PKR": 278.217655, "TTD": 6.787649, "THB": 34.194745, "JOD": 0.7096, "GBP": 0.784929, "XAG": 0.04202829, "DJF": 177.827972, "MMK": 2100.175657, "BYN": 3.301823, "BZD": 2.015855, "LAK": 20538.284497, "GIP": 0.784929, "DOP": 57.999275, "BBD": 2.0, "CDF": 2730.189542, "CLF": 0.031713
}
}
""".data(using: .utf8)

open class DecoderMock {
    private var decoder = JSONDecoder()
    
    func getConversionMock() -> ConversionRates {
        let conversion = try! self.decoder.decode(ConversionRates.self, from: conversionRatesMock!)
        return conversion
    }
    
    func getCurrenciesMock() -> Currency {
        let currencies = try! self.decoder.decode(Currency.self, from: currenciesMock!)
        return currencies
    }
}
