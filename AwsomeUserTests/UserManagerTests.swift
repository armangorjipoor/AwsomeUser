//
//  UserManagerTests.swift
//  AwsomeUserTests
//
//  Created by Arman Gorj on 11/8/1401 AP.
//

import XCTest
@testable import AwsomeUser

final class UserManagerTests: XCTestCase {

    var sut: UserManager!
    
    override func setUp() {
        super.setUp()
        sut = UserManager()
    }
    
    func test_create_user() {
        //given
        let mockUser = User(fullName: "Test Name",
                            userName: "Test UserName",
                            password: 11, id: UUID())
        //when
        sut.createUser(user: mockUser)
        let createdUser = sut.fetchUserBy(userName: "Test UserName")
        
        //Then
        XCTAssertEqual("Test Name", createdUser!.fullName )
        
    }
    
    func test_fail_user_creation() {
        // given
        let registeredUserName = "Test UserName"

        //when
        let result = sut.checkForUserExistentBy(userName: "Test UserName")
        
        //then
        XCTAssert(result, "Can not check for duplicate")
    }
    
    func test_fetch_by_user_password() {
        // given
        let registeredUserName = "Test UserName"
        let passWord           = 11
        
        //when
        let result = sut.fetchUser(by: registeredUserName, password: Int16(passWord))
        
        //then
        XCTAssertNotNil(result, "Can not fetch user by user and pass")
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UserManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
