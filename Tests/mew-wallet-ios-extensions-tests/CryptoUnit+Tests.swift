import Foundation
import Testing

@testable import mew_wallet_ios_extensions

@Suite("CryptoUnit tests")
struct CryptoUnitTests {
  
  @Test("Bitcoin unit decimals")
  func bitcoinUnitDecimals() {
    #expect(CryptoUnit.satoshi.decimals == Decimal(1))
    #expect(CryptoUnit.bitcoin.decimals == Decimal(sign: .plus, exponent: -8, significand: Decimal(1)))
  }
  
  @Test("Ethereum unit decimals")
  func ethereumUnitDecimals() {
    #expect(CryptoUnit.wei.decimals == Decimal(1))
    #expect(CryptoUnit.kwei.decimals == Decimal(sign: .plus, exponent: -3, significand: Decimal(1)))
    #expect(CryptoUnit.mwei.decimals == Decimal(sign: .plus, exponent: -6, significand: Decimal(1)))
    #expect(CryptoUnit.gwei.decimals == Decimal(sign: .plus, exponent: -9, significand: Decimal(1)))
    #expect(CryptoUnit.szabo.decimals == Decimal(sign: .plus, exponent: -12, significand: Decimal(1)))
    #expect(CryptoUnit.finney.decimals == Decimal(sign: .plus, exponent: -15, significand: Decimal(1)))
    #expect(CryptoUnit.ether.decimals == Decimal(sign: .plus, exponent: -18, significand: Decimal(1)))
    #expect(CryptoUnit.kether.decimals == Decimal(sign: .plus, exponent: -21, significand: Decimal(1)))
    #expect(CryptoUnit.mether.decimals == Decimal(sign: .plus, exponent: -24, significand: Decimal(1)))
    #expect(CryptoUnit.gether.decimals == Decimal(sign: .plus, exponent: -27, significand: Decimal(1)))
    #expect(CryptoUnit.tether.decimals == Decimal(sign: .plus, exponent: -30, significand: Decimal(1)))
  }
  
  @Test("Solana unit decimals")
  func solanaUnitDecimals() {
    #expect(CryptoUnit.lamport.decimals == Decimal(1))
    #expect(CryptoUnit.sol.decimals == Decimal(sign: .plus, exponent: -9, significand: Decimal(1)))
  }
  
  @Test("Custom unit decimals")
  func customUnitDecimals() {
    #expect(CryptoUnit.custom(0).decimals == Decimal(1))
    #expect(CryptoUnit.custom(6).decimals == Decimal(sign: .plus, exponent: -6, significand: Decimal(1)))
    #expect(CryptoUnit.custom(18).decimals == Decimal(sign: .plus, exponent: -18, significand: Decimal(1)))
  }
  
  @Test("Bitcoin conversions")
  func bitcoinConversions() {
    // 1 Bitcoin = 100,000,000 Satoshis
    let oneBitcoin = Decimal(1)
    let satoshisInBitcoin = CryptoUnit.convert(amount: oneBitcoin, from: .bitcoin, to: .satoshi)
    #expect(satoshisInBitcoin == Decimal(100_000_000))
    
    // 100,000,000 Satoshis = 1 Bitcoin
    let satoshis = Decimal(100_000_000)
    let bitcoinFromSatoshis = CryptoUnit.convert(amount: satoshis, from: .satoshi, to: .bitcoin)
    #expect(bitcoinFromSatoshis == Decimal(1))
    
    // 0.5 Bitcoin = 50,000,000 Satoshis
    let halfBitcoin = Decimal(0.5)
    let satoshisInHalfBitcoin = CryptoUnit.convert(amount: halfBitcoin, from: .bitcoin, to: .satoshi)
    #expect(satoshisInHalfBitcoin == Decimal(50_000_000))
  }
  
  @Test("Ethereum conversions")
  func ethereumConversions() {
    // 1 Ether = 1,000,000,000,000,000,000 Wei (1e18)
    let oneEther = Decimal(1)
    let weiInEther = CryptoUnit.convert(amount: oneEther, from: .ether, to: .wei)
    #expect(weiInEther == Decimal(1_000_000_000_000_000_000))
    
    // 1,000,000,000,000,000,000 Wei = 1 Ether
    let wei = Decimal(1_000_000_000_000_000_000)
    let etherFromWei = CryptoUnit.convert(amount: wei, from: .wei, to: .ether)
    #expect(etherFromWei == Decimal(1))
    
    // 1 Gwei = 1,000,000,000 Wei
    let oneGwei = Decimal(1)
    let weiInGwei = CryptoUnit.convert(amount: oneGwei, from: .gwei, to: .wei)
    #expect(weiInGwei == Decimal(1_000_000_000))
    
    // 1 Ether = 1,000,000,000 Gwei
    let gweiInEther = CryptoUnit.convert(amount: oneEther, from: .ether, to: .gwei)
    #expect(gweiInEther == Decimal(1_000_000_000))
  }
  
