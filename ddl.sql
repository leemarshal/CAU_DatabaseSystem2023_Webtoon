DROP TABLE IF EXISTS AuthorsWebtoons;
DROP TABLE IF EXISTS EpisodesWebtoon;
DROP TABLE IF EXISTS EpisodesMedia;
DROP TABLE IF EXISTS EpisodesImage;
DROP TABLE IF EXISTS EpisodesDialogue;
DROP TABLE IF EXISTS EpisodeRating;
DROP TABLE IF EXISTS EpisodeAvgRating;
DROP TABLE IF EXISTS WebtoonAvgRating;
DROP TABLE IF EXISTS UserTokens;
DROP TABLE IF EXISTS ReaderSearch;
DROP TABLE IF EXISTS ReaderCookiePurchases;
DROP TABLE IF EXISTS ReaderPaymentMethods;
DROP TABLE IF EXISTS ReaderCookieUse;
DROP TABLE IF EXISTS ReaderBookmark;
DROP TABLE IF EXISTS Reading;
DROP TABLE IF EXISTS CommentsLikes;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS WebtoonGenres;
DROP TABLE IF EXISTS WebtoonTags;
DROP TABLE IF EXISTS UserNoticeRead;
DROP TABLE IF EXISTS Subscriptions;
DROP TABLE IF EXISTS WebtoonStatus;
DROP TABLE IF EXISTS Readers;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Administrator;
DROP TABLE IF EXISTS Episodes;
DROP TABLE IF EXISTS Webtoons;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS Notice;
DROP TABLE IF EXISTS PromotionEvent;

CREATE TABLE Webtoons (
    WebtoonID INT PRIMARY KEY,
    Title VARCHAR(255),
    AuthorID INT,
    PublishDate DATE,
    ThumbnailURL VARCHAR(255),
    PublishDay INT CHECK (PublishDay >= 0 AND PublishDay <= 6)  -- 0: 일요일, 1: 월요일, ..., 6: 토요일
    -- 다른 속성이 있다면 추가하십시오.
);

CREATE TABLE WebtoonStatus (
    WebtoonID INT PRIMARY KEY,
    Status ENUM('Ongoing', 'Completed'),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255),
    Email VARCHAR(255),
    PasswordHash VARCHAR(255),
    Gender VARCHAR(50),
    IsActive BOOLEAN,
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
    CookieAmount INT,
    FOREIGN KEY (ReaderID) REFERENCES Users(UserID)
);

CREATE TABLE Administrator (
    AdministratorID INT PRIMARY KEY,
    Salary int,
    Level int,
    FOREIGN KEY (AdministratorID) REFERENCES Users(UserID)
);

CREATE TABLE AuthorsWebtoons (
    AuthorWebtoonID INT PRIMARY KEY,
    WebtoonID INT,
    AuthorID INT,
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    -- AuthorID is assumed to be a FK to Users table, ensure Users table is created with UserID.
);

CREATE TABLE Episodes (
    EpisodeID INT PRIMARY KEY,
    WebtoonID INT,
    Title VARCHAR(255),
    ReleaseDate DATE,
    ThumbnailURL VARCHAR(255),
    EpisodeIndex INT,
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE,
    UNIQUE (WebtoonID, EpisodeIndex)
);

CREATE TABLE EpisodesMedia (
    EpisodeMediaID INT PRIMARY KEY,
    EpisodeID INT,
    MediaURL VARCHAR(255),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE
);

CREATE TABLE EpisodesImage (
    EpisodeImageID INT PRIMARY KEY,
    EpisodeID INT,
    CutNumber INT,
    ImageURL VARCHAR(255),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE,
    UNIQUE (EpisodeID, CutNumber)
);


CREATE TABLE EpisodesDialogue (
    DialogueID INT PRIMARY KEY,
    EpisodeID INT,
    AuthorID INT,
    DialogueText VARCHAR(255),
    Timestamp TIMESTAMP,
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    -- Assuming the Authors table has AuthorID as a primary key.
);

CREATE TABLE EpisodeRating (
    EpisodeRatingID INT PRIMARY KEY,
    EpisodeID INT,
    ReaderID INT,
    Rating TINYINT CHECK (Rating >= 1 AND Rating <= 10),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- ReaderID is assumed to be a FK to Users table.
);

CREATE TABLE EpisodeAvgRating (
    EpisodeAvgRatingID INT PRIMARY KEY,
    EpisodeID INT,
    Rating DECIMAL(3,1) CHECK (Rating >= 1 AND Rating <= 10),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE
);

CREATE TABLE WebtoonAvgRating (
    WebtoonAvgRatingID INT PRIMARY KEY,
    WebtoonID INT,
    Rating DECIMAL(3,1) CHECK (Rating >= 1 AND Rating <= 10),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE
);

CREATE TABLE UserTokens (
    Token VARCHAR(255) PRIMARY KEY,
    UserID INT,
    Expiration DATETIME,
    CreationDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
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
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE,
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
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE
    -- Assumes the existence of the Readers and Episodes tables.
);

CREATE TABLE Comments (
    CommentID INT PRIMARY KEY,
    EpisodeID INT,
    ReaderID INT,
    CommentText VARCHAR(255),
    Timestamp TIMESTAMP,
    ParentCommentID INT DEFAULT -1,
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- ParentCommentID is set to -1 by default when there is no parent comment (non-reply comments).
);

CREATE TABLE CommentsLikes (
    LikeID INT PRIMARY KEY,
    ReaderID INT,
    CommentID INT,
    LikeType ENUM('Good', 'Bad'),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (CommentID) REFERENCES Comments(CommentID) ON DELETE CASCADE,
    UNIQUE (ReaderID, CommentID)
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
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
    -- This table creates a many-to-many relationship between Webtoons and Genres.
    -- The primary key is a composite key consisting of WebtoonID and GenreID.
);

CREATE TABLE WebtoonTags (
    WebtoonTagID INT PRIMARY KEY,
    WebtoonID INT,
    TagID INT,
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE,
    FOREIGN KEY (TagID) REFERENCES Tags(TagID)
    -- This table links Webtoons to Tags.
);

CREATE TABLE Notice (
    NoticeID INT PRIMARY KEY,
    Title VARCHAR(255),
    Content VARCHAR(255),
    PostedDate DATE,
    IsActive BOOLEAN
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
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE
    -- By using ReaderID and WebtoonID as a composite primary key,
    -- this table now allows a reader to subscribe to multiple webtoons
    -- and ensures that each subscription is unique to a reader-webtoon pair.
);

CREATE TABLE PromotionEvent (
    event_id INT PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    event_title VARCHAR(255),
    cookie_discount_rate INT
);