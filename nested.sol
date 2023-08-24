// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract nestedStructs {
    enum Gender {
        male,
        female
    }

    struct Person_Details {
        string first_name;
        string last_name;
        uint8 age;
        Gender gender;
        mapping(string => Location) _nameToLocation;
    }

    struct Location {
        uint8 str_num;
        string city;
        string state;
    }

    struct Person_Info {
        Person_Details person_details;
        uint fileId;
    }

    mapping(uint => Person_Info) IdToInfo;

    function set(
        string memory _firstName,
        string memory _lastName,
        uint8 _age,
        Gender _gender,
        uint8 _strNum,
        string memory _city,
        string memory _state,
        uint _fileId
    ) public {
        Person_Details storage person = IdToInfo[_fileId].person_details;
        person._nameToLocation[_firstName] = Location({
            str_num: _strNum,
            city: _city,
            state: _state
        });
        person.first_name = _firstName;
        person.last_name = _lastName;
        person.age = _age;
        person.gender = _gender;
    }

    function getInfo(
        uint _fileId
    ) public view returns (string memory, string memory, uint8, Gender) {
        Person_Details storage person = IdToInfo[_fileId].person_details;
        return (person.first_name, person.last_name, person.age, person.gender);
    }

    function getLocation(
        uint _fileId,
        string memory _firstName
    ) public view returns (Location memory) {
        return IdToInfo[_fileId].person_details._nameToLocation[_firstName];
    }
}
