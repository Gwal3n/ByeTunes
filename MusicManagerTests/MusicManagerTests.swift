
import Testing
import Foundation
@testable import MusicManager

struct MusicManagerTests {

    @Test func transientDownloadErrorsAreRetried() {
        #expect(DownloadSupport.isTransientDownloadError(DownloadError.httpError(429, "busy")))
        #expect(DownloadSupport.isTransientDownloadError(DownloadError.httpError(503, "unavailable")))
        #expect(DownloadSupport.isTransientDownloadError(DownloadError.emptyResponse))
        #expect(DownloadSupport.isTransientDownloadError(URLError(.networkConnectionLost)))
    }

    @Test func permanentDownloadErrorsAreNotRetried() {
        #expect(!DownloadSupport.isTransientDownloadError(DownloadError.httpError(404, "missing")))
        #expect(!DownloadSupport.isTransientDownloadError(DownloadError.mappingFailed("no match")))
        #expect(!DownloadSupport.isTransientDownloadError(URLError(.cancelled)))
    }

}
