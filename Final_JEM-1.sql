USE INFO_330B_Proj_JEM;

/*
Stored Procedures: JESICCA HWEE
 */
GO
CREATE OR ALTER PROCEDURE insert_team
	@teamName VARCHAR(50)
AS 
	INSERT INTO tblTEAMS(TeamName)
	VALUES(@teamName)
GO 

EXEC insert_team @teamName = 'Team1';
EXEC insert_team @teamName = 'Team2';
EXEC insert_team @teamName = 'Team3';

GO
CREATE OR ALTER PROCEDURE insert_player
	@PlayerFName VARCHAR(50),
	@PlayerLName VARCHAR(50),
	@PlayerDOB DATE,
	@PlayerEmail VARCHAR(80),
	@TeamName VARCHAR(50)
AS
	DECLARE @TeamID INT 
	SET @TeamID = (SELECT TeamID FROM tblTEAMS
					WHERE TeamName = @TeamName)

BEGIN TRANSACTION insert_player
	INSERT INTO tblPLAYERS(PlayerFName, PlayerLName, PlayerEmail, TeamID , PlayerDOB)
	VALUES(@PlayerFName, @PlayerLName, @PlayerEmail, @PlayerDOB, @TeamID)
COMMIT TRANSACTION insert_player
GO

EXECUTE insert_player
	@PlayerFName = 'Mickey',
	@PlayerLName = 'Mouse',
	@PlayerDOB = '02-04-1999',
	@PlayerEmail = 'mickeymouse@gmail.com',
	@TeamName = NULL;

EXECUTE insert_player
	@PlayerFName = 'Minnie',
	@PlayerLName = 'Mouse',
	@PlayerDOB = '05-11-2001',
	@PlayerEmail = 'minmouse@gmail.com',
	@TeamName = NULL;

EXECUTE insert_player
	@PlayerFName = 'Donald',
	@PlayerLname = 'Duck',
	@PlayerDOB = '03-10-1998',
	@PlayerEmail = 'donduck@hotmail.com',
	@TeamName = 'Team1';


EXECUTE insert_player
	@PlayerFName = 'Daisy',
	@PlayerLName = 'Duck',
	@PlayerDOB = '09-12-2000',
	@PlayerEmail = 'daisyd@gmail.com',
	@TeamName = 'Team1';


EXECUTE insert_player
	@PlayerFName = 'Daffy',
	@PlayerLName = 'Duck',
	@PlayerDOB = '12-06-2001',
	@PlayerEmail = 'daffyduck@hotmail.com',
	@TeamName = NULL;

EXECUTE insert_player
	@PlayerFName = 'Christopher',
	@PlayerLName = 'Robin',
	@PlayerDOB = '05-05-1995',
	@PlayerEmail = 'chrisrobin@gmail.com',
	@TeamName = 'Team2';

EXECUTE insert_player
	@PlayerFName = 'Winnie',
	@PlayerLName = 'Pooh',
	@PlayerDOB = '07-03-2003',
	@PlayerEmail = 'poohbear@gmail.com',
	@TeamName = 'Team2';

EXECUTE insert_player
	@PlayerFName = 'Eeyore',
	@PlayerLName = 'Donkey',
	@PlayerDOB = '04-11-2005',
	@PlayerEmail = 'eeyore@hotmail.com',
	@TeamName = NULL;

EXECUTE insert_player
	@PlayerFName = 'Tigger',
	@PlayerLName = 'Tiger',
	@PlayerDOB = '01-12-2004',
	@PlayerEmail = 'tigtiger@gmail.com',
	@TeamName = 'Team3';

EXECUTE insert_player
	@PlayerFName = 'Piglet',
	@PlayerLName = 'Pig',
	@PlayerDOB = '08-01-2001',
	@PlayerEmail = 'piglet@yahoo.com',
	@TeamName = 'Team3';

GO
CREATE OR ALTER PROCEDURE insert_result
	@result VARCHAR(50),
	@arenaName VARCHAR(30),
	@characterName VARCHAR(50)
AS
	DECLARE @arenaID INT, @characterID INT
	SET @arenaID = (SELECT ArenaID FROM tblARENAS
					WHERE ArenaName = @arenaName)

	SET @characterID = (SELECT CharacterID FROM tblCHARACTERS
						WHERE CharacterName = @characterName)

BEGIN TRANSACTION insert_result
	INSERT INTO tblRESULTS(Result, ArenaID, CharacterID)
	VALUES(@result, @arenaID, @characterID)
COMMIT TRANSACTION insert_result
GO 

