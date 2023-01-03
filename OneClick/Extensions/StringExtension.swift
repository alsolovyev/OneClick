//
//  StringExtension.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 02.01.2023.
//

import OSAKit


extension String {
    func runScript(_ asAdmin: Bool = false) throws -> String {
        var source: String = "do shell script \"\(self)\""
        
        if (asAdmin) {
            source += " with prompt \"OneClick\" with administrator privileges"
        }
        
        let process = Process()
        process.arguments = ["-e", source]
        process.launchPath = "/usr/bin/osascript"
        process.standardInput = nil
        
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        
        do {
            try process.run()
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            return String(decoding: outputData, as: UTF8.self)
        } catch {
            throw OneClickError.ScriptFailed
        }
    }
}
