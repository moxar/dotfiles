-- rambler up
CREATE TABLE IF NOT EXISTS nodes_tree(
  `id`  INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `lft` INT(10) UNSIGNED DEFAULT NULL,
  `rgt` INT(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `nodes_tree_id_foreign` FOREIGN KEY (`id`) REFERENCES `nodes` (`id`) ON DELETE RESTRICT,
  KEY `nodes_tree_lft_uk` (`lft`),
  KEY `nodes_tree_rgt_uk` (`rgt`)
);

-- rambler down
DROP TABLE IF EXISTS nodes_tree;

-- rambler up
DROP PROCEDURE IF EXISTS seed_nodes_tree_inner_loop;

-- rambler up
CREATE PROCEDURE IF NOT EXISTS seed_nodes_tree_inner_loop()
BEGIN

  -- node to insert, and iterator (left, right) value
  DECLARE node_id INT UNSIGNED DEFAULT 0;
  DECLARE parent_id   INT UNSIGNED DEFAULT NULL;
  DECLARE my_lft      INT UNSIGNED DEFAULT 0;
  DECLARE done        BOOLEAN DEFAULT FALSE;

  -- cursor of the loop
  DECLARE cur CURSOR FOR
  SELECT c.id, c.parent_id
  FROM nodes c
  LEFT JOIN nodes_tree nt ON c.id = nt.id
  WHERE nt.id IS NULL AND (
    c.parent_id IS NULL OR
    c.parent_id IN (SELECT id FROM nodes_tree)
  );
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  -- insertion loop
  OPEN cur;
  insert_loop: LOOP

    FETCH cur INTO node_id, parent_id;
    IF done THEN
       LEAVE insert_loop;
    END IF;

    IF parent_id IS NOT NULL THEN
      SELECT lft FROM nodes_tree WHERE id = parent_id INTO my_lft;
      UPDATE nodes_tree SET lft = lft+2 WHERE lft > my_lft;
      UPDATE nodes_tree SET rgt = rgt+2 WHERE rgt > my_lft;
    END IF;

    INSERT INTO nodes_tree(id, lft, rgt) VALUES (node_id, my_lft+1, my_lft+2);
    SET my_lft = my_lft +2;

  END LOOP;
  CLOSE cur;

END;

-- rambler down
DROP PROCEDURE IF EXISTS seed_nodes_tree_inner_loop;

-- rambler up
DROP PROCEDURE IF EXISTS seed_nodes_tree;

-- rambler up
CREATE PROCEDURE IF NOT EXISTS seed_nodes_tree()
BEGIN

  DECLARE unprocessed INT DEFAULT 0;
  DECLARE z INT DEFAULT 0;

  -- drop and recreate the table, with loose constraints
  TRUNCATE TABLE nodes_tree;

  recursive_loop: LOOP

    SELECT COUNT(*) INTO unprocessed FROM nodes c LEFT JOIN nodes_tree nt ON c.id = nt.id WHERE nt.id IS NULL;
    IF unprocessed = 0 THEN
      LEAVE recursive_loop;
    END IF;

    SET z = z+1;
    IF z = 100 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'error: infinite loop on seed_nodes_tree';
      LEAVE recursive_loop;
    END IF;

    CALL seed_nodes_tree_inner_loop();

  END LOOP;

END;

-- rambler down
DROP PROCEDURE IF EXISTS seed_nodes_tree;

-- rambler up
CREATE TRIGGER IF NOT EXISTS move_node_on_tree AFTER UPDATE ON nodes FOR EACH ROW BEGIN

  IF NOT old.parent_id <=> new.parent_id THEN

    IF new.parent_id IS NULL THEN
      SELECT rgt+1 INTO @new_lft FROM nodes_tree ORDER BY rgt DESC LIMIT 1;
    ELSE
      SELECT lft+1 INTO @new_lft FROM nodes_tree WHERE id = new.parent_id;
    END IF;

    SELECT lft, rgt, rgt - lft + 1  INTO @old_lft, @old_rgt, @width FROM nodes_tree WHERE id = new.id;

    -- create new space for subtree
    UPDATE nodes_tree SET lft = lft + @width WHERE lft >= @new_lft;
    UPDATE nodes_tree SET rgt = rgt + @width WHERE rgt >= @new_lft;

    -- move subtree into new space
    UPDATE nodes_tree SET
      lft = lft + @new_lft - @old_lft,
      rgt = rgt + @new_lft - @old_lft
      WHERE lft >= @old_lft AND rgt <= @old_rgt;

    -- remove old space vacated by subtree
    UPDATE nodes_tree SET lft = lft - @width WHERE lft > @old_rgt;
    UPDATE nodes_tree SET rgt = rgt - @width WHERE rgt > @old_rgt;

  END IF;
END;

-- rambler down
DROP TRIGGER IF EXISTS move_node_on_tree;

-- rambler up
CREATE TRIGGER IF NOT EXISTS add_node_on_tree AFTER INSERT ON nodes FOR EACH ROW BEGIN

  IF new.parent_id IS NOT NULL THEN
    SELECT lft+1 INTO @new_lft FROM nodes_tree WHERE id = new.parent_id;
  ELSE
    SELECT rgt+1 INTO @new_lft FROM nodes_tree ORDER BY rgt DESC LIMIT 1;
  END IF;

  -- create new space for subtree
  UPDATE nodes_tree SET lft = lft + 2 WHERE lft >= @new_lft;
  UPDATE nodes_tree SET rgt = rgt + 2 WHERE rgt >= @new_lft;

  -- insert node
  INSERT INTO nodes_tree (id, lft, rgt) VALUES (new.id, @new_lft, @new_lft+1);

END;

-- rambler down
DROP TRIGGER IF EXISTS add_node_on_tree;

-- rambler up
CREATE TRIGGER IF NOT EXISTS del_node_on_tree AFTER DELETE ON nodes FOR EACH ROW BEGIN

  SELECT lft, rgt, rgt - lft + 1  INTO @old_lft, @old_rgt, @width FROM nodes_tree WHERE id = old.id;

  -- drop old node and children
  DELETE FROM nodes_tree WHERE lft >= @old_lft AND rgt <= @old_rgt;

    -- remove old space vacated by subtree
  UPDATE nodes_tree SET lft = lft - @width WHERE lft > @old_rgt;
  UPDATE nodes_tree SET rgt = rgt - @width WHERE rgt > @old_rgt;

END;

-- rambler down
DROP TRIGGER IF EXISTS del_node_on_tree;

-- rambler up
CALL seed_nodes_tree();

/*
-- Count match if every node is inserted, and every lft and rgt is unique.
SELECT COUNT(DISTINCT id) FROM nodes;
SELECT COUNT(DISTINCT id), COUNT(DISTINCT lft), COUNT(DISTINCT rgt) FROM nodes_tree;

-- A result means an overlap between one lft and one rgt.
SELECT n1.id, n2.id FROM nodes_tree n1 LEFT JOIN nodes_tree n2 ON n1.lft = n2.rgt WHERE n2.id IS NOT NULL;

-- A result means a node with inverted lft and rgt.
SELECT id FROM nodes_tree WHERE lft > rgt;
*/
