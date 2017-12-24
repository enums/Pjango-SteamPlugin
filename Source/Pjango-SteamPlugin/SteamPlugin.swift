//
//  SteamPlugin.swift
//  Calatrava
//
//  Created by 郑宇琦 on 2017/12/24.
//

import Foundation
import Pjango
import PerfectHTTP

class SteamPlugin: PCHTTPFilterPlugin {
    
    override func responseFilterBody(req: HTTPRequest, res: HTTPResponse) -> Bool {
        guard var body = String.init(bytes: res.bodyBytes, encoding: .utf8) else {
            return true
        }
        if steamBackgroundImageURL != "" {
            let style = "<style>body:before {content: ' ';position: fixed;z-index: -1;top: 0;right: 0;bottom: 0;left: 0;background: url(\"\(steamBackgroundImageURL)\") center center no-repeat;background-size: cover;}</style>"
            body = body.replacingOccurrences(of: "<body class=\"main\">", with: "\(style)\n<body class=\"main\" style=\"background: url('\(steamBackgroundImageURL)') fixed center center no-repeat; background-size: cover\">")
        }
        if steamHeadImageURL != "" {
            body = body.replacingOccurrences(of: "src=\"/img/head_128.png\"", with: "src=\"\(steamHeadImageURL)\"")
        }
        _ = res.setBody(string: body)
        return true
    }
    
    override func responseFilterHeader(req: HTTPRequest, res: HTTPResponse) -> Bool {
        _ = res.setHeader(HTTPResponseHeader.Name.contentLength, value: "\(res.bodyBytes.count + 1024)")
        return true
    }

}
