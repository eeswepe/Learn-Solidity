// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Notes{
    //declaring variables
    mapping(uint256 => string) public notes;
    uint256 public nextId;

    //setting default value of variable
    constructor() {
        nextId = 0;
    }

    //adding some event
    event NoteAdded(uint256 id, string value);
    event NoteUpdated(uint256 id, string value);
    event NoteDeleted(uint256 id);

    //function to adding note
    function addNote(string memory _note) public {
        uint currentId = nextId;
        notes[currentId] = _note;
        nextId++;
        emit NoteAdded(currentId, _note);
    }

    //function to update specific note
    function updateNote(uint256 _id, string memory _note) public {
        require(bytes(notes[_id]).length > 0, "Note does not exist");
        notes[_id] = _note;
        emit NoteUpdated(_id, _note);
    }

    //function to delete specific note
    function deleteNote(uint256 _id) public {
        require(bytes(notes[_id]).length > 0, "Note does not exist");
        delete notes[_id];
        emit NoteDeleted(_id);
    }

    //function to get specific note
    function getNote(uint256 _id) public view returns(string memory){
        require(bytes(notes[_id]).length > 0, "Note does not exist");
        return notes[_id];
    }

    //function to get all notes
    function getAllNotes() public view returns (string[] memory) {
        string[] memory allNotes = new string[](nextId);
        for (uint256 i = 0; i < nextId; i++) {
            allNotes[i] = notes[i];
        }
        return allNotes;
    }

}