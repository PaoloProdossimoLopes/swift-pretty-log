//
//  LOG.swift
//  swift-firebase-analytics
//
//  Created by Paolo Prodossimo Lopes on 04/06/22.
//

import Foundation

struct LOG {
    static func DEBUG(
        _ option: Options, style: Style = .standart,
        file: String = #file,
        method: String = #function,
        line: Int = #line
    ) {
        var desc: String = .init()
        var icon: String = .init()
        var message: String = .init()
        let date: String = format(Constant.dateFormat)
        let time: String = format(Constant.timeFormat)
        let fileName = NSString(string: file).lastPathComponent
        let thread: String = Thread.isMainThread ? Constant.main : Constant.background
        
        desc = descriptionHandle(style)
        
        switch option {
        case .API(let state):
            (icon, message) = stateHandle(state)
            
        case .TODO(let text):
            icon = Constant.todoIcon
            message = text
            
        case .ERROR(let text):
            icon = Constant.errorIcon
            message = text
            
        case .WARNING(let text):
            icon = Constant.warningIcon
            message = text
            
        case .SUCCESS(let text):
            icon = Constant.successIcon
            message = text
            
        case .ln(let text):
            icon = .empty
            message = .empty
            desc = text
        }
        
        let formatted = desc
            .replacingOccurrences(of: Constant.icon, with: icon)
            .replacingOccurrences(of: Constant.date, with: "\(date) at \(time)")
            .replacingOccurrences(of: Constant.thread, with: thread)
            .replacingOccurrences(of: Constant.file, with: fileName)
            .replacingOccurrences(of: Constant.line, with: "\(line)")
            .replacingOccurrences(of: Constant.function, with: method)
            .replacingOccurrences(of: Constant.description, with: message)
        
        print(formatted)
        
    }
    
}

//MARK: - Helpers
private extension LOG {
    private static func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: .now)
    }
    
    private static func descriptionHandle(_ style: Style) -> String {
        switch style {
        case .standart:
            return Constant.standartDescription
        case .abreviate:
            return Constant.abreviateDescription
        case .complete:
            return Constant.completeDescription
        }
    }
    
    private static func stateHandle(_ state: Options.State) -> (String, String) {
        let icon: String
        let message: String
        
        switch state {
        case .failure(let text):
            icon = Constant.failureStateIcon
            message = text
        case .success(let text):
            icon = Constant.successStateIcon
            message = text
        }
        
        return (icon, message)
    }
    
    //MARK: - Constants
    struct Constant {
        static let standartDescription: String = """
        | \(Self.icon):
        | [\(Self.date)] - [\(Self.thread) thread]
        | [\(Self.file) in \(Self.function), at line \(Self.line)]
        | DEBUG: \(Self.description)
        |______________________________________\n
        """
        
        static let abreviateDescription: String = """
        ----------------------------------------- - - -  -
        |DEBUG:> \(Self.date) [\(Self.icon)][\(Self.file)]:\(Self.line) \(Self.function) -> '\(Self.description)'
        ----------------------------------------- - - -  -
        """
        
        static let completeDescription: String = """
        | \(Self.icon)
        |------------------------ - - -  -
        | Thread: \(Self.thread)
        | Date: \(Self.date)
        | File: \(Self.file)
        | Method: \(Self.function)
        | Line: \(Self.line)
        |------------------------ - - -  -
        | DEBUG: \(Self.description)
        |________________________ _ _ _  _\n
        """
        
        static let icon = "{ICON}"
        static let description = "{DESCRIPTION}"
        static let date = "{DATE}"
        static let file = "{FILE}"
        static let function = "{FUNCTION}"
        static let line = "{LINE}"
        static let thread = "{THREAD}"
        
        static let main = "Main"
        static let background = "Background"
        static let dateFormat = "dd/MM/yyyy"
        static let timeFormat = "hh:mm:ss"
        
        static let successStateIcon = "📡 - Succeded"
        static let failureStateIcon = "📡 - Failed"
        static let todoIcon = "✏️ - TODO"
        static let errorIcon = "🛑 - Error"
        static let successIcon = "✅ - Success"
        static let warningIcon = "⚠️ - Warning"
    }
}
