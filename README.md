# Pokemon_ObjC
<body>
  <div align="center">
    <img src="https://img.shields.io/static/v1?label=XCode%20Version&message=13.4.1&color=brightgreen&logo=xcode" alt="Xcode version 13">
    <img src="https://img.shields.io/static/v1?label=Objective-C%20Version&message=2.0&color=brightgreen&logo=c" alt="Swift Version 5.5">
    <img src="https://img.shields.io/static/v1?label=Framework&message=UIKit&color=brightgreen&logoColor=blue">
  </div>
  <p>This is a sample Project for fetching data from <a href="https://pokeapi.co">PokeAPI</a> in Objective-C &amp; UIKit</p>
  <ul>
    <li>This Application is full written in Objective-C.</li>
    <li>UI has been implemented with UIKit. In this particular case in 'programmatic way' without use of Storyboards.</li>
    <li>Because Objective-C doesn't have amazing features like Swift-Concurrency we are obliged to fallback on blocks (like closures in swift), with callbacks and completion handlers architecture.</li>
    <li>Images are downloaded with a basic caching system implemented inside Http Client for avoid useless downloads and data consumption.</li>
    <li>Because the pokemon count amount to 1154, is unrealistic to download everything in one shot, so it has been implemented also a pagination system, that download other pokemons while scrolling.</li>
    <li>Furthermore with <a href="https://developer.apple.com/documentation/dispatch/dispatch_group?language=objc">Dispatch Group</a> we are able to download data in parallel instead of a sequential async requests.</li>
  </ul>
</body>
