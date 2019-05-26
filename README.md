# FlickrAPIAssignment

Flickr API Assignment 
 
Problem statement Fetch data from "https://api.flickr.com/services/rest/" and show them in grid

Install and Run - As no pods are used so just clone from github repo and run it 


Architecture
Code structure has been divided like Three folders - Core , Network Layer, Presentation Layer
Followed MVVM Architecture along with object oriented along with Solid principles: 
HomeViewController and HomeViewController+CollectionView - Contains all UI stuff related code.
PhotoViewModel - Conforms codable protocol
 Network Layer - Tried to use of generics and singleton pattern
Done Image Caching


Unit Testing and UI Testing - Cover all possible ui test cases in the project

HomeViewModelTests.swift - Tested initialization of PhotoResponseModel 
  testViewModelIntialisation()

NetworkLayerTest.swift -  Tested the api call for both success and failure cases and tested encoding part 
 testFetchPhotoServiceSuccess()
 testFetchPhotoServiceFailure()
 testEncoding()


 

