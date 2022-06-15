//
//  File.swift
//  
//
//  Created by Mikhail Nikanorov on 6/14/22.
//

import Foundation
import os

public extension Logger {
  func trace(error: Error) { self.trace(message: error.localizedDescription) }
  func debug(error: Error) { self.debug(message: error.localizedDescription) }
  func info(error: Error) { self.info(message: error.localizedDescription) }
  func notice(error: Error) { self.notice(message: error.localizedDescription) }
  func warning(error: Error) { self.warning(message: error.localizedDescription) }
  func error(error: Error) { self.error(message: error.localizedDescription) }
  func critical(error: Error) { self.critical(message: error.localizedDescription) }
  
  func trace(message: String) { self.trace("[T]⬜️ \(message)") }
  func debug(message: String) { self.debug("[D]🟪 \(message)") }
  func info(message: String) { self.info("[I]🟦 \(message)") }
  func notice(message: String) { self.notice("[N]🟩 \(message)") }
  func warning(message: String) { self.warning("[W]🟨 \(message)") }
  func error(message: String) { self.error("[E]🟧 \(message)") }
  func critical(message: String) { self.critical("[C]🟥 \(message)") }
  
  func trace(file: String, line: Int, function: String, _ error: Error) { self.trace(file: file, line: line, function: function, message: error.localizedDescription) }
  func debug(file: String, line: Int, function: String, _ error: Error) { self.debug(file: file, line: line, function: function, message: error.localizedDescription) }
  func info(file: String, line: Int, function: String, _ error: Error) { self.info(file: file, line: line, function: function, message: error.localizedDescription) }
  func notice(file: String, line: Int, function: String, _ error: Error) { self.notice(file: file, line: line, function: function, message: error.localizedDescription) }
  func warning(file: String, line: Int, function: String, _ error: Error) { self.warning(file: file, line: line, function: function, message: error.localizedDescription) }
  func error(file: String, line: Int, function: String, _ error: Error) { self.error(file: file, line: line, function: function, message: error.localizedDescription) }
  func critical(file: String, line: Int, function: String, _ error: Error) { self.critical(file: file, line: line, function: function, message: error.localizedDescription) }
  
  func trace(file: String, line: Int, function: String, message: String) { self.trace("[T]⬜️ \(file):\(function):\(line) \(message)") }
  func debug(file: String, line: Int, function: String, message: String) { self.debug("[D]🟪 \(file):\(function):\(line) \(message)") }
  func info(file: String, line: Int, function: String, message: String) { self.info("[I]🟦 \(file):\(function):\(line) \(message)") }
  func notice(file: String, line: Int, function: String, message: String) { self.notice("[N]🟩 \(file):\(function):\(line) \(message)") }
  func warning(file: String, line: Int, function: String, message: String) { self.warning("[W]🟨 \(file):\(function):\(line) \(message)") }
  func error(file: String, line: Int, function: String, message: String) { self.error("[E]🟧 \(file):\(function):\(line) \(message)") }
  func critical(file: String, line: Int, function: String, message: String) { self.critical("[C]🟥 \(file):\(function):\(line) \(message)") }
}
