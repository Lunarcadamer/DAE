CREATE DATABASE  IF NOT EXISTS `assignment1` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `assignment1`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: assignment1
-- ------------------------------------------------------
-- Server version	5.7.12-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `gameID` int(11) NOT NULL,
  `commenter` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  `comment` varchar(100) NOT NULL,
  `rating` int(1) NOT NULL,
  PRIMARY KEY (`gameID`,`date`),
  CONSTRAINT `game_to_comment` FOREIGN KEY (`gameID`) REFERENCES `game` (`gameID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (2,'Mr Kappa','2016-05-20 15:03:54','Game is bad Kappa',5),(3,'Bob','2016-05-20 15:02:23','Why is the guy so handsome',5),(3,'Mr Ma','2016-05-20 15:02:37','This game seems good',5),(3,'Mr Smelly','2016-05-20 15:02:46','I don\'t like this game',1),(3,'s4dotaLUL','2016-05-20 15:05:02','s4dotaLUL',5),(4,'Adam Jensen','2016-05-20 15:03:10','4Head',5),(8,'Bobby','2016-05-20 15:04:16','Fun game I like',5);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game` (
  `gameID` int(11) NOT NULL AUTO_INCREMENT,
  `gameTitle` varchar(45) NOT NULL,
  `company` varchar(45) NOT NULL,
  `releaseDate` date DEFAULT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `imageLocation` varchar(50) DEFAULT NULL,
  `preOwned` tinyint(1) NOT NULL,
  PRIMARY KEY (`gameID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,'Assassins\'s Creed Syndicate','Ubisoft','2015-10-23','<p>London, 1868. In the heart of the Industrial Revolution, lead your underworld organization and grow your influence to fight those who exploit the less privileged in the name of progress: </p> ',59.9,'images/game-covers/ACSyndicate.jpg',0),(2,'Batman Arkham Knight','WB Games','2015-06-23','<p> Batman: Arkham Knight brings the award-winning Arkham trilogy from Rocksteady Studios to its epic conclusion. Developed exclusively for New-Gen platforms, Batman: Arkham Knight introduces Rocksteady\'s uniquely designed version of the Batmobile. The highly anticipated addition of this legendary vehicle, combined with the acclaimed gameplay of the Arkham series, offers gamers the ultimate and complete Batman experience as they tear through the streets and soar across the skyline of the entirety of Gotham City. In this explosive finale, Batman faces the ultimate threat against the city that he is sworn to protect, as Scarecrow returns to unite the super criminals of Gotham and destroy the Batman forever. Product Features: </p> <p> \"Be The Batman\" - Live the complete Batman experience as the Dark Knight enters the concluding chapter of Rocksteady\'s Arkham trilogy. Players will become The World\'s Greatest Detective like never before with the introduction of the Batmobile and enhancements to signature features such as FreeFlow Combat, stealth, forensics and navigation. </p> <p> Introducing the Batmobile - The Batmobile is brought to life with a completely new and original design featuring a distinct visual appearance and a full range of on-board high-tech gadgetry. Designed to be fully drivable throughout the game world and capable of transformation from high speed pursuit mode to military grade battle mode, this legendary vehicle sits at the heart of the game\'s design and allows players to tear through the streets at incredible speeds in pursuit of Gotham City\'s most dangerous villains. This iconic vehicle also augments Batman\'s abilities in every respect, from navigation and forensics to combat and puzzle solving creating a genuine and seamless sense of the union of man and machine. </p> <p> The Epic Conclusion to Rocksteady\'s Arkham Trilogy - Batman: Arkham Knight brings all-out war to Gotham City. The hit-and-run skirmishes of Batman: Arkham Asylum, which escalated into the devastating conspiracy against the inmates in Batman: Arkham City, culminates in the ultimate showdown for the future of Gotham. At the mercy of Scarecrow, the fate of the city hangs in the balance as he is joined by the Arkham Knight, a completely new and original character in the Batman universe, as well as a huge roster of other infamous villains including Harley Quinn, The Penguin, Two-Face and the Riddler. </p> <p> Explore the entirety of Gotham City - For the first time, players have the opportunity to explore all of Gotham City in a completely open and free-roaming game world. More than five times that of Batman: Arkham City, Gotham City has been brought to life with the same level of intimate, hand-crafted attention to detail for which the Arkham games are known. </p> <p> Most Wanted Side Missions - Players can fully immerse themselves in the chaos that is erupting in the streets of Gotham. Encounters with high-profile criminal masterminds are guaranteed while also offering gamers the opportunity to focus on and takedown individual villains or pursue the core narrative path. </p> <p> New Combat and Gadget Features - Gamers have at their disposal more combat moves and high-tech gadgetry than ever before. The new \'gadgets while gliding\' ability allows Batman to deploy gadgets such as batarangs, the grapnel gun or the line launcher mid-glide while Batman\'s utility belt is once again upgraded to include all new gadgets that expand his range of forensic investigation, stealth incursion and combat skills. </p>',59.9,'images/game-covers/BatmanArkhamKnight.jpg',0),(3,'Battlefield 1','EA','2016-10-21','<p>Battlefield 1 is a first-person shooter. It is set in the period of World War I, and will be inspired by historical events.</p>',69.9,'images/game-covers/Battlefield1.jpg',0),(4,'Deus Ex, Mankind Divided','Square Enix','2016-08-23','<p>The year is 2029, and mechanically augmented humans have now been deemed outcasts, living a life of complete and total segregation from the rest of society.</p> ',69.9,'images/game-covers/DeusExMankindDivided.jpg',0),(5,'Dishonored','Bethesda','2012-10-09','<p>Dishonored is an immersive first-person action game that casts you as a supernatural assassin driven by revenge. With Dishonored\'s flexible combat system, creatively eliminate your targets as you combine the supernatural abilities, weapons and unusual gadgets at your disposal. Pursue your enemies under the cover of darkness or ruthlessly attack them head on with weapons drawn. The outcome of each mission plays out based on the choices you make. </p> <p>Story: Dishonored is set in Dunwall, an industrial whaling city where strange steampunk- inspired technology and otherworldly forces coexist in the shadows. You are the once-trusted bodyguard of the beloved Empress. Framed for her murder, you become an infamous assassin, known only by the disturbing mask that has become your calling card. In a time of uncertainty, when the city is besieged by plague and ruled by a corrupt government armed with industrial technologies, dark forces conspire to bestow upon you abilities beyond those of any common man - but at what cost? The truth behind your betrayal is as murky as the waters surrounding the city, and the life you once had is gone forever. </p> <p>Key features:</p> <p>Improvise and Innovate Approach each assassination with your own style of play. Use shadow and sound to your advantage to make your way silently through levels unseen by foes, or attack enemies head-on as they respond to your aggression. The flexible combat system allows you to creatively combine your abilities, supernatural powers and gadgets as you make your way through the levels and dispatch your targets. Improvise and innovate to define your play style. </p> <p>Action with Meaning The world of Dishonored reacts to how you play. Move like a ghost and resist corruption, or show no mercy and leave a path of destruction in your wake. Decide your approach for each mission, and the outcomes will change as a result. </p> <p>Supernatural Abilities Teleport for stealth approaches, possess any living creature, or stop time itself to orchestrate unearthly executions! Combining your suite of supernatural abilities and weapons opens up even more ways to overcome obstacles and eliminate targets. The game’s upgrade system allows for the mastery of deadly new abilities and devious gadgets. </p> <p>A City Unlike Any Other Enter an original world envisioned by Half-Life 2 art director Viktor Antonov. Arkane and Bethesda bring you a steampunk city where industry and the supernatural collide, creating an atmosphere thick with intrigue. The world is yours to discover. </p>',29.9,'images/game-covers/Dishonored.jpg',1),(6,'Fallout 4','Bethesda','2015-11-10','<p>Bethesda Game Studios, the award-winning creators of Fallout 3 and The Elder Scrolls V: Skyrim, welcome you to the world of Fallout 4 - their most ambitious game ever, and the next generation of open-world gaming. As the sole survivor of Vault 111, you enter a world destroyed by nuclear war. Every second is a fight for survival, and every choice is yours. Only you can rebuild and determine the fate of the Wasteland. Welcome home. </p> <p>Key Features: </p> <p>Freedom and Liberty! : Do whatever you want in a massive open world with hundreds of locations, characters, and quests. Join multiple factions vying for power or go it alone, the choices are all yours. </p> <p>You\'re S.P.E.C.I.A.L! : Be whoever you want with the S.P.E.C.I.A.L. character system. From a Power Armored soldier to the charismatic smooth talker, you can choose from hundreds of Perks and develop your own playstyle. </p> <p>Super Deluxe Pixels! : An all-new next generation graphics and lighting engine brings to life the world of Fallout like never before. From the blasted forests of the Commonwealth to the ruins of Boston, every location is packed with dynamic detail. </p> <p>Violence and V.A.T.S.! : Intense first or third person combat can also be slowed down with the new dynamic Vault-Tec Assisted Targeting System (V.A.T.S) that lets you choose your attacks and enjoy cinematic carnage. </p> <p>Collect and Build! : Collect, upgrade, and build thousands of items in the most advanced crafting system ever. Weapons, armor, chemicals, and food are just the beginning - you can even build and manage entire settlements. </p>',59.9,'images/game-covers/Fallout4.jpg',1),(7,'Halo 5','Microsoft','2015-10-27','<p>Halo 5: Guardians takes place in the year 2558, and is set eight months after the events of Halo 4. The game follows the human fireteams Blue Team and Fireteam Osiris.</p>',59.9,'images/game-covers/Halo5.jpg',1),(8,'Overwatch','Blizzard','2016-05-24','<p>Overwatch features squad-based combat with two opposing teams of six players each. Players choose one of several hero characters, each with their own unique abilities and role classes.</p>',39.9,'images/game-covers/Overwatch.jpg',0),(9,'Tom Clancy\'s Rainbow Six Siege','Ubisoft','2015-12-01','<p>Tom Clancy\'s Rainbow Six Siege is the upcoming installment of the acclaimed first-person shooter franchise developed by the renowned Ubisoft Montreal studio. </p> <p>Tom Clancy\'s Rainbow Six Siege invites players to master the art of destruction. Intense close quarters confrontations, high lethality, tactics, team play, and explosive action are at the center of the experience. The gameplay sets a new bar for intense firefights and expert strategy in the rich legacy of past Tom Clancy\'s Rainbow Six games.</p> <p>Key Features: </p> <p>THE SIEGE GAMEPLAY : For the first time in Rainbow Six, players will engage in sieges, a brand-new style of assault. Enemies now have the means to transform their environments into strongholds: they can trap, fortify, and create defensive systems to prevent breach by Rainbow teams. To face this challenge, players have a level of freedom unrivaled by any previous Rainbow Six game. Combining tactical maps, observation drones, and a new rappel system, Rainbow teams have more options than ever before to plan, attack, and diffuse these situations. </p> <p>COUNTER TERRORIST UNITS : Counter terrorist operatives are trained to handle extreme situations, such as hostage rescue, with surgical precision. As \"short range\" specialists, their training is concentrated on indoor environments. Operating in tight formations, they are experts of close quarter combat, demolition, and coordinated assaults. Rainbow Six Siege will include operators coming from five of the most worldwide renowned CTU: the British SAS, the American SWAT, the French GIGN, the German GSG9 and the Russian SPETSNAZ. These Operators are specialists with their own expertise within Siege operations. Each has their own unique personality & specialty. Some are focused on assault where as others are defense-oriented. They can be combined within the same team to create new team strategies. </p> <p>PROCEDURAL DESTRUCTION : Destruction is at the heart of the siege gameplay. Players now have the unprecedented ability to destroy environments. Walls can be shattered, opening new lines of fire, and ceiling and floors can be breached, creating new access points. Everything in the environment reacts realistically, dynamically, and uniquely based on the size and caliber of bullets you are using or the amount of explosives you have set. In Rainbow Six Siege, destruction is meaningful and mastering it is often the key to victory. </p>',59.9,'images/game-covers/RainbowSixSiege.jpg',1),(10,'Ace Of Seafood','Nussoft','2016-04-08','<p>It is the future. The human mind is separate from the body, but has not yet forgotten forms of life.</p>',10,'null',0);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_genre`
--

DROP TABLE IF EXISTS `game_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_genre` (
  `genreID` int(11) NOT NULL,
  `gameID` int(11) NOT NULL,
  PRIMARY KEY (`genreID`,`gameID`),
  KEY `gameID_idx` (`gameID`),
  CONSTRAINT `game_to_genre` FOREIGN KEY (`gameID`) REFERENCES `game` (`gameID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `genre_to_game` FOREIGN KEY (`genreID`) REFERENCES `genre` (`genreID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_genre`
--

LOCK TABLES `game_genre` WRITE;
/*!40000 ALTER TABLE `game_genre` DISABLE KEYS */;
INSERT INTO `game_genre` VALUES (2,1),(3,1),(6,1),(3,2),(5,3),(1,4),(3,4),(4,4),(6,4),(2,5),(3,5),(4,5),(6,5),(7,5),(1,6),(2,6),(3,6),(4,6),(1,7),(3,7),(5,7),(1,8),(3,8),(5,8),(3,9),(5,9),(8,9),(3,10),(11,10);
/*!40000 ALTER TABLE `game_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre` (
  `genreID` int(11) NOT NULL AUTO_INCREMENT,
  `genreName` varchar(50) NOT NULL,
  PRIMARY KEY (`genreID`),
  UNIQUE KEY `genreName_UNIQUE` (`genreName`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (3,'Action'),(2,'Adventure'),(7,'Fantasy'),(5,'FPS'),(9,'Horror'),(11,'Open-Sea'),(12,'Open-World'),(10,'Platformer'),(4,'RPG'),(1,'Sci-Fi'),(6,'Stealth'),(8,'Strategy');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `username` varchar(45) NOT NULL,
  `password` char(64) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('administrator','9153cae78e7f43377a079644f24ff39ebb82ce481e08f09732d1009bd01ad159');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-21 20:14:35
