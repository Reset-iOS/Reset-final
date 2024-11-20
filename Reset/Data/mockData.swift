import Foundation

// Generate unique IDs for each user
let user1ID = UUID(uuidString: "A3FBB3F1-8A25-4C70-AE5C-8903A80E4D29")!
let user2ID = UUID(uuidString: "D75F3A3C-8315-4D9A-80AC-9BC73A93D6E4")!
let user3ID = UUID(uuidString: "5A4B03D7-8ED2-46D4-A05D-68A6C7FB4E71")!
let user4ID = UUID(uuidString: "59228F23-14B9-4339-B142-267DF81C3D0E")!
let user5ID = UUID(uuidString: "F7F5332F-98D2-4187-B2F3-97DAAAED6BCF")!
let user6ID = UUID(uuidString: "DB4AB69A-4425-42A1-A9FE-57D1A16525D1")!

// Sample array of mock users
let mockUsers: [User] = [
    User(
        id: user1ID,
        name: "John Doe",
        age: 34,
        memberSince: Date(timeIntervalSince1970: 1577880000), // January 1, 2020
        soberSince: Date(timeIntervalSince1970: 1609502400),  // January 1, 2021
        resets: 2,
        streak: 100,
        bloodGroup: "A+",
        sex: "Male",
        profileImage: "John",
        sponsorID: nil,
        friends: [user2ID, user3ID]
    ),
    User(
        id: user2ID,
        name: "Jane Smith",
        age: 29,
        memberSince: Date(timeIntervalSince1970: 1514764800), // January 1, 2018
        soberSince: Date(timeIntervalSince1970: 1577836800),  // January 1, 2020
        resets: 0,
        streak: 365,
        bloodGroup: "B+",
        sex: "Female",
        profileImage: "Jane",
        sponsorID: nil,
        friends: [user4ID, user5ID]
    ),
    User(
        id: user3ID,
        name: "Michael Brown",
        age: 42,
        memberSince: Date(timeIntervalSince1970: 1546300800), // January 1, 2019
        soberSince: Date(timeIntervalSince1970: 1577836800),  // January 1, 2020
        resets: 5,
        streak: 200,
        bloodGroup: "O+",
        sex: "Male",
        profileImage: "Michael",
        sponsorID: user1ID,
        friends: [user6ID]
    ),
    User(
        id: user4ID,
        name: "Emily Davis",
        age: 26,
        memberSince: Date(timeIntervalSince1970: 1483228800), // January 1, 2017
        soberSince: Date(timeIntervalSince1970: 1609459200),  // January 1, 2021
        resets: 3,
        streak: 150,
        bloodGroup: "AB-",
        sex: "Female",
        profileImage: "Emily",
        sponsorID: nil,
        friends: [user2ID, user6ID]
    ),
    User(
        id: user5ID,
        name: "David Wilson",
        age: 38,
        memberSince: Date(timeIntervalSince1970: 1451606400), // January 1, 2016
        soberSince: Date(timeIntervalSince1970: 1546300800),  // January 1, 2019
        resets: 1,
        streak: 250,
        bloodGroup: "O-",
        sex: "Male",
        profileImage: "David",
        sponsorID: user3ID,
        friends: [user4ID]
    ),
    User(
        id: user6ID,
        name: "Sophia Martinez",
        age: 31,
        memberSince: Date(timeIntervalSince1970: 1577836800), // January 1, 2020
        soberSince: Date(timeIntervalSince1970: 1609459200),  // January 1, 2021
        resets: 2,
        streak: 300,
        bloodGroup: "A-",
        sex: "Female",
        profileImage: "Sophia",
        sponsorID: nil,
        friends: [user3ID, user5ID]
    )
]

// Sample array of mock posts
let mockPosts: [Post] = [
    Post(
        user: mockUsers[0],
        postDate: Date(timeIntervalSinceNow: -86400),  // 1 day ago
        postText: "Had an amazing day at the park!",
        postImage: "post1",
        postLikes: 120,
        postComments: ["Looks fun!", "Wish I was there!", "Nice picture!"]
    ),
    Post(
        user: mockUsers[1],
        postDate: Date(timeIntervalSinceNow: -172800), // 2 days ago
        postText: "Just started reading this new book, it's awesome!",
        postImage: "post2",
        postLikes: 98,
        postComments: ["What book?", "Looks interesting!", "I want to read it too!"]
    ),
    Post(
        user: mockUsers[2],
        postDate: Date(timeIntervalSinceNow: -259200), // 3 days ago
        postText: "Feeling proud of my progress!",
        postImage: "post3",
        postLikes: 150,
        postComments: ["Keep going!", "So inspiring!", "Amazing work!"]
    ),
    Post(
        user: mockUsers[3],
        postDate: Date(timeIntervalSinceNow: -345600), // 4 days ago
        postText: "Enjoying a peaceful evening with family.",
        postImage: "post4",
        postLikes: 200,
        postComments: ["Family time is the best!", "Such a lovely picture!", "You all look great!"]
    ),
    Post(
        user: mockUsers[4],
        postDate: Date(timeIntervalSinceNow: -432000), // 5 days ago
        postText: "Just finished a great workout!",
        postImage: "post5",
        postLikes: 175,
        postComments: ["Way to go!", "You're killing it!", "I need to work out too!"]
    ),
    Post(
        user: mockUsers[5],
        postDate: Date(timeIntervalSinceNow: -518400), // 6 days ago
        postText: "Had the best coffee this morning!",
        postImage: "post6",
        postLikes: 85,
        postComments: ["Where did you get it?", "I love coffee!", "That looks delicious!"]
    )
]
