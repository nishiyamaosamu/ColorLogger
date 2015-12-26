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
    public var showFunctionName = true
    
    private func logln(logMessage: [AnyObject?], logLevel: LogLevel, functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__) {
        
        if self.isEnabledForLogLevel(logLevel) {
            var logMessageStr = ""
            var LogLevelStr = ""
            var FileInfoStr = ""
            var FunctionNameStr = ""
            var DateTimeStr = ""
            var output = ""

            logMessage.forEach{
                if $0 == nil {
                    logMessageStr += "nil"
                }else{
                    logMessageStr += $0!.description
                }
                logMessageStr += " "
            }
            
            
            if self.showLogLevel {
                LogLevelStr = "[" + logLevel.description() + "] "
            }

            if self.showFileInfo {
                FileInfoStr = "[" + (fileName as NSString).lastPathComponent + ":" + String(lineNumber) + "] "
            }
            
            if self.showFunctionName {
                FunctionNameStr = functionName + " "
            }

            if self.showDate {
                let now = NSDate()
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = self.dateFormatter
                DateTimeStr = dateFormatter.stringFromDate(now)
            }
            
            switch logLevel {
            case .Verbose:
                output += ColorLogStr.gray(LogLevelStr + logMessageStr)
            case .Debug:
                output += ColorLogStr.blue(LogLevelStr + logMessageStr)
            case .Info:
                output += ColorLogStr.cyan(LogLevelStr + logMessageStr)
            case .Warning:
                output += ColorLogStr.yellow(LogLevelStr + logMessageStr)
            case .Error:
                output += ColorLogStr.red(LogLevelStr + logMessageStr)
            default:
                output += LogLevelStr + logMessageStr
            }
            output += ColorLogStr.gray(FileInfoStr + FunctionNameStr + DateTimeStr)
            
            print(output)
        }
    }
    
    public func verbose(logMessage: AnyObject?..., functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__){
        
        self.logln(logMessage, logLevel: .Verbose, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    public func info(logMessage: AnyObject?..., functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__){
        self.logln(logMessage, logLevel: .Info, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    public func debug(logMessage: AnyObject?..., functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__){
        self.logln(logMessage, logLevel: .Debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    public func warning(logMessage: AnyObject?..., functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__){
        self.logln(logMessage, logLevel: .Warning, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    public func error(logMessage: AnyObject?..., functionName: String = __FUNCTION__, fileName: String = __FILE__, lineNumber: Int = __LINE__){
        self.logln(logMessage, logLevel: .Error, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    public func isEnabledForLogLevel(logLevel: ColorLogger.LogLevel) -> Bool {
        return logLevel.rawValue >= self.outputLogLevel.rawValue
    }
    
    struct ColorLogStr {
        static let ESCAPE = "\u{001b}["
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