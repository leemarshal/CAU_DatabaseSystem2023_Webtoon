CREATE TABLE Webtoons (
    WebtoonID INT PRIMARY KEY,
    Title VARCHAR(255),
    AuthorID INT,
    PublishDate DATE,
    ThumbnailURL VARCHAR(255)
    -- 다른 속성이 있다면 추가하십시오.
);

CREATE TABLE WebtoonStatus (
    WebtoonID INT PRIMARY KEY,
    Status ENUM('Ongoing', 'Completed'),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID)
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255),
    Email VARCHAR(255),
    PasswordHash VARCHAR(255),
    UserType VARCHAR(50),
    Gender VARCHAR(50),
    DateOfBirth DATE,
    JoinDate DATE
    -- 추가 속성이 있다면 여기에 삽입하십시오.
);

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Salary INT,
    FOREIGN KEY (AuthorID) REFERENCES Users(UserID)
);

CREATE TABLE Tags (
    TagID INT PRIMARY KEY,
    TagName VARCHAR(255),
    TagDescription VARCHAR(255)
    -- TagName and TagDescription VARCHAR lengths can be adjusted as needed.
);

CREATE TABLE Readers (
    ReaderID INT PRIMARY KEY,
    TagID INT,
    CookieAmount INT,
    FOREIGN KEY (ReaderID) REFERENCES Users(UserID),
    FOREIGN KEY (TagID) REFERENCES Tags(TagID) -- Tags 테이블이 아직 제공되지 않았으므로 추후 수정이 필요할 수 있습니다.
);

CREATE TABLE AuthorsWebtoons (
    AuthorWebtoonID INT PRIMARY KEY,
    WebtoonID INT,
    AuthorID INT,
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    -- AuthorID is assumed to be a FK to Users table, ensure Users table is created with UserID.
);

CREATE TABLE Episodes (
    EpisodeID INT PRIMARY KEY,
    Title VARCHAR(255),
    ReleaseDate DATE
    -- DATE type is used for ReleaseDate as per your description.
);

CREATE TABLE EpisodesWebtoon (
    EpisodeID INT PRIMARY KEY,
    WebtoonID INT,
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID)
    -- This table creates a one-to-one relationship between Episodes and Webtoons. 
    -- If an episode can belong to more than one webtoon, this structure will need to be adjusted.
);

CREATE TABLE EpisodesMedia (
    EpisodeMediaID INT PRIMARY KEY,
    EpisodeID INT,
    MediaURL VARCHAR(255),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID)
    -- This table assumes each media URL is unique to an EpisodeMediaID.
);

CREATE TABLE EpisodesImage (
    EpisodeImageID INT PRIMARY KEY,
    EpisodeID INT,
    CutNumber INT,
    ImageURL VARCHAR(255),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID)
    -- CutNumber indicates the sequence of the image within an episode.
    -- If CutNumber should be unique per EpisodeID, additional table constraints are required.
);

CREATE TABLE EpisodesDialogue (
    DialogueID INT PRIMARY KEY,
    EpisodeID INT,
    AuthorID INT,
    DialogueText VARCHAR(255),
    Timestamp TIMESTAMP,
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    -- Assuming the Authors table has AuthorID as a primary key.
);

CREATE TABLE EpisodeRating (
    EpisodeRatingID INT PRIMARY KEY,
    EpisodeID INT,
    ReaderID INT,
    Rating TINYINT CHECK (Rating >= 1 AND Rating <= 10),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- ReaderID is assumed to be a FK to Users table.
);

CREATE TABLE EpisodeAvgRating (
    EpisodeAvgRatingID INT PRIMARY KEY,
    EpisodeID INT,
    Rating DECIMAL(3,1) CHECK (Rating >= 1 AND Rating <= 10),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID)
    -- DECIMAL(2,1) allows for ratings from 1.0 to 10.0 with one decimal place.
);

CREATE TABLE WebtoonAvgRating (
    WebtoonAvgRatingID INT PRIMARY KEY,
    WebtoonID INT,
    Rating DECIMAL(3,1) CHECK (Rating >= 1 AND Rating <= 10),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID)
    -- DECIMAL(2,1) allows for ratings from 1.0 to 10.0 with one decimal place.
);

CREATE TABLE UserTokens (
    Token VARCHAR(255) PRIMARY KEY,
    UserID INT,
    JWTExpiration DATETIME,
    CreationDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
    -- JWTToken lengths can be adjusted based on the used token generation method.
);

