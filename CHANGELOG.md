# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [0.2.0] - 2025-01-16

### Added
- Core domain objects: Player, Team, Conference, Division, Position
- Collection class for handling groups of objects
- Client and Connection classes for API access
- Utility functions for common operations
- Full test coverage with Minitest
- Mutation testing with Mutant
- Type checking with Steep
- Documentation with YARD
- Code quality checks with RuboCop and Standard
- Uses Shale for JSON mapping
- Uses Equalizer for object equality

#### Command-Line Interface
- `nba` CLI tool for quick access to NBA data from the terminal
- Commands: `games`, `teams`, `player`, `standings`, `leaders`, `schedule`, `roster`
- Date filtering, conference filtering, and season selection options

#### Player Endpoints
- `CommonPlayerInfo` - Detailed player biography and career info
- `PlayerIndex` - Search and list all players
- `PlayerCareerStats` - Season-by-season career statistics
- `PlayerGameLog` / `PlayerGameLogs` - Game-by-game player stats
- `PlayerNextNGames` - Upcoming games for a player
- `PlayerProfileV2` - Comprehensive player profile data
- `PlayerAwards` - Career awards and accolades
- `PlayerCompare` - Head-to-head player comparisons
- `PlayerDashboard` - Player dashboard statistics
- `PlayerEstimatedMetrics` - Advanced estimated metrics (EPM, etc.)
- `PlayerGameStreakFinder` - Find player game streaks
- `PlayerDashPtPass` - Player tracking passing stats
- `PlayerDashPtReb` - Player tracking rebounding stats
- `PlayerDashPtShotDefend` - Player tracking defensive stats
- `PlayerDashPtShots` - Player tracking shooting stats
- `PlayerFantasyProfileBarGraph` - Fantasy basketball profile
- `PlayerVsPlayer` - Player vs player matchup stats
- `PlayerCareerByCollege` / `PlayerCareerByCollegeRollup` - Stats by college

#### Team Endpoints
- `TeamDetails` - Team info including arena, owner, GM, coach
- `TeamDashboard` - Team dashboard statistics
- `TeamInfoCommon` - Common team information and season ranks
- `TeamEstimatedMetrics` - Advanced team metrics
- `TeamHistoricalLeaders` - All-time team statistical leaders
- `TeamGameStreakFinder` - Find team game streaks
- `TeamDashPtPass` - Team tracking passing stats
- `TeamDashPtReb` - Team tracking rebounding stats
- `TeamDashPtShots` - Team tracking shooting stats
- `TeamPlayerDashboard` - Player stats within team context
- `TeamPlayerOnOffDetails` / `TeamPlayerOnOffSummary` - On/off court analysis
- `TeamVsPlayer` - Team performance vs specific players
- `TeamAndPlayersVsPlayers` - Team and players vs players matchups
- `TeamGameLog` / `TeamGameLogs` - Game-by-game team stats
- `TeamYearByYearStats` - Historical team stats by season
- `CommonTeamYears` - Team history timeline

#### Box Score Endpoints
- `BoxScoreTraditional` / `BoxScoreTraditionalV3` - Traditional stats
- `BoxScoreAdvanced` / `BoxScoreAdvancedV3` - Advanced stats (eFG%, TS%, etc.)
- `BoxScoreScoring` / `BoxScoreScoringV3` - Scoring breakdown
- `BoxScoreMisc` / `BoxScoreMiscV3` - Miscellaneous stats
- `BoxScoreUsage` / `BoxScoreUsageV3` - Usage rate stats
- `BoxScoreFourFactors` / `BoxScoreFourFactorsV3` - Four factors analysis
- `BoxScoreHustle` - Hustle stats (deflections, loose balls, etc.)
- `BoxScoreDefensiveV2` - Defensive statistics
- `BoxScorePlayerTrack` - Player tracking data (speed, distance, touches)
- `BoxScoreSummaryV2` / `BoxScoreSummaryV3` - Comprehensive game summaries
- `BoxScoreMatchupsV3` - Player matchup statistics
- `BoxScoreSimilarityScore` - Historical game similarity
- `HustleStatsBoxScore` - Detailed hustle box scores