EXECUTE insert_result
	@result = 'Win',
	@arenaName = 'Gamer',
	@characterName = 'Mario';

EXECUTE insert_result
	@result = 'Win',
	@arenaName = 'Golden Plains',
	@characterName = 'Donkey Kong';
EXECUTE insert_result
	@result = 'Win',
	@arenaName = 'Lylat Cruise',
	@characterName = 'Pikachu';
EXECUTE insert_result
	@result = 'Win',
	@arenaName = 'Lylat Cruise',
	@characterName = 'Kirby';
EXECUTE insert_result
	@result = 'Draw',
	@arenaName = 'Figure-8 Circuit',
	@characterName = 'Yoshi';
EXECUTE insert_result
	@result = 'Draw',
	@arenaName = 'Mushroom Kingdom II',
	@characterName = 'Peach';
EXECUTE insert_result
	@result = 'Lose',
	@arenaName = 'Super Happy Tree',
	@characterName = 'Marth';
EXECUTE insert_result
	@result = 'Lose',
	@arenaName = 'Super Happy Tree',
	@characterName = 'Bowser';
EXECUTE insert_result
	@result = 'Lose',
	@arenaName = 'Small Battlefield',
	@characterName = 'Jigglypuff';
EXECUTE insert_result
	@result = 'Lose',
	@arenaName = 'Small Battlefield',
	@characterName = 'Fox';

GO 
CREATE OR ALTER PROCEDURE insert_player_result
	@playerFname VARCHAR(50),
	@playerLname VARCHAR(50),
	@playerDOB DATE,
	@playerEmail VARCHAR(80),
	@result VARCHAR(50),
	@arenaName VARCHAR(30),
	@characterName VARCHAR(50)
AS 
	DECLARE @playerID INT, @resultID INT
	SET @playerID = (SELECT PlayerID FROM tblPLAYERS p
					 WHERE p.PlayerFName = @playerFname
					 AND p.PlayerLName = @playerLname
					 AND p.PlayerDOB = @playerDOB
					 AND p.PlayerEmail = @playerEmail)
	SET @resultID = (SELECT ResultID FROM tblRESULTS r
				   JOIN tblARENAS a ON r.ArenaID = a.ArenaID
				   JOIN tblCHARACTERS c ON r.CharacterID = c.CharacterID
				   WHERE r.Result = @result
				   AND a.ArenaName = @arenaName
				   AND c.CharacterName = @characterName)
BEGIN TRANSACTION insert_player_result
	INSERT INTO tblPLAYER_RESULTS(PlayerID, ResultID)
	VALUES(@playerID, @resultID)
COMMIT TRANSACTION insert_player_result
GO 

EXECUTE insert_player_result
	@PlayerFName = 'Mickey',
	@PlayerLName = 'Mouse',
	@PlayerEmail = 'mickeymouse@gmail.com',
	@PlayerDOB = '1999-02-04',
	@result = 'Win',
	@arenaName = 'Gamer',
	@characterName = 'Mario';

EXECUTE insert_player_result
	@PlayerFName = 'Minnie',
	@PlayerLName = 'Mouse',
	@PlayerEmail = 'minmouse@gmail.com',
	@PlayerDOB = '05-11-2001',
	@result = 'Win',
	@arenaName = 'Golden Plains',
	@characterName = 'Donkey Kong';

EXECUTE insert_player_result
	@PlayerFName = 'Donald',
	@PlayerLname = 'Duck',
	@PlayerEmail = 'donduck@hotmail.com',
	@PlayerDOB = '03-10-1998',
	@result = 'Lose',
	@arenaName = 'Super Happy Tree',
	@characterName = 'Marth';

EXECUTE insert_player_result
	@PlayerFName = 'Daisy',
	@PlayerLName = 'Duck',
	@PlayerDOB = '09-12-2000',
	@PlayerEmail = 'daisyd@gmail.com',
	@result = 'Lose',
	@arenaName = 'Super Happy Tree',
	@characterName = 'Bowser';

EXECUTE insert_player_result
	@PlayerFName = 'Daffy',
	@PlayerLName = 'Duck',
	@PlayerDOB = '12-06-2001',
	@PlayerEmail = 'daffyduck@hotmail.com',
	@result = 'Draw',
	@arenaName = 'Figure-8 Circuit',
	@characterName = 'Yoshi';

EXECUTE insert_player_result
	@PlayerFName = 'Christopher',
	@PlayerLName = 'Robin',
	@PlayerEmail = 'chrisrobin@gmail.com',
	@PlayerDOB = '05-05-1995',
	@result = 'Win',
	@arenaName = 'Lylat Cruise',
	@characterName = 'Pikachu';