  @Test("Solana conversions")
  func solanaConversions() {
    // 1 SOL = 1,000,000,000 Lamports (1e9)
    let oneSol = Decimal(1)
    let lamportsInSol = CryptoUnit.convert(amount: oneSol, from: .sol, to: .lamport)
    #expect(lamportsInSol == Decimal(1_000_000_000))
    
    // 1,000,000,000 Lamports = 1 SOL
    let lamports = Decimal(1_000_000_000)
    let solFromLamports = CryptoUnit.convert(amount: lamports, from: .lamport, to: .sol)
    #expect(solFromLamports == Decimal(1))
    
    // 0.5 SOL = 500,000,000 Lamports
    let halfSol = Decimal(0.5)
    let lamportsInHalfSol = CryptoUnit.convert(amount: halfSol, from: .sol, to: .lamport)
    #expect(lamportsInHalfSol == Decimal(500_000_000))
    
    // 2.5 SOL = 2,500,000,000 Lamports
    let twoAndHalfSol = Decimal(2.5)
    let lamportsInTwoAndHalfSol = CryptoUnit.convert(amount: twoAndHalfSol, from: .sol, to: .lamport)
    #expect(lamportsInTwoAndHalfSol == Decimal(2_500_000_000))
  }
  
  @Test("Cross-chain conversions")
  func crossChainConversions() {
    // Test conversions between different cryptocurrencies
    // This is mainly for testing the conversion logic, not for actual cross-chain rates
    
    // 1 SOL to lamports (should be 1e9)
    let solToLamports = CryptoUnit.sol.convert(amount: Decimal(1), to: .lamport)
    #expect(solToLamports == Decimal(1_000_000_000))
    
    // 1 Bitcoin to satoshis (should be 1e8)
    let bitcoinToSatoshis = CryptoUnit.bitcoin.convert(amount: Decimal(1), to: .satoshi)
    #expect(bitcoinToSatoshis == Decimal(100_000_000))
    
    // 1 Ether to wei (should be 1e18)
    let etherToWei = CryptoUnit.ether.convert(amount: Decimal(1), to: .wei)
    #expect(etherToWei == Decimal(1_000_000_000_000_000_000))
  }
  
  @Test("Custom unit conversions")
  func customUnitConversions() {
    // Test custom units with different decimal places
    let custom6 = CryptoUnit.custom(6)
    let custom18 = CryptoUnit.custom(18)
    
    // 1 unit of custom(6) = 1,000,000 units of base
    let oneCustom6 = Decimal(1)
    let baseFromCustom6 = CryptoUnit.convert(amount: oneCustom6, from: custom6, to: .custom(0))
    #expect(baseFromCustom6 == Decimal(1_000_000))
    
    // 1 unit of custom(18) = 1,000,000,000,000,000,000 units of base
    let oneCustom18 = Decimal(1)
    let baseFromCustom18 = CryptoUnit.convert(amount: oneCustom18, from: custom18, to: .custom(0))
    #expect(baseFromCustom18 == Decimal(1_000_000_000_000_000_000))
  }
  
  @Test("Default parameter behavior")
  func defaultParameterBehavior() {
    // Test that the default 'from' parameter is wei
    let weiAmount = Decimal(1_000_000_000_000_000_000) // 1 Ether in wei
    let etherAmount = CryptoUnit.convert(amount: weiAmount, to: .ether)
    #expect(etherAmount == Decimal(1))
    
    // Test with explicit 'from' parameter
    let etherAmountExplicit = CryptoUnit.convert(amount: weiAmount, from: .wei, to: .ether)
    #expect(etherAmountExplicit == Decimal(1))
  }
  
  @Test("Edge cases")
  func edgeCases() {
    // Test zero amounts
    let zeroAmount = Decimal(0)
    let zeroConversion = CryptoUnit.convert(amount: zeroAmount, from: .sol, to: .lamport)
    #expect(zeroConversion == Decimal(0))
    
    // Test very small amounts
    let smallAmount = Decimal(0.000000001) // 1 nano SOL
    let smallConversion = CryptoUnit.convert(amount: smallAmount, from: .sol, to: .lamport)
    #expect(smallConversion == Decimal(1))
    
    // Test very large amounts
    let largeAmount = Decimal(1_000_000) // 1 million SOL
    let largeConversion = CryptoUnit.convert(amount: largeAmount, from: .sol, to: .lamport)
    #expect(largeConversion == Decimal(1_000_000_000_000_000))
  }
  
  @Test("Decimal extension conversions")
  func decimalExtensionConversions() {
    // Test the Decimal extension with Solana units
    let oneSol = Decimal(1)
    let lamportsFromSol = oneSol.convert(from: .sol, to: .lamport)
    #expect(lamportsFromSol == Decimal(1_000_000_000))
    
    let lamports = Decimal(1_000_000_000)
    let solFromLamports = lamports.convert(from: .lamport, to: .sol)
    #expect(solFromLamports == Decimal(1))
    
    // Test with default parameter (wei)
    let weiAmount = Decimal(1_000_000_000_000_000_000) // 1 Ether in wei
    let etherAmount = weiAmount.convert(to: .ether)
    #expect(etherAmount == Decimal(1))
    
    // Test Bitcoin with Decimal extension
    let oneBitcoin = Decimal(1)
    let satoshisFromBitcoin = oneBitcoin.convert(from: .bitcoin, to: .satoshi)
    #expect(satoshisFromBitcoin == Decimal(100_000_000))
  }
}
