declare
  l_count number := 1;
  l_username varchar2(100);
  l_password varchar2(100) := 'Oracle_12345';
  l_script clob;
begin
  l_script := '';
  while l_count <= 50 loop
          l_username := 'pl' || l_count;
          l_script := l_script || '
create user ' || l_username || ' identified by ' || l_password || ';
grant dwrole to ' || l_username || ';
alter user ' || l_username || ' quota unlimited on data;
grant create session to ' || l_username || ';
grant create table to ' || l_username || ';
begin
  ords.enable_schema(p_enabled => true,
    p_schema => ''' || l_username || ''',
    p_url_mapping_type => ''BASE_PATH'',
    p_url_mapping_pattern => ''' || l_username || ''',
    p_auto_rest_auth => true);
  commit;
end;
/
CREATE TABLE ' || l_username || '.EVENT
	   (	"ID" NUMBER(38,0), 
		"MATCH_ID" VARCHAR2(26 BYTE), 
		"EVENT_ID" NUMBER(38,0), 
		"TYPE_ID" NUMBER(38,0), 
		"PERIOD_ID" NUMBER(38,0), 
		"TIME_MIN" NUMBER(38,0), 
		"TIME_SEC" NUMBER(38,0), 
		"MATCH_DATE" DATE,
		"TEAM_ID" VARCHAR2(26 BYTE), 
		"X" NUMBER(38,1), 
		"Y" NUMBER(38,1), 
		"PLAYER_ID" VARCHAR2(26 BYTE), 
		"PLAYER_NAME" VARCHAR2(26 BYTE), 
		"PENALTY" VARCHAR2(26 BYTE), 
		"HEAD" VARCHAR2(26 BYTE), 
		"RIGHT_FOOTED" VARCHAR2(26 BYTE), 
		"OTHER_BODY_PART" VARCHAR2(26 BYTE), 
		"REGULAR_PLAY" VARCHAR2(26 BYTE), 
		"FAST_BREAK" VARCHAR2(26 BYTE), 
		"SET_PIECE" VARCHAR2(26 BYTE), 
		"FROM_CORNER" VARCHAR2(26 BYTE), 
		"FREE_KICK" VARCHAR2(26 BYTE), 
		"OWN_GOAL" VARCHAR2(26 BYTE), 
		"ASSISTED" VARCHAR2(26 BYTE), 
		"LEFT_FOOTED" VARCHAR2(26 BYTE), 
		"TARGETED_LOW_LEFT" VARCHAR2(26 BYTE), 
		"TARGETED_HIGH_LEFT" VARCHAR2(26 BYTE), 
		"TARGETED_LOW_CENTER" VARCHAR2(26 BYTE), 
		"TARGETED_HIGH_CENTER" VARCHAR2(26 BYTE), 
		"TARGETED_LOW_RIGHT" VARCHAR2(26 BYTE), 
		"TARGETED_HIGH_RIGHT" VARCHAR2(26 BYTE), 
		"BLOCKED" VARCHAR2(26 BYTE), 
		"TARGETED_CLOSE_LEFT" VARCHAR2(26 BYTE), 
		"TARGETED_CLOSE_RIGHT" VARCHAR2(26 BYTE), 
		"TARGETED_CLOSE_HIGH" VARCHAR2(26 BYTE), 
		"TARGETED_CLOSE_LEFT_AND_HIGH" VARCHAR2(26 BYTE), 
		"TARGETED_CLOSE_RIGHT_AND_HIGH" VARCHAR2(26 BYTE), 
		"PROJECTED_GOAL_MOUTH_Y" VARCHAR2(26 BYTE), 
		"PROJECTED_GOAL_MOUTH_Z" VARCHAR2(26 BYTE), 
		"DEFLECTION" VARCHAR2(26 BYTE), 
		"HIT_WOODWORK" VARCHAR2(26 BYTE), 
		"BIG_CHANCE" VARCHAR2(26 BYTE), 
		"INDIVIDUAL_CHANCE" VARCHAR2(26 BYTE), 
		"HIT_RIGHT_POST" VARCHAR2(26 BYTE), 
		"HIT_LEFT_POST" VARCHAR2(26 BYTE), 
		"HIT_BAR" VARCHAR2(26 BYTE), 
		"OUT_ON_SIDELINE" VARCHAR2(26 BYTE), 
		"KICKOFF" VARCHAR2(26 BYTE), 
		"FIRST_TOUCH" VARCHAR2(26 BYTE), 
		"NOT_ASSISTED" VARCHAR2(26 BYTE), 
		"EVENT_TYPE_NAME" VARCHAR2(10 BYTE), 
		"TEAM_NAME" VARCHAR2(50 BYTE), 
		"IS_GOAL" VARCHAR2(1 BYTE), 
		"GOAL_CNT" NUMBER(1,0), 
		"RESULT" VARCHAR2(20 BYTE), 
		"TEAM_SIDE" VARCHAR2(4 BYTE), 
		"X_REL_PC" NUMBER, 
		"Y_REL_PC" NUMBER, 
		"X_REL_M" NUMBER, 
		"Y_REL_M" NUMBER, 
		"X_REL_M_TEAM" NUMBER, 
		"Y_REL_M_TEAM" NUMBER, 
		"DISTANCE" NUMBER, 
		"DISTANCE_BUCKET" NUMBER, 
		"EVENT_COUNT" NUMBER, 
		"FOOTBALL_PITCH_CELL" VARCHAR2(10 BYTE)
	   );