CREATE TABLE ReaderSearch (
    ReaderSearchID INT PRIMARY KEY,
    ReaderID INT,
    CreationDate DATETIME,
    SearchKeyword VARCHAR(255),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- Assumes the existence of the Readers table with ReaderID as PK.
);

CREATE TABLE ReaderPaymentMethods (
    ReaderPaymentMethodID INT PRIMARY KEY,
    ReaderID INT,
    PaymentMethodDetails VARCHAR(255),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- Assumes the existence of the Readers table with ReaderID as PK.
);

CREATE TABLE ReaderCookiePurchases (
    ReaderCookiePurchaseID INT PRIMARY KEY,
    ReaderID INT,
    Amount INT,
    Date DATE,
    ReaderPaymentMethodID INT,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (ReaderPaymentMethodID) REFERENCES ReaderPaymentMethods(ReaderPaymentMethodID)
    -- Assumes the existence of the ReaderPaymentMethods table with ReaderPaymentMethodID as PK.
    -- Note: The FK to User-Payment Methods should be an INT if it's referencing an ID.
);

CREATE TABLE ReaderCookieUse (
    ReaderCookieUseID INT PRIMARY KEY,
    ReaderID INT,
    Amount INT,
    Date DATE,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- Assumes the existence of the Readers table with ReaderID as PK.
);

CREATE TABLE ReaderBookmark (
    ReaderBookmarkID INT PRIMARY KEY,
    ReaderID INT,
    WebtoonID INT,
    EpisodeID INT,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID),
    UNIQUE (ReaderID, WebtoonID)
    -- This UNIQUE constraint ensures that the combination of ReaderID and WebtoonID is unique.
    -- Assumes the existence of the Webtoons and Episodes tables with WebtoonID and EpisodeID as PKs.
);

CREATE TABLE Reading (
    ReadingID INT PRIMARY KEY,
    ReaderID INT,
    EpisodeID INT,
    ReadDate DATE,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID)
    -- Assumes the existence of the Readers and Episodes tables.
);

CREATE TABLE Comments (
    CommentID INT PRIMARY KEY,
    EpisodeID INT,
    ReaderID INT,
    CommentText VARCHAR(255),
    Timestamp TIMESTAMP,
    ParentCommentID INT DEFAULT -1,
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- ParentCommentID is set to -1 by default when there is no parent comment (non-reply comments).
);

CREATE TABLE CommentsLikes (
    LikeID INT PRIMARY KEY,
    ReaderID INT,
    CommentID INT,
    LikeType ENUM('Good', 'Bad'),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (CommentID) REFERENCES Comments(CommentID)
    -- ENUM type is used for LikeType to restrict the value to either 'Good' or 'Bad'.
);

CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description VARCHAR(255)
    -- Description can contain a longer text explaining the genre.
);

CREATE TABLE WebtoonGenres (
    WebtoonID INT,
    GenreID INT,
    PRIMARY KEY (WebtoonID, GenreID),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
    -- This table creates a many-to-many relationship between Webtoons and Genres.
    -- The primary key is a composite key consisting of WebtoonID and GenreID.
);

CREATE TABLE WebtoonTags (
    WebtoonTagID INT PRIMARY KEY,
    WebtoonID INT,
    TagID INT,
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID),
    FOREIGN KEY (TagID) REFERENCES Tags(TagID)
    -- This table links Webtoons to Tags.
);

CREATE TABLE Notice (
    NoticeID INT PRIMARY KEY,
    Title VARCHAR(255),
    Content VARCHAR(255),
    PostedDate DATE,
    IsActive ENUM('True', 'False')
    -- IsActive is an ENUM to ensure it only contains 'True' or 'False'.
);

CREATE TABLE UserNoticeRead (
    ReaderID INT,
    NoticeID INT,
    PRIMARY KEY (ReaderID, NoticeID),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (NoticeID) REFERENCES Notice(NoticeID)
    -- This table records which users have read which notices.
    -- The combination of ReaderID and NoticeID is unique.
);

CREATE TABLE Subscriptions (
    ReaderID INT,
    WebtoonID INT,
    SubscriptionDate DATE,
    PRIMARY KEY (ReaderID, WebtoonID),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID)
    -- By using ReaderID and WebtoonID as a composite primary key, 
    -- this table now allows a reader to subscribe to multiple webtoons 
    -- and ensures that each subscription is unique to a reader-webtoon pair.
);

