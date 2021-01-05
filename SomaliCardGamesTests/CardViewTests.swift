//
//  CardViewTests.swift
//  SomaliCardGamesTests
//
//  Created by unitlabs on 1/4/21.
//  Copyright © 2021 sarakhater. All rights reserved.
//

@testable import SomaliCardGames
import XCTest

class CardViewTests: XCTestCase {
    
    var cardController : CardViewController!
    var filePath : String!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cardController = CardViewController()
        filePath = "\(5)text"
    }
    
    func testReadWordsCorrect(){
        cardController.ReadWords(filePath: filePath)
        XCTAssertNotNil(cardController.m_wordsList, " file exist and reads it successfully ")
    }
    
    func testWordListIsEmpty(){
        filePath = "\(7)text"
        cardController.ReadWords(filePath: filePath)
        XCTAssertEqual(cardController.m_wordsList.isEmpty, true)
    }
    
    func testWordListIsNotEmpty(){
          cardController.ReadWords(filePath: filePath)
          XCTAssertNotEqual(cardController.m_wordsList.isEmpty, true)
      }
    
    func testcheckRandomNoExistInWordList(){
         cardController.ReadWords(filePath: filePath)
        let wordCount = cardController.m_wordsList.count - 1;
        let x = Int.random(in: 0 ... wordCount);
         XCTAssertTrue( 0...wordCount ~= x)
    }
    
   
    
    
   
}
