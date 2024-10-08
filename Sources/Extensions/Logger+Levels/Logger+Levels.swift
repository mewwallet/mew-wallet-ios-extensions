//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/14/22.
//

import Foundation
import os

public extension Logger {
  func trace(error: any Error) { self.trace(message: error.localizedDescription) }
  func debug(error: any Error) { self.debug(message: error.localizedDescription) }
  func info(error: any Error) { self.info(message: error.localizedDescription) }
  func notice(error: any Error) { self.notice(message: error.localizedDescription) }
  func warning(error: any Error) { self.warning(message: error.localizedDescription) }
  func error(error: any Error) { self.error(message: error.localizedDescription) }
  func critical(error: any Error) { self.critical(message: error.localizedDescription) }
  
  func trace(message: String) {
#if DEBUG
    self.trace("[T]⬜️ \(message)")
#endif
  }
  
  func debug(message: String) {
#if DEBUG
    self.debug("[D]🟪 \(message)")
#endif
  }
  
  func info(message: String) {
#if DEBUG
    self.info("[I]🟦 \(message)")
#endif
  }
  
  func notice(message: String) {
#if DEBUG
    self.notice("[N]🟩 \(message)")
#endif
  }
  
  func warning(message: String) {
#if DEBUG
    self.warning("[W]🟨 \(message)")
#endif
  }
  
  func error(message: String) {
#if DEBUG
    self.error("[E]🟧 \(message)")
#endif
  }
  
  func critical(message: String) {
#if DEBUG
    self.critical("[C]🟥 \(message)")
#endif
  }
  
  func trace(file: String, line: Int, function: String, _ error: any Error) { self.trace(file: file, line: line, function: function, message: error.localizedDescription) }
  func debug(file: String, line: Int, function: String, _ error: any Error) { self.debug(file: file, line: line, function: function, message: error.localizedDescription) }
  func info(file: String, line: Int, function: String, _ error: any Error) { self.info(file: file, line: line, function: function, message: error.localizedDescription) }
  func notice(file: String, line: Int, function: String, _ error: any Error) { self.notice(file: file, line: line, function: function, message: error.localizedDescription) }
  func warning(file: String, line: Int, function: String, _ error: any Error) { self.warning(file: file, line: line, function: function, message: error.localizedDescription) }
  func error(file: String, line: Int, function: String, _ error: any Error) { self.error(file: file, line: line, function: function, message: error.localizedDescription) }
  func critical(file: String, line: Int, function: String, _ error: any Error) { self.critical(file: file, line: line, function: function, message: error.localizedDescription) }
  
  func trace(file: String, line: Int, function: String, message: String) {
#if DEBUG
    self.trace("[T]⬜️ \(file):\(function):\(line) \(message)")
#endif
  }
  
  func debug(file: String, line: Int, function: String, message: String) {
#if DEBUG
    self.debug("[D]🟪 \(file):\(function):\(line) \(message)")
#endif
  }
  
  func info(file: String, line: Int, function: String, message: String) {
#if DEBUG
    self.info("[I]🟦 \(file):\(function):\(line) \(message)")
#endif
  }
  
  func notice(file: String, line: Int, function: String, message: String) {
#if DEBUG
    self.notice("[N]🟩 \(file):\(function):\(line) \(message)")
#endif
  }
  
  func warning(file: String, line: Int, function: String, message: String) {
#if DEBUG
    self.warning("[W]🟨 \(file):\(function):\(line) \(message)")
#endif
  }
  
  func error(file: String, line: Int, function: String, message: String) {
#if DEBUG
    self.error("[E]🟧 \(file):\(function):\(line) \(message)")
#endif
  }
  
  func critical(file: String, line: Int, function: String, message: String) {
#if DEBUG
    self.critical("[C]🟥 \(file):\(function):\(line) \(message)")
#endif
  }
}