#### League-Wide Endpoints
- `LeagueDashTeamStats` - League-wide team statistics
- `LeagueDashPlayerStats` - League-wide player statistics
- `LeagueDashLineups` - Lineup statistics across the league
- `LeagueDashPlayerBioStats` - Player biographical statistics
- `LeagueDashPlayerClutch` - Player clutch performance stats
- `LeagueDashTeamClutch` - Team clutch performance stats
- `LeagueDashPlayerPtShot` - Player tracking shot stats
- `LeagueDashTeamPtShot` - Team tracking shot stats
- `LeagueDashOppPtShot` - Opponent tracking shot stats
- `LeagueDashPlayerShotLocations` - Shot location breakdowns by player
- `LeagueDashTeamShotLocations` - Shot location breakdowns by team
- `LeagueDashPtDefend` - Player tracking defensive stats
- `LeagueDashPtTeamDefend` - Team tracking defensive stats
- `LeagueDashPtStats` - Player tracking general stats
- `LeagueLineupViz` - Lineup visualization data
- `LeaguePlayerOnDetails` - On-court impact details
- `LeagueSeasonMatchups` - Season matchup statistics
- `LeagueGameLog` - League-wide game logs
- `LeagueGameFinder` - Search for games by criteria
- `LeagueHustleStatsPlayer` / `LeagueHustleStatsTeam` - League hustle stats
- `LeagueStandings` - Detailed league standings

#### Standings & Leaders
- `Standings` - Conference and division standings
- `Leaders` - Current season statistical leaders
- `AllTimeLeaders` - All-time career statistical leaders
- `AssistLeaders` / `AssistTracker` - Assist-specific leaderboards
- `HomePageLeaders` / `LeadersTiles` - Home page leader data
- `ISTStandings` - In-Season Tournament standings
- `FranchiseLeaders` - Franchise all-time leaders
- `FranchiseHistory` - Franchise historical records
- `FranchisePlayers` - Players in franchise history

#### Game & Schedule
- `Games` / `Scoreboard` / `ScoreboardV3` - Today's games and scores
- `LiveScoreboard` - Real-time live game data
- `Schedule` / `ScheduleInternational` - Team and league schedules
- `GameRotation` - Player rotation data per game
- `PlayByPlay` / `PlayByPlayV3` - Play-by-play game data
- `LivePlayByPlay` - Real-time play-by-play
- `LiveBoxScore` - Real-time box scores
- `WinProbability` - In-game win probability

#### Shot Chart
- `ShotChart` - Individual player shot charts
- `ShotChartLeagueWide` - League-wide shot data
- `ShotChartLineupDetail` - Lineup-specific shot charts

#### Draft
- `DraftHistory` - Historical draft picks
- `DraftBoard` - Draft board data
- `DraftCombineStats` - Combine statistical results
- `DraftCombineSpotShooting` - Spot shooting drill results
- `DraftCombineDrillResults` - Agility and strength drills
- `DraftCombineNonStationaryShooting` - Non-stationary shooting
- `DraftCombinePlayerAnthro` - Anthropometric measurements

#### Video
- `VideoDetails` / `VideoDetailsAsset` - Video metadata and assets
- `VideoEvents` / `VideoEventsAsset` - Event-based video clips
- `VideoStatus` - Video availability status

#### Playoffs
- `CommonPlayoffSeries` - Playoff series information
- `PlayoffPicture` - Current playoff picture

#### Synergy & Advanced
- `SynergyPlayTypes` - Synergy play type statistics

#### Cumulative Stats
- `CumeStatsPlayer` / `CumeStatsPlayerGames` - Cumulative player stats
- `CumeStatsTeam` / `CumeStatsTeamGames` - Cumulative team stats

#### Other Features
- `DefenseHub` - Defensive statistics hub
- `FantasyWidget` - Fantasy basketball widget data
- `HomePageV2` - NBA.com home page data
- `MatchupsRollup` - Matchup summary data
- `InfographicFanDuelPlayer` - FanDuel player data
- `DunkScoreLeaders` - Dunk score leaderboards
- `Static` - Static reference data

#### Infrastructure
- `LiveConnection` - Real-time API connection for live data
- `ResponseParser` - Centralized response parsing
- Predicate methods for boolean-like API responses
- Support for multiple API response formats (v2/v3 endpoints)

[0.2.0]: https://github.com/sferik/nba-ruby/releases/tag/v0.2.0
