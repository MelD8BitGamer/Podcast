//
//  PodcastTests.swift
//  PodcastTests
//
//  Created by Melinda Diaz on 12/17/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import XCTest
@testable import Podcast

class PodcastTests: XCTestCase {
    
    //arrange act and assert are the 3 A's needed to test
    func testTheFirstFunction() {
        //arrange is setup anything you need to do do it now whatever it needs to run
        //arrange your search query CANNOT HAVE SPACES OR YOU WILL DIE TRYING TO FIGURE THIS OUT!!!
        let searchQuery = "BobMarley"
        var podcastData = [Podcast]()
        //exp means expectation
        let exp = XCTestExpectation(description: "podcast returned")
        _ = podcastData.count
        
        //act
        ApplePodcast.getPodcasts(for: searchQuery) { result in
            switch result {
            case .failure:
                break
            case .success(let modelRef):
                podcastData = modelRef
                exp.fulfill()
                
                //assert
                XCTAssertGreaterThan(podcastData.count, 0, "\(podcastData.count) is not greater than \(0)")
            }
        }
        wait(for: [exp], timeout: 5)
    }
    
}
