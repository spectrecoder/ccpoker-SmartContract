// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../PokerManager/PokerManager.sol";
import "../PokerManager/ECC.sol";
import "../PokerManager/IBaseGame.sol";
import "../PokerManager/BitMaps.sol";
import "../PokerManager/Storage.sol";
/**
 * @title Shuffle Manager
 * @dev manage all ZK Games
 */
contract Poker is PokerManager, Storage {
    // invalid card index or player index
    uint256 public constant override INVALID_INDEX = 999999;

    constructor(
        address decryptVerifier_,
        address deck52EncVerifier
    ) {
        _deck52EncVerifier = deck52EncVerifier;
        decryptVerifier = IDecryptVerifier(decryptVerifier_);
    }


    /**
     * create a new shuffle game (call by the game contract)
     */
    function createShuffleGame(
        uint8 numPlayers
    ) external override returns (uint256) {
        uint256 newGameId = ++largestGameId;
        gameInfos[newGameId].numPlayers = numPlayers;

        // TODO: do we need to explicit start
        // an intialization logic of gameStates[newGameId]?
        _activeGames[newGameId] = msg.sender;

        ShuffleGameState storage state = gameStates[newGameId];
        state.state = BaseState.Created;

        // set up verifier contract according to deck type
        gameInfos[newGameId].encryptVerifier = IShuffleEncryptVerifier(
            _deck52EncVerifier
        );
        gameInfos[newGameId].numCards = 52;

        // init deck
        zkShuffleCrypto.initDeck(state.deck);
        return newGameId;
    }

    // transit to register player stage
    function register(uint256 gameId, bytes calldata next) external {

    }

    // player register 
    function playerRegister(
        uint256 gameId,
        address signingAddr,
        uint256 pkX,
        uint256 pkY
    ) external returns (uint256 pid) {
        return 1;
    }

    // deal a set of cards to a specific player
    // An error is thrown if dealCardsTo is called under any other states
    function dealCardsTo(
        uint256 gameId,
        BitMaps.BitMap256 memory cards,
        uint256 playerId,
        bytes calldata next
    ) external {

    }

    // shuffle the remaining deck, this will transit the base state to Shuffle
    function shuffle(uint256 gameId, bytes calldata next) external {

    }

    // specify a player to open a specified number of cards
    function openCards(
        uint256 gameId,
        uint256 playerId,
        uint8 openningNum,
        bytes calldata next
    ) external {

    }

    // transit to error state, game devs call specify error handling logic in the callback
    function error(uint256 gameId, bytes calldata next) external {

    }

    // end game
    function endGame(uint256 gameId) external {

    }

    // public view function
    function getNumCards(uint256 gameId) external view returns (uint256) {
        return 1;
    }

    function curPlayerIndex(uint gameId) external view returns (uint) {
        return 1;

    }

    // return decrypt record of a certain card
    function getDecryptRecord(
        uint gameId,
        uint cardIdx
    ) external view returns (BitMaps.BitMap256 memory) {
        BitMaps.BitMap256 memory bit;
        bit._data = 100;
        return bit;
    }

    // Returns the aggregated public key for all players.
    function queryAggregatedPk(
        uint256 gameId
    ) external view returns (uint px, uint py) {
        return (1, 1);
    }

    // Returns the value of the `cardIndex`-th card in the `gameId`-th game.
    function queryCardValue(
        uint256 gameId,
        uint256 cardIndex
    ) external view returns (uint256) {
        return 1;
    }

    // Returns the player index in the `gameId`-th game.
    function getPlayerIdx(
        uint256 gameId,
        address player
    ) external view returns (uint256) {
        return 1;
    }


}