CREATE TABLE ' || l_username || '.MATCH
	   (	"MATCH_ID" VARCHAR2(26 BYTE), 
		"MATCH_DATE" DATE, 
		"MATCH_TIME" VARCHAR2(26 BYTE), 
		"TEAM_HOME_ID" VARCHAR2(26 BYTE), 
		"TEAM_HOME_NAME" VARCHAR2(26 BYTE), 
		"TEAM_AWAY_ID" VARCHAR2(26 BYTE), 
		"TEAM_AWAY_NAME" VARCHAR2(26 BYTE), 
		"VENUE" VARCHAR2(128 BYTE), 
		"STATUS" VARCHAR2(26 BYTE), 
		"WINNER" VARCHAR2(26 BYTE), 
		"SCORE_HOME" NUMBER(38,0), 
		"SCORE_AWAY" NUMBER(38,0), 
		"NAME" VARCHAR2(100 BYTE), 
		"NAME_DATE" VARCHAR2(100 BYTE)
	   );
CREATE TABLE ' || l_username || '.PREDICT_BY_ANGLE
	   (	"ID" NUMBER, 
		"ANGLE" NUMBER, 
		"PREDICTED_GOAL" VARCHAR2(1 BYTE),
		"XG" NUMBER
	   );
CREATE TABLE ' || l_username || '.XG_MATRIX
	   (	"ID" NUMBER, 
		"X" NUMBER, 
		"Y" NUMBER, 
		"ANGLE" NUMBER, 
		"HEAD" VARCHAR2(1 BYTE),
		"FAST_BREAK" VARCHAR2(1 BYTE),
		"PREDICTED_GOAL" VARCHAR2(1 BYTE),
		"XG" NUMBER, 
		"FOOTBALL_PITCH_CELL" VARCHAR2(10 BYTE)
	   );
CREATE TABLE ' || l_username || '.PLAYER_STATS 
	   (	"PLAYER_ID" VARCHAR2(26 BYTE),
		"PLAYER_NAME" VARCHAR2(26 BYTE),
		"TEAM_NAME" VARCHAR2(50 BYTE),
		"TOTAL_XG" NUMBER, 
		"GOALS" NUMBER, 
		"SHOT_COUNT" NUMBER, 
		"XG_PER_SHOT" NUMBER
	   );';
    l_count := l_count + 1;
  end loop;
  dbms_output.put_line(l_script);
end;
