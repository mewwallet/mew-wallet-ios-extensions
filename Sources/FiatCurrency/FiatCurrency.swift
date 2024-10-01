//
//  File.swift
//  mew-wallet-ios-extensions
//
//  Created by Mikhail Nikanorov on 10/1/24.
//

import Foundation

internal let FiatCurrencyMap: [String: FiatCurrency] = [
  "AED": .aed, "AFN": .afn, "ALL": .all, "AMD": .amd, "ANG": .ang, "AOA": .aoa,
  "ARS": .ars, "AUD": .aud, "AWG": .awg, "AZN": .azn, "BAM": .bam, "BBD": .bbd,
  "BDT": .bdt, "BGN": .bgn, "BHD": .bhd, "BIF": .bif, "BMD": .bmd, "BND": .bnd,
  "BOB": .bob, "BRL": .brl, "BSD": .bsd, "BTC": .btc, "BTN": .btn, "BWP": .bwp,
  "BYN": .byn, "BYR": .byr, "BZD": .bzd, "CAD": .cad, "CDF": .cdf, "CHF": .chf,
  "CLF": .clf, "CLP": .clp, "CNY": .cny, "COP": .cop, "CRC": .crc, "CUC": .cuc,
  "CUP": .cup, "CVE": .cve, "CZK": .czk, "DJF": .djf, "DKK": .dkk, "DOP": .dop,
  "DZD": .dzd, "EGP": .egp, "ERN": .ern, "ETB": .etb, "EUR": .eur, "FJD": .fjd,
  "FKP": .fkp, "GBP": .gbp, "GEL": .gel, "GGP": .ggp, "GHS": .ghs, "GIP": .gip,
  "GMD": .gmd, "GNF": .gnf, "GTQ": .gtq, "GYD": .gyd, "HKD": .hkd, "HNL": .hnl,
  "HRK": .hrk, "HTG": .htg, "HUF": .huf, "IDR": .idr, "ILS": .ils, "IMP": .imp,
  "INR": .inr, "IQD": .iqd, "IRR": .irr, "ISK": .isk, "JEP": .jep, "JMD": .jmd,
  "JOD": .jod, "JPY": .jpy, "KES": .kes, "KGS": .kgs, "KHR": .khr, "KMF": .kmf,
  "KPW": .kpw, "KRW": .krw, "KWD": .kwd, "KYD": .kyd, "KZT": .kzt, "LAK": .lak,
  "LBP": .lbp, "LKR": .lkr, "LRD": .lrd, "LSL": .lsl, "LTL": .ltl, "LVL": .lvl,
  "LYD": .lyd, "MAD": .mad, "MDL": .mdl, "MGA": .mga, "MKD": .mkd, "MMK": .mmk,
  "MNT": .mnt, "MOP": .mop, "MRO": .mro, "MUR": .mur, "MVR": .mvr, "MWK": .mwk,
  "MXN": .mxn, "MYR": .myr, "MZN": .mzn, "NAD": .nad, "NGN": .ngn, "NIO": .nio,
  "NOK": .nok, "NPR": .npr, "NZD": .nzd, "OMR": .omr, "PAB": .pab, "PEN": .pen,
  "PGK": .pgk, "PHP": .php, "PKR": .pkr, "PLN": .pln, "PYG": .pyg, "QAR": .qar,
  "RON": .ron, "RSD": .rsd, "RUB": .rub, "RWF": .rwf, "SAR": .sar, "SBD": .sbd,
  "SCR": .scr, "SDG": .sdg, "SEK": .sek, "SGD": .sgd, "SHP": .shp, "SLL": .sll,
  "SOS": .sos, "SRD": .srd, "STD": .std, "SVC": .svc, "SYP": .syp, "SZL": .szl,
  "THB": .thb, "TJS": .tjs, "TMT": .tmt, "TND": .tnd, "TOP": .top, "TRY": .try,
  "TTD": .ttd, "TWD": .twd, "TZS": .tzs, "UAH": .uah, "UGX": .ugx, "USD": .usd,
  "UYU": .uyu, "UZS": .uzs, "VEF": .vef, "VND": .vnd, "VUV": .vuv, "WST": .wst,
  "XAF": .xaf, "XAG": .xag, "XAU": .xau, "XCD": .xcd, "XDR": .xdr, "XOF": .xof,
  "XPF": .xpf, "YER": .yer, "ZAR": .zar, "ZMK": .zmk, "ZMW": .zmw, "ZWL": .zwl
]