EXECUTE insert_player_result
	@PlayerFName = 'Winnie',
	@PlayerLName = 'Pooh',
	@PlayerEmail = 'poohbear@gmail.com',
	@PlayerDOB = '07-03-2003',
	@result = 'Win',
	@arenaName = 'Lylat Cruise',
	@characterName = 'Kirby';

EXECUTE insert_player_result
	@PlayerFName = 'Eeyore',
	@PlayerLName = 'Donkey',
	@PlayerEmail = 'eeyore@hotmail.com',
	@PlayerDOB = '04-11-2005',
	@result = 'Draw',
	@arenaName = 'Mushroom Kingdom II',
	@characterName = 'Peach';

EXECUTE insert_player_result
	@PlayerFName = 'Tigger',
	@PlayerLName = 'Tiger',
	@PlayerEmail = 'tigtiger@gmail.com',
	@PlayerDOB = '01-12-2004',
	@result = 'Lose',
	@arenaName = 'Small Battlefield',
	@characterName = 'Jigglypuff';

EXECUTE insert_player_result
	@PlayerFName = 'Piglet',
	@PlayerLName = 'Pig',
	@PlayerEmail = 'piglet@yahoo.com',
	@PlayerDOB = '08-01-2001',
	@result = 'Lose',
	@arenaName = 'Small Battlefield',
	@characterName = 'Fox';

/*
 Stored Procedures: MINJIE KIM
 */

GO
CREATE OR ALTER PROCEDURE ins_arena
  @ArenaName VARCHAR(30)
AS 
  INSERT INTO tblArenas (ArenaName)
  VALUES (@ArenaName)
GO

EXECUTE ins_arena @ArenaName = 'Gamer';
EXECUTE ins_arena @ArenaName = 'Golden Plains';
EXECUTE ins_arena @ArenaName = 'Lylat Cruise';
EXECUTE ins_arena @ArenaName = 'Wii Fit Studio';
EXECUTE ins_arena @ArenaName = 'Figure-8 Circuit';
EXECUTE ins_arena @ArenaName = 'Super Happy Tree';
EXECUTE ins_arena @ArenaName = 'Mushroom Kingdom II';
EXECUTE ins_arena @ArenaName = 'Small Battlefield';
EXECUTE ins_arena @ArenaName = 'Yoshis Island (Melee)';
EXECUTE ins_arena @ArenaName = 'Skyworld';

GO
CREATE OR ALTER PROCEDURE ins_attack
  @AttackName VARCHAR(30),
  @AttackDescription VARCHAR(250)
AS 
  INSERT INTO tblSpecial_Attack (AttackName, AttackDescription)
  VALUES (@AttackName, @AttackDescription)
GO

EXECUTE ins_attack @AttackName = 'Fireball', @AttackDescription = 'sends balls of fire';
EXECUTE ins_attack @AttackName = 'Giant Punch', @AttackDescription = 'a big big punch';
EXECUTE ins_attack @AttackName = 'Thunder Jolt', @AttackDescription = 'sends down bolts of lightning';
EXECUTE ins_attack @AttackName = 'Inhale', @AttackDescription = 'inhales the other character';
EXECUTE ins_attack @AttackName = 'Egg Lay', @AttackDescription = 'lays an egg';
EXECUTE ins_attack @AttackName = 'Toad', @AttackDescription = 'releases the toads';
EXECUTE ins_attack @AttackName = 'Shield Breaker', @AttackDescription = 'breaks a characters shield';
EXECUTE ins_attack @AttackName = 'Fire Breath', @AttackDescription = 'breathes fire';
EXECUTE ins_attack @AttackName = 'Rollout', @AttackDescription = 'rolls over the other character';
EXECUTE ins_attack @AttackName = 'Blaster', @AttackDescription = 'blasts a character out of screen';

GO
CREATE OR ALTER PROCEDURE ins_tier
  @TierRankLetter VARCHAR(1)
AS 
  INSERT INTO tblTIER (TierRankLetter)
  VALUES (@TierRankLetter)
GO

EXECUTE ins_tier @TierRankLetter = 'S';
EXECUTE ins_tier @TierRankLetter = 'A';
EXECUTE ins_tier @TierRankLetter = 'B';
EXECUTE ins_tier @TierRankLetter = 'C';
EXECUTE ins_tier @TierRankLetter = 'D';
EXECUTE ins_tier @TierRankLetter = 'F';

GO
CREATE OR ALTER PROCEDURE ins_music
  @SongName VARCHAR(30),
  @ArenaName VARCHAR(30)
