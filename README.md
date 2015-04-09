# ColorLogger
Colorful log for Xcode in Swift project

This library is inspired by [XCGLogger](https://github.com/DaveWoodCom/XCGLogger), [XcodeColors](https://github.com/DaveWoodCom/XCGLogger)

### * Now Xcode6.3 not Available. "Color ESCAPE code" is escaped by Xcode6.3

### How to use

Add ColorLogger.swift in your Swift project.

In your AppDelegate, declare a global constant to the default ColorLogger instance.

```swift
let log = ColorLogger.defaultInstance
```

Then whenever you'd like to log something

```swift
log.verbose("This is Verbose Log")
log.debug("This is Debug Log")
log.info("This is Info Log")
log.warning("This is Warning Log")
log.error("This is Error Log")
```

your console shown like below

![screenshot](https://raw.githubusercontent.com/nishiyamaosamu/ColorLogger/master/screenshot.png)

### Optional

Available to change output log level. Default is .Debug

```swift
log.outputLogLevel = .Warning
```

Change some showing setting, default is all true

```swift
log.showLogLevel = true
log.showFileInfo = false
log.showFunctionName = true
log.showDate = false
```


Disable logging

```swift
log.outputLogLevel = .None
```