public enum FiatCurrency: String, Sendable {
  case aed    = "AED"
  case afn    = "AFN"
  case all    = "ALL"
  case amd    = "AMD"
  case ang    = "ANG"
  case aoa    = "AOA"
  case ars    = "ARS"
  case aud    = "AUD"
  case awg    = "AWG"
  case azn    = "AZN"
  case bam    = "BAM"
  case bbd    = "BBD"
  case bdt    = "BDT"
  case bgn    = "BGN"
  case bhd    = "BHD"
  case bif    = "BIF"
  case bmd    = "BMD"
  case bnd    = "BND"
  case bob    = "BOB"
  case brl    = "BRL"
  case bsd    = "BSD"
  case btc    = "BTC"
  case btn    = "BTN"
  case bwp    = "BWP"
  case byn    = "BYN"
  case byr    = "BYR"
  case bzd    = "BZD"
  case cad    = "CAD"
  case cdf    = "CDF"
  case chf    = "CHF"
  case clf    = "CLF"
  case clp    = "CLP"
  case cny    = "CNY"
  case cop    = "COP"
  case crc    = "CRC"
  case cuc    = "CUC"
  case cup    = "CUP"
  case cve    = "CVE"
  case czk    = "CZK"
  case djf    = "DJF"
  case dkk    = "DKK"
  case dop    = "DOP"
  case dzd    = "DZD"
  case egp    = "EGP"
  case ern    = "ERN"
  case etb    = "ETB"
  case eur    = "EUR"
  case fjd    = "FJD"
  case fkp    = "FKP"
  case gbp    = "GBP"
  case gel    = "GEL"
  case ggp    = "GGP"
  case ghs    = "GHS"
  case gip    = "GIP"
  case gmd    = "GMD"
  case gnf    = "GNF"
  case gtq    = "GTQ"
  case gyd    = "GYD"
  case hkd    = "HKD"
  case hnl    = "HNL"
  case hrk    = "HRK"
  case htg    = "HTG"
  case huf    = "HUF"
  case idr    = "IDR"
  case ils    = "ILS"
  case imp    = "IMP"
  case inr    = "INR"
  case iqd    = "IQD"
  case irr    = "IRR"
  case isk    = "ISK"
  case jep    = "JEP"
  case jmd    = "JMD"
  case jod    = "JOD"
  case jpy    = "JPY"
  case kes    = "KES"
  case kgs    = "KGS"
  case khr    = "KHR"
  case kmf    = "KMF"
  case kpw    = "KPW"
  case krw    = "KRW"
  case kwd    = "KWD"
  case kyd    = "KYD"
  case kzt    = "KZT"
  case lak    = "LAK"
  case lbp    = "LBP"
  case lkr    = "LKR"
  case lrd    = "LRD"
  case lsl    = "LSL"
  case ltl    = "LTL"
  case lvl    = "LVL"
  case lyd    = "LYD"
  case mad    = "MAD"
  case mdl    = "MDL"
  case mga    = "MGA"
  case mkd    = "MKD"
  case mmk    = "MMK"
  case mnt    = "MNT"
  case mop    = "MOP"
  case mro    = "MRO"
  case mur    = "MUR"
  case mvr    = "MVR"
  case mwk    = "MWK"
  case mxn    = "MXN"
  case myr    = "MYR"
  case mzn    = "MZN"
  case nad    = "NAD"
  case ngn    = "NGN"
  case nio    = "NIO"
  case nok    = "NOK"
  case npr    = "NPR"
  case nzd    = "NZD"
  case omr    = "OMR"
  case pab    = "PAB"
  case pen    = "PEN"
  case pgk    = "PGK"
  case php    = "PHP"
  case pkr    = "PKR"
  case pln    = "PLN"
  case pyg    = "PYG"
  case qar    = "QAR"
  case ron    = "RON"
  case rsd    = "RSD"
  case rub    = "RUB"
  case rwf    = "RWF"
  case sar    = "SAR"
  case sbd    = "SBD"
  case scr    = "SCR"
  case sdg    = "SDG"
  case sek    = "SEK"
  case sgd    = "SGD"
  case shp    = "SHP"
  case sll    = "SLL"
  case sos    = "SOS"
  case srd    = "SRD"
  case std    = "STD"
  case svc    = "SVC"
  case syp    = "SYP"
  case szl    = "SZL"
  case thb    = "THB"
  case tjs    = "TJS"
  case tmt    = "TMT"
  case tnd    = "TND"
  case top    = "TOP"
  case `try`  = "TRY"
  case ttd    = "TTD"
  case twd    = "TWD"
  case tzs    = "TZS"
  case uah    = "UAH"
  case ugx    = "UGX"
  case usd    = "USD"
  case uyu    = "UYU"
  case uzs    = "UZS"
  case vef    = "VEF"
  case vnd    = "VND"
  case vuv    = "VUV"
  case wst    = "WST"
  case xaf    = "XAF"
  case xag    = "XAG"
  case xau    = "XAU"
  case xcd    = "XCD"
  case xdr    = "XDR"
  case xof    = "XOF"
  case xpf    = "XPF"
  case yer    = "YER"
  case zar    = "ZAR"
  case zmk    = "ZMK"
  case zmw    = "ZMW"
  case zwl    = "ZWL"
  case unknown
  
  public init?(rawValue: String) {
    self = FiatCurrencyMap[rawValue.uppercased()] ?? .unknown
  }
  
  public init(currencyCode code: String) {
    self = FiatCurrencyMap[code.uppercased()] ?? .unknown
  }
  
  public var decimals: Int {
    switch self {
    case .usd:    return 2
    case .rub:    return 2
    case .eur:    return 2
    case .jpy:    return 2
    default:      return 2
    }
  }
}

