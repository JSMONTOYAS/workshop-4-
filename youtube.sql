-- Tabla Country
	CREATE TABLE Country (
	    id_country INT PRIMARY KEY,
	    name VARCHAR(255) UNIQUE NOT NULL
	);
	-- Tabla MusicalGenre
	CREATE TABLE MusicalGenre (
	    id_genre UUID PRIMARY KEY,
	    "name" VARCHAR(255) UNIQUE NOT NULL,
		description VARCHAR(100)
	);

	-- Tabla User
	CREATE TABLE IF NOT EXISTS "User" (
	    id_user UUID PRIMARY KEY,
	    "name" VARCHAR(255) NOT NULL,
	    email VARCHAR(255) UNIQUE NOT NULL,
	    "password" VARCHAR(255) NOT NULL,
		nickname VARCHAR(30) NOT NULL,
	    phone VARCHAR(50) NOT NULL,
		musical_genre_fk UUID NOT NULL,
		country_fk INT NOT NULL,
	    FOREIGN KEY (country_fk) REFERENCES Country(id_country),
		FOREIGN KEY (musical_genre_fk) REFERENCES MusicalGenre(id_genre)
	);

-- Tabla BankAccount
	CREATE TABLE BankAccount (
	    id_bank_account UUID PRIMARY KEY,
	    account_number VARCHAR(255) UNIQUE NOT NULL,
	    bank_name VARCHAR(255) NOT NULL,
		country_fk INT,
		user_fk UUID,
		FOREIGN KEY (user_fk) REFERENCES "User"(id_user),
		FOREIGN KEY (country_fk) REFERENCES Country(id_country)
		
	);
-- Tabla Channel
	CREATE TABLE Channel (
	    id_channel UUID PRIMARY KEY,
	    "name" VARCHAR(255) NOT NULL,
	    description TEXT,
	    user_fk UUID,
	    FOREIGN KEY (user_fk) REFERENCES "User"(id_user)
	);

	-- Tabla Video
	CREATE TABLE Video (
	    id_video UUID PRIMARY KEY,
	    "name" VARCHAR(255) NOT NULL,
	    description VARCHAR(255) NOT NULL,
	    date_upload DATE NOT NULL,
		likes INT DEFAULT 0,
		dislikes INT DEFAULT 0,
		genre_fk UUID,
	    channel_fk UUID,
		user_fk UUID,
	    FOREIGN KEY (genre_fk) REFERENCES MusicalGenre(id_genre),
	    FOREIGN KEY (channel_fk) REFERENCES Channel(id_channel),
		FOREIGN KEY (user_fk) REFERENCES "User"(id_user)
	);
	
	
	
	-- Tabla Playlist
	CREATE TABLE Playlist (
	    id_playlist UUID PRIMARY KEY,
	    "name" VARCHAR(255) NOT NULL,
		likes INT DEFAULT 0, 
	    user_fk UUID,
	    FOREIGN KEY (user_fk) REFERENCES "User"(id_user)
	);
	
	-- Tabla Comment
	CREATE TABLE "Comment" (
	    id_comment UUID PRIMARY KEY,
	    "content" Varchar(300) NOT NULL,
	    date_creation DATE NOT NULL,
		likes INT DEFAULT 0,
		dislikes INT DEFAULT 0,
	    user_fk UUID,
	    video_fk UUID,
	    FOREIGN KEY (user_fk) REFERENCES "User"(id_user),
	    FOREIGN KEY (video_fk) REFERENCES Video(id_video)
	);

	-- Tabla VideoPlaylist
CREATE TABLE VideoPlaylist (
  id_video_playlist SERIAL PRIMARY KEY, -- Clave primaria autoincrementable
  video_fk UUID,
  playlist_fk UUID,
  FOREIGN KEY (video_fk) REFERENCES Video(id_video),
  FOREIGN KEY (playlist_fk) REFERENCES Playlist(id_playlist),
  UNIQUE (video_fk, playlist_fk)  -- Restricción UNIQUE para evitar duplicados
);

	-- Tabla Community
	CREATE TABLE Community (
	    id_community UUID PRIMARY KEY,
	    "name" VARCHAR(255) NOT NULL,
	    description VARCHAR(255)
	);
	
-- Tabla Subscriber
CREATE TABLE Subscriber (
  user_fk UUID,
  channel_fk UUID,
  pay BOOL DEFAULT false,
  pay_cost FLOAT,
  date_subscription DATE NOT NULL,
  PRIMARY KEY (user_fk, channel_fk),  -- Clave primaria compuesta
  FOREIGN KEY (user_fk) REFERENCES "User"(id_user),
  FOREIGN KEY (channel_fk) REFERENCES Channel(id_channel)
);

	
	-- Tabla community_user
CREATE TABLE community_user (
  id_community_user SERIAL PRIMARY KEY, -- Clave primaria autoincrementable
  community_fk UUID,
  user_fk UUID,
  FOREIGN KEY (user_fk) REFERENCES "User"(id_user),
  FOREIGN KEY (community_fk) REFERENCES Community(id_community),
  UNIQUE (community_fk, user_fk)  -- Restricción UNIQUE para evitar duplicados
);

	