AS 
  DECLARE
    @ArenaID INT
  SET 
    @ArenaID = (SELECT ArenaID FROM tblArenas WHERE ArenaName = @ArenaName)
BEGIN TRANSACTION
  INSERT INTO tblMusic (SongName, ArenaID)
  VALUES (@SongName, @ArenaID)
COMMIT TRANSACTION
GO

EXECUTE ins_music @ArenaName = 'Gamer', @SongName = 'Where we Started';
EXECUTE ins_music @ArenaName = 'Golden Plains', @SongName = 'Anti-Hero';
EXECUTE ins_music @ArenaName = 'Lylat Cruise', @SongName = 'Make it Shine';
EXECUTE ins_music @ArenaName = 'Wii Fit Studio', @SongName = 'Reputation';
EXECUTE ins_music @ArenaName = 'Figure-8 Circuit', @SongName = 'Bring the Bar';
EXECUTE ins_music @ArenaName = 'Super Happy Tree', @SongName = 'Piano Man';
EXECUTE ins_music @ArenaName = 'Mushroom Kingdom II', @SongName = 'September';
EXECUTE ins_music @ArenaName = 'Small Battlefield', @SongName = 'iCarly';
EXECUTE ins_music @ArenaName = 'Yoshis Island (Melee)', @SongName = 'Footloose';
EXECUTE ins_music @ArenaName = 'Skyworld', @SongName = 'Midnight';

/*
 Stored Procedures: ERIN MORALES
 */
GO
CREATE OR ALTER PROCEDURE insert_character
	@CharName VARCHAR(50),
	@TierLetter VARCHAR(80),
	@AttackName VARCHAR(50)
AS
	DECLARE @TierID INT, @AttackID INT
	SET @TierID = (SELECT TierID FROM tblTIER WHERE TierRankLetter = @TierLetter)
	SET @AttackID = (SELECT AttackID FROM tblSPECIAL_ATTACK where AttackName = @AttackName)
BEGIN TRANSACTION insert_character
	INSERT INTO tblCHARACTERS(CharacterName, TierID, AttackID)
	VALUES(@CharName, @TierID, @AttackID)
COMMIT TRANSACTION insert_character
GO

EXECUTE insert_character
	@CharName = 'Mario',
	@TierLetter = 'B',
	@AttackName = 'Fireball';

EXECUTE insert_character
	@CharName = 'Donkey Kong',
	@TierLetter = 'D',
	@AttackName = 'Giant Punch';

EXECUTE insert_character
	@CharName = 'Pikachu',
	@TierLetter = 'S',
	@AttackName = 'Thunder Jolt';

EXECUTE insert_character
	@CharName = 'Kirby',
	@TierLetter = 'D',
	@AttackName = 'Inhale';

EXECUTE insert_character
	@CharName = 'Yoshi',
	@TierLetter = 'A',
	@AttackName = 'Egg Lay';

EXECUTE insert_character
	@CharName = 'Peach',
	@TierLetter = 'S',
	@AttackName = 'Toad';

EXECUTE insert_character
	@CharName = 'Marth',
	@TierLetter = 'C',
	@AttackName = 'Shield Breaker';

EXECUTE insert_character
	@CharName = 'Bowser',
	@TierLetter = 'B',
	@AttackName = 'Fire Breath';

EXECUTE insert_character
	@CharName = 'Jigglypuff',
	@TierLetter = 'C',
	@AttackName = 'Rollout';

EXECUTE insert_character
	@CharName = 'Fox',
	@TierLetter = 'S',
	@AttackName = 'Blaster';

GO
CREATE OR ALTER PROCEDURE insert_weakness
	@WeaknessName VARCHAR(60)
AS 
  INSERT INTO tblWeaknesses (WeaknessName)
  VALUES (@WeaknessName)
GO

EXECUTE insert_weakness @WeaknessName = 'Fast falling speed'
EXECUTE insert_weakness @WeaknessName = 'Very light '
EXECUTE insert_weakness @WeaknessName = 'Exploitable recovery'
EXECUTE insert_weakness @WeaknessName = 'Poor range attacks'
EXECUTE insert_weakness @WeaknessName = 'Few kill options'
EXECUTE insert_weakness @WeaknessName = 'Low range attacks'
EXECUTE insert_weakness @WeaknessName = 'Very low multijump height'
EXECUTE insert_weakness @WeaknessName = 'Slow movement speed'
EXECUTE insert_weakness @WeaknessName = 'Predictable'
EXECUTE insert_weakness @WeaknessName = 'High learning curve'

