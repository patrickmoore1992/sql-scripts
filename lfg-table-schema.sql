DROP TABLE IF EXISTS lfg.user_group_roster;
DROP TABLE IF EXISTS lfg.user_groups;
DROP TABLE IF EXISTS lfg.users;
DROP TABLE IF EXISTS lfg.game_types;

-- User accounts
CREATE TABLE lfg.users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    create_account_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP    
);

-- Seed data for users
INSERT INTO lfg.users (user_id)
VALUES (1),
       (2),
       (3),
       (4),
       (5);

-- Reference table for game types so that there won't be duplicated text values
CREATE TABLE lfg.game_types (
    game_type_id INT PRIMARY KEY AUTO_INCREMENT,
    game_type VARCHAR(50),
    is_enabled TINYINT(1)
);

-- Seed data for game types
INSERT INTO lfg.game_types (game_type, is_enabled)
VALUES ('Dungeons & Dragons', true),
       ('Pathfinder', true),
       ('Misc. Board Games', true);

-- Groups created by users
CREATE TABLE lfg.user_groups (
    group_id INT PRIMARY KEY AUTO_INCREMENT,
    host_user_id INT,
    group_name VARCHAR(200),
    game_type_id INT,
    create_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_user_id) REFERENCES lfg.users(user_id),
    FOREIGN KEY (game_type_id) REFERENCES lfg.game_types(game_type_id)
);

INSERT INTO lfg.user_groups (host_user_id, group_name, game_type_id)
VALUES (1, 'DnD test group', 1),
       (1, 'Pathfinder test group', 2),
       (1, 'Misc. Board Game test group', 3);
       
-- Roster for user-created groups
CREATE TABLE lfg.user_group_roster (
    roster_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    is_host TINYINT(1),
    group_id INT,
    FOREIGN KEY (user_id) REFERENCES lfg.users(user_id),
    FOREIGN KEY (group_id) REFERENCES lfg.user_groups(group_id)
);

INSERT INTO lfg.user_group_roster (user_id, is_host, group_id)
VALUES (1, true, 1),
       (2, false, 1),
       (3, false, 1),
       (4, false, 1),
       (5, false, 1),
       (1, true, 2),
       (3, false, 2),
       (5, false, 2),
       (1, true, 3);
