//
//  SteamPullPlugin.swift
//  Calatrava
//
//  Created by 郑宇琦 on 2017/12/24.
//

import Foundation
import Pjango
import PerfectCURL

var steamBackgroundImageURL = ""
var steamHeadImageURL = ""

class SteamPullPlugin: PCTimerPlugin {
    
    static let steamHomeURL = "http://steamcommunity.com/id/enums/"
    
    override var timerInterval: TimeInterval {
        return 3600 * 1
    }
    
    override var task: PCTask? {
        return {
            guard let html = self.pullWebHTML() else {
                return
            }
            steamBackgroundImageURL = self.getBackgroundImageURL(from: html) ?? ""
            steamHeadImageURL = self.getHeadImageURL(from: html) ?? ""
        }
    }

    internal func getBackgroundImageURL(from html: String) -> String? {
        var html = html
        guard let begin = html.range(of: "<div class=\"no_header profile_page has_profile_background \" style=\"background-image: url( '")?.upperBound else {
            return nil
        }
        html = html.substring(from: begin)
        guard let end = html.range(of: "' );\">")?.lowerBound else {
            return nil
        }
        return html.substring(to: end)
    }
    
    internal func getHeadImageURL(from html: String) -> String? {
        var html = html
        guard let begin = html.range(of: "<div class=\"playerAvatarAutoSizeInner\"><img src=\"")?.upperBound else {
            return nil
        }
        html = html.substring(from: begin)
        guard let end = html.range(of: "\"></div>")?.lowerBound else {
            return nil
        }
        return html.substring(to: end)
    }
    
    internal func pullWebHTML() -> String? {
        let url = CURL.init(url: SteamPullPlugin.steamHomeURL)
        let (_, _, bytes) = url.performFully()
        return String.init(bytes: bytes, encoding: .utf8)
    }
}
