//
//  ColorLogger.swift
//  pibo
//
//  Created by Osamu Nishiyama on 2015/04/08.
//  Copyright (c) 2015年 EVER SENSE, INC. All rights reserved.
//

import Foundation

public class ColorLogger {
    
    class var defaultInstance : ColorLogger {
        struct Singleton {
            static var instance = ColorLogger()
        }
        return Singleton.instance
    }
    
    public enum LogLevel : Int {
        case Verbose = 1
        case Debug
        case Info
        case Warning
        case Error
        case None
        
        public func description() -> String {
            switch self {
            case .Verbose:
                return "Verbose"
            case .Debug:
                return "Debug"
            case .Info:
                return "Info"
            case .Warning:
                return "Warning"
            case .Error:
                return "Error"
            case .None:
                return "None"
            }
        }
    }
    
    public var outputLogLevel: LogLevel = .Debug
    
    public var dateFormatter = "yyyy-MM-dd HH:mm:ss.SSS"
    
    public var showDate = true
    public var showLogLevel = true
    public var showFileInfo = true
    
    public func logln(logMessage: String, logLevel: LogLevel, functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__) {
        
        if self.isEnabledForLogLevel(logLevel) {
            var LogLevelStr: String = ""
            var FileInfoStr: String = ""
            var DateTimeStr: String = ""
            var output: String = ""
            
            if self.showLogLevel {
                LogLevelStr = "[" + logLevel.description() + "] "
            }

            if self.showFileInfo {
                FileInfoStr = "[" + fileName.lastPathComponent + ":" + String(lineNumber) + "] "
            }

            if self.showDate {
                let now = NSDate()
                let dateFormatter = NSDateFormatter()
                let locale = NSLocale.currentLocale()
                dateFormatter.dateFormat = self.dateFormatter
                DateTimeStr = dateFormatter.stringFromDate(now)
            }
            
            switch logLevel {
            case .Verbose:
                output += ColorLogStr.gray(LogLevelStr + logMessage + " ")
            case .Debug:
                output += ColorLogStr.blue(LogLevelStr + logMessage + " ")
            case .Info:
                output += ColorLogStr.cyan(LogLevelStr + logMessage + " ")
            case .Warning:
                output += ColorLogStr.yellow(LogLevelStr + logMessage + " ")
            case .Error:
                output += ColorLogStr.red(LogLevelStr + logMessage + " ")
            default:
                output += LogLevelStr + logMessage + " "
            }
            output += ColorLogStr.gray(FileInfoStr + DateTimeStr)
            
            println(output)
        }
    }
    
    public func verbose(logMessage: String, functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__){
        self.logln(logMessage, logLevel: .Verbose, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    public func info(logMessage: String, functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__){
        self.logln(logMessage, logLevel: .Info, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    public func debug(logMessage: String, functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__){
        self.logln(logMessage, logLevel: .Debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    public func warning(logMessage: String, functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__){
        self.logln(logMessage, logLevel: .Warning, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    public func error(logMessage: String, functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__){
        self.logln(logMessage, logLevel: .Error, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    public func isEnabledForLogLevel(logLevel: ColorLogger.LogLevel) -> Bool {
        return logLevel.rawValue >= self.outputLogLevel.rawValue
    }
    
    struct ColorLogStr {
        static let ESCAPE = "\u{001b}["
        static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
//        static let RESET_BG = ESCAPE + "bg;" // Clear any background color
        static let RESET = ESCAPE + ";"   // Clear any foreground or background color
        
        static func red(str: String) -> String {
            return "\(ESCAPE)fg220,50,47;\(str)\(RESET)"
        }
        
        static func cyan(str: String) -> String {
            return "\(ESCAPE)fg42,161,152;\(str)\(RESET)"
        }
        
        static func blue(str: String) -> String {
            return "\(ESCAPE)fg38,139,210;\(str)\(RESET)"
        }
        
        static func yellow(str: String) -> String {
            return "\(ESCAPE)fg181,137,0;\(str)\(RESET)"
        }
        
        static func gray(str: String) -> String {
            return "\(ESCAPE)fg88,110,117;\(str)\(RESET)"
        }
        
    }
}