GO
CREATE OR ALTER PROCEDURE insert_strength
	@StrengthName VARCHAR(60)
AS 
  INSERT INTO tblStrengths (StrengthName)
  VALUES (@StrengthName)
GO

EXECUTE insert_strength @StrengthName = 'Fast running speed'
EXECUTE insert_strength @StrengthName = 'Excellent ledgetrapping ability'
EXECUTE insert_strength @StrengthName = 'Excellent combo ability'
EXECUTE insert_strength @StrengthName = 'Attacks can auto-cancel'
EXECUTE insert_strength @StrengthName = 'Fantastic air game'
EXECUTE insert_strength @StrengthName = 'Strong edge-guarding'
EXECUTE insert_strength @StrengthName = 'Heavy weight'
EXECUTE insert_strength @StrengthName = 'Capable of crawling'
EXECUTE insert_strength @StrengthName = 'Subpar grab game'
EXECUTE insert_strength @StrengthName = 'Shield is immune to shield pokes'

GO 
CREATE OR ALTER PROCEDURE insert_character_weakness
	@weaknessname VARCHAR(50),
	@charactername VARCHAR(50),
	@rankletter VARCHAR(2),
	@attackname VARCHAR(50)
AS 
	DECLARE @weaknessID INT, @charID INT
	SET @charID = (SELECT CharacterID FROM tblCHARACTERS c
					 JOIN tblSPECIAL_ATTACK sa ON c.AttackID = sa.AttackID
					 JOIN tblTIER tr ON c.TierID = tr.TierID
					 WHERE c.CharacterName = @charactername
					 AND tr.TierRankLetter = @rankletter
					 AND sa.AttackName = @attackname)
	SET @weaknessID = (SELECT WeaknessID FROM tblWEAKNESSES w
					 Where w.WeaknessName = @weaknessname)
BEGIN TRANSACTION insert_character_weakness
	INSERT INTO tblCHARACTER_WEAKNESS(CharacterID, WeaknessID)
	VALUES(@charID, @weaknessID)
COMMIT TRANSACTION insert_character_weakness
GO
 
EXECUTE insert_character_weakness 
	@weaknessname = 'Exploitable recovery', 
	@charactername = 'Mario', 
	@rankletter = 'B', 
	@attackname ='Fireball';

EXECUTE insert_character_weakness 
	@weaknessname = 'Poor range attacks',
	@charactername = 'Pikachu', 
	@rankletter = 'S', 
	@attackname ='Thunder Jolt';

EXECUTE insert_character_weakness 
	@weaknessname = 'Slow movement speed', 
	@charactername = 'Bowser',
	@rankletter = 'B', 
	@attackname ='Fire Breath';

EXECUTE insert_character_weakness 
	@weaknessname = 'High learning curve',
	@charactername = 'Peach',
	@rankletter = 'S',
	@attackname ='Toad';

EXECUTE insert_character_weakness 
	@weaknessname = 'Predictable', 
	@charactername = 'Jigglypuff',
	@rankletter = 'C', 
	@attackname ='Rollout';

EXECUTE insert_character_weakness 
	@weaknessname = 'Few kill options', 
	@charactername = 'Marth', 
	@rankletter = 'C', 
	@attackname ='Shield Breaker';

EXECUTE insert_character_weakness 
	@weaknessname = 'Fast falling speed', 
	@charactername = 'Yoshi', 
	@rankletter = 'A', 
	@attackname ='Egg Lay';

EXECUTE insert_character_weakness 
	@weaknessname = 'Very low multijump height', 
	@charactername = 'Kirby', 
	@rankletter = 'D', 
	@attackname ='Inhale';

EXECUTE insert_character_weakness 
	@weaknessname = 'Very light', 
	@charactername = 'Fox', 
	@rankletter = 'S', 
	@attackname ='Blaster';

EXECUTE insert_character_weakness 
	@weaknessname = 'Low range attacks', 
	@charactername = 'Donkey Kong', 
	@rankletter = 'D', 
	@attackname ='Giant Punch';
 
GO 
CREATE OR ALTER PROCEDURE insert_character_strength
	@strengthname VARCHAR(50),
	@charactername VARCHAR(50),
	@rankletter VARCHAR(2),
	@attackname VARCHAR(50)
AS 
	DECLARE @strengthID INT, @charID INT
	SET @charID = (SELECT CharacterID FROM tblCHARACTERS c
					 JOIN tblSPECIAL_ATTACK sa ON c.AttackID = sa.AttackID
					 JOIN tblTIER tr ON c.TierID = tr.TierID
					 WHERE c.CharacterName = @charactername
					 AND tr.TierRankLetter = @rankletter
					 AND sa.AttackName = @attackname)
	SET @strengthID = (SELECT StrengthID FROM tblSTRENGTHS s
					 Where s.StrengthName = @strengthname)
BEGIN TRANSACTION insert_character_strength
	INSERT INTO tblCHARACTER_STRENGTH(CharacterID, StrengthID)
	VALUES( @charID,@strengthID)
COMMIT TRANSACTION insert_character_strength
GO

EXECUTE insert_character_strength 
	@strengthname = 'Fantastic air game',
	@charactername = 'Mario', 
	@rankletter = 'B', 
	@attackname ='Fireball';

EXECUTE insert_character_strength 
	@strengthname = 'Strong edge-guarding',
	@charactername = 'Pikachu', 
	@rankletter = 'S', 
	@attackname ='Thunder Jolt';

EXECUTE insert_character_strength 
	@strengthname = 'Heavy weight',
	@charactername = 'Bowser',
	@rankletter = 'B', 
	@attackname ='Fire Breath';

EXECUTE insert_character_strength 
	@strengthname = 'Excellent combo ability', 
	@charactername = 'Peach',
	@rankletter = 'S',
	@attackname ='Toad';

EXECUTE insert_character_strength 
	@strengthname = 'Attacks can auto-cancel',
	@charactername = 'Jigglypuff',
	@rankletter = 'C', 
	@attackname ='Rollout';

EXECUTE insert_character_strength 
	@strengthname = 'Excellent ledgetrapping ability', 
	@charactername = 'Marth', 
	@rankletter = 'C', 
	@attackname ='Shield Breaker';

EXECUTE insert_character_strength 
	@strengthname = 'Capable of crawling',
	@charactername = 'Yoshi', 
	@rankletter = 'A', 
	@attackname ='Egg Lay';

EXECUTE insert_character_strength 
	@strengthname = 'Shield is immune to shield pokes', 
	@charactername = 'Kirby', 
	@rankletter = 'D', 
	@attackname ='Inhale';

EXECUTE insert_character_strength 
	@strengthname = 'Fast running speed',
	@charactername = 'Fox', 
	@rankletter = 'S', 
	@attackname ='Blaster';

EXECUTE insert_character_strength 
	@strengthname = 'Subpar grab game',
	@charactername = 'Donkey Kong', 
	@rankletter = 'D', 
	@attackname ='Giant Punch';

/*
BUSINESS RULES: JESSICA HWEE
*/

/*
Rule #1: No one younger than 13 can be on a team
Justification: Teams are mostly used for competitive playing, 
			   so we will restrict younger players from joining teams so that they can enjoy casual gameplay
*/

GO
CREATE OR ALTER FUNCTION fn_team_player_age()
RETURNS INT
AS 
BEGIN 
DECLARE @ret INT = 0
IF EXISTS (SELECT * FROM tblTEAMS t
		   JOIN tblPLAYERS p ON t.TeamID = p.TeamID
		   WHERE datediff(year, p.PlayerDOB, getDate()) < 13
		   AND t.TeamID IS NOT NULL)
SET @ret = 1
RETURN @ret
END
GO

ALTER TABLE tblPlayers WITH NOCHECK
ADD CONSTRAINT chk_age_players
CHECK (dbo.fn_team_player_age() = 0)

-- test constraint function
EXECUTE insert_player
	@PlayerFName = 'Christian',
	@PlayerLName = 'Pulisic',
	@PlayerDOB = '2015-08-01',
	@PlayerEmail = 'cp@yahoo.com',
	@TeamName = 'Team3';

/*
Rule #2: At least two people need to be on a team for them to get results for a team
Justification: In order to compete as a team, there should be more than one person on that team. 
*/

GO 
CREATE OR ALTER FUNCTION fn_team_number()
RETURNS INT
AS 
BEGIN
DECLARE @ret INT = 0
IF EXISTS (SELECT * FROM tblTEAMS t
           JOIN tblPLAYERS p ON t.TeamID = p.TeamID
		   JOIN tblPLAYER_RESULTS AS pr ON p.PlayerID = pr.PlayerID
		   JOIN tblRESULTS AS r ON pr.ResultID = r.ResultID
           GROUP BY t.TeamID
           HAVING COUNT(p.PlayerID) < 2)
SET @ret = 1
RETURN @ret
END
GO

ALTER TABLE tblrESULTS
DROP CONSTRAINT chk_team_number

ALTER TABLE tblPlayer_Results WITH NOCHECK
ADD CONSTRAINT chk_team_number
CHECK(dbo.fn_team_number() = 0)

-- test constraint function
EXEC insert_team @teamName = 'Team4';

EXECUTE insert_player
	@PlayerFName = 'Taylor',
	@PlayerLName = 'Swift',
	@PlayerDOB = '01-12-2000',
	@PlayerEmail = 'tswift@gmail.com',
	@TeamName = 'Team4';

EXECUTE insert_player_result
	@PlayerFName = 'Taylor',
	@PlayerLName = 'Swift',
	@PlayerEmail = 'tswift@gmail.com',
	@PlayerDOB = '01-12-2000',
	@result = 'Draw',
	@arenaName = 'Mushroom Kingdom II',
	@characterName = 'Peach';

/*
BUSINESS RULES: ERIN MORALES
*/

/*
Rule #3: Each special attack can only be associated with one character
Justification: In the games each character has a unique special attack only associated with them
*/
GO
CREATE OR ALTER FUNCTION restrict_special_attack()
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
IF EXISTS (SELECT * FROM tblSPECIAL_ATTACK sa
           JOIN tblCHARACTERS c ON c.AttackID = sa.AttackID
           GROUP BY sa.AttackID
           HAVING COUNT(c.CharacterID) > 1)
SET @ret = 1
RETURN @ret
END
GO
 
ALTER TABLE tblCharacters WITH NOCHECK
ADD CONSTRAINT chk_restrict_special_attack
CHECK(dbo.restrict_special_attack() = 0)

-- test constraint function
EXECUTE insert_character
	@CharName = 'Mario',
	@TierLetter = 'B',
	@AttackName = 'Giant Punch'

/*
Rule #4: Tiers can only be S, A, B, C, D, and F
Justification: The game was designed with these specific tiers and reasoning for placing each 
			   character in a tier. Adding new tiers would disrupt the balance and logic in the game
*/
 
GO
CREATE OR ALTER FUNCTION fn_tier()
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
IF EXISTS (SELECT * FROM tblTIER
           WHERE (TierRankLetter != 'S'
           OR TierRankLetter != 'A'
           OR TierRankLetter != 'B'
           OR TierRankLetter != 'C'
           OR TierRankLetter != 'D'
           OR TierRankLetter != 'F'))
SET @ret = 1
RETURN @ret
END
GO
 
ALTER TABLE tblTIER WITH NOCHECK
ADD CONSTRAINT chk_tier
CHECK(dbo.fn_tier() = 0)
 
-- test constraint
EXECUTE ins_tier
	@tierRankLetter = 'x';


/*
BUSINESS RULES: MINJIE KIM
*/
/*
Rule #5: A song cannot have the word 'alcohol' in it 
Justification: Just trying to make sure that the songs are clean because young kids are playing as well
*/

GO
CREATE OR ALTER FUNCTION fn_song_alcohol()
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
IF EXISTS
  (SELECT * 
   FROM tblMusic AS m
    JOIN tblArenas AS a ON m.ArenaID = a.ArenaID
   WHERE LOWER(SongName) LIKE '%alcohol%')
SET @ret = 1
RETURN @ret
END
GO

ALTER TABLE tblMUSIC WITH NOCHECK
ADD CONSTRAINT chk_music_name
CHECK(dbo.fn_song_alcohol() = 0)

-- test constraint
EXECUTE ins_music @ArenaName = 'Gamer', @SongName = 'Bring the Alcohol';

/*
Rule #6: People must be older than 10 years old to register as a player
Justification: Super Smash Bros is a game that contains violence. As a result, it has a e10+ rating from parents, preventing children younger than 10 from playing.
*/
GO 
CREATE OR ALTER FUNCTION fn_min_age()
RETURNS INT
AS 
BEGIN
DECLARE @ret INT = 0
IF EXISTS (SELECT * FROM tblPLAYERS 
           WHERE datediff(year, PlayerDOB, getDate()) >= 10)
SET @ret = 1
RETURN @ret
END
GO
 
ALTER TABLE tblPLAYERS WITH NOCHECK
ADD CONSTRAINT chk_min_age
CHECK(dbo.fn_min_age() = 0)
 
-- test constraint
GO 
EXECUTE insert_player
	@PlayerFName = 'Piglet',
	@PlayerLName = 'Pig',
	@PlayerDOB = '12-3-2022',
	@PlayerEmail = 'piglet@yahoo.com',
	@TeamName = 'Team1'

/*
COMPLEX QUERIES: MINJIE KIM
*/
--find the character that was played the most
SELECT TOP 1 c.CharacterName
FROM tblResults AS r  
  JOIN tblCharacters AS c ON c.CharacterID = r.CharacterID
WHERE r.Result = 'WIN'
GROUP BY c.CharacterID, c.CharacterName
ORDER BY COUNT(c.CharacterID) DESC;

--parameterized report of player and result 
GO 
CREATE OR ALTER PROCEDURE get_player_results
	@PlayerFName VARCHAR(50),
	@PlayerLName VARCHAR(50),
	@PlayerEmail VARCHAR(80)
AS
	SELECT CONCAT(p.PlayerFName, ' ', p.PlayerLName) AS Player_Name, 
		   SUM(case when LOWER(r.Result) = 'win' then 1 else 0 end) AS Wins, 
		   SUM(case when LOWER(r.Result) = 'lose' then 1 else 0 end) AS Losses, 
		   SUM(case when LOWER(r.Result) = 'draw' then 1  else 0 end) AS Draws
	FROM tblPLAYERS AS p 
		JOIN tblPLAYER_RESULTS AS pr ON pr.PlayerID = p.PlayerID
		JOIN tblRESULTS AS r ON r.ResultID = pr.ResultID
	WHERE p.PlayerFName = @PlayerFName	
		AND p.PlayerLName = @PlayerLName
		AND p.PlayerEmail = @PlayerEmail
	GROUP BY p.PlayerFName, p.PlayerLName;
GO

EXECUTE get_player_results 
	@PlayerFName = 'Mickey',
	@PlayerLName = 'Mouse',
	@PlayerEmail = 'mickeymouse@gmail.com';

/*
COMPLEX QUERIES: JESSICA HWEE
*/
-- find all characters with a weakness with the letter a and a strength with the letter b 
 
(SELECT * 
FROM tblCHARACTERS c 
JOIN tblCHARACTER_WEAKNESS cw ON c.CharacterID = cw.CharacterID
JOIN tblWEAKNESSES w ON cw.WeaknessID = w.WeaknessID
WHERE w.WeaknessName LIKE '%a%')
UNION 
(SELECT * 
FROM tblCHARACTERS c 
JOIN tblCHARACTER_STRENGTH cs ON c.CharacterID = cs.CharacterID
JOIN tblSTRENGTHS s ON s.StrengthID = cs.StrengthID
WHERE s.StrengthName LIKE '%b%')
 
 
-- parameterized report of the character's tier and special attack
GO 
CREATE OR ALTER PROCEDURE get_character_tier @charName VARCHAR(50), @tier VARCHAR(2), @attackName VARCHAR(30)
AS
	SELECT c.CharacterName, t.TierRankLetter, a.AttackName, a.AttackDescription
	FROM tblCHARACTERS c
	JOIN tblTIER t ON c.TierID = t.TierID
	JOIN tblSPECIAL_ATTACK a ON c.AttackID = a.AttackID
	WHERE c.CharacterName = @charName
	AND t.TierRankLetter = @tier
	AND a.AttackName = @attackName
GO
 
EXECUTE get_character_tier @charName = 'Mario', @tier = 'B', @attackName = 'Fireball';

/*
COMPLEX QUERIES: ERIN MORALES
*/

--find the top player who is over the age of 13
 
SELECT TOP 1 p.PlayerFName, p.PlayerLName
FROM tblPlayers p  
	JOIN tblPlayer_Results pr ON p.PlayerID = pr.PlayerID
	JOIN tblResults r ON pr.ResultID = r.ResultID
WHERE r.Result = 'WIN' 
	AND ABS(DATEDIFF(year, GETDATE(), p.PlayerDOB)) > 13
GROUP BY p.PlayerID, p.PlayerFName, p.PlayerLName
ORDER BY COUNT(pr.ResultID) DESC
 
-- top character for each player
SELECT p.PlayerFName, p.PlayerLName, c.CharacterName, 
(SELECT TOP 1 COUNT(c.CharacterID)
FROM tblPLAYERS p 
JOIN tblPLAYER_RESULTS pr ON p.PlayerID = pr.PlayerID
JOIN tblRESULTS r ON pr.ResultID = r.ResultID
JOIN tblCHARACTERS c ON r.CharacterID = c.CharacterID
GROUP BY p.PlayerID) AS characterNum
FROM tblCHARACTERS c 
JOIN tblRESULTS r ON c.CharacterID = r.CharacterID
JOIN tblPLAYER_RESULTS pr ON r.ResultID = pr.ResultID
JOIN tblPLAYERS p ON pr.PlayerID = p.PlayerID
ORDER BY characterNum DESC
