-- Solution proposal by @zeornelas on github

-- Assuming the library is compiled with foreign key constraints enabled, it must still be enabled by the application at runtime
PRAGMA foreign_keys = ON;

CREATE TABLE person (
    id integer PRIMARY KEY AUTOINCREMENT,
    name text NOT NULL,
    address text
);

CREATE TABLE waiter (
    id integer PRIMARY KEY REFERENCES person,
    identifier integer NOT NULL UNIQUE,
    phone text NOT NULL
);

CREATE TABLE client (
    id integer PRIMARY KEY REFERENCES person,
    tax_id integer NOT NULL UNIQUE
);


CREATE TABLE ingredient (
    name text PRIMARY KEY,
    unit text NOT NULL,
    stock integer NOT NULL CHECK(stock > 0)
);

CREATE TABLE tables (
    id integer PRIMARY KEY AUTOINCREMENT,
    capacity integer NOT NULL CHECK(capacity > 0)
);

CREATE TABLE meal (
    id integer PRIMARY KEY AUTOINCREMENT,
    date text NOT NULL,
    start_time text NOT NULL,
    end_time text,
    served_to integer NOT NULL REFERENCES client,
    served_by integer NOT NULL REFERENCES waiter,
    table_num integer NOT NULL REFERENCES tables,
    CHECK(time(start_time) < time(end_time) OR end_time IS NULL)
);

CREATE TABLE dish (
    id integer PRIMARY KEY AUTOINCREMENT,
    name text NOT NULL UNIQUE
);

CREATE TABLE ingredientInDish (
    dish integer NOT NULL REFERENCES dish DEFERRABLE INITIALLY DEFERRED,
    ingredient text NOT NULL REFERENCES ingredient,
    quantity integer NOT NULL CHECK(quantity > 0),
    PRIMARY KEY (dish, ingredient)
);

CREATE TABLE dishesInMeal (
    dish integer NOT NULL REFERENCES dish,
    meal integer NOT NULL REFERENCES meal,
    quantity integer NOT NULL CHECK(quantity > 0),
    PRIMARY KEY (dish, meal)
);

-- Before insert trigger that guarantees that a dish has at least one ingredient (enforces 1..*)
CREATE TRIGGER validate_dish_ingredients 
BEFORE INSERT ON dish
WHEN NOT EXISTS (SELECT * FROM ingredientInDish WHERE dish = NEW.id) 
BEGIN
    SELECT RAISE (ABORT,'Dish needs at least one ingridient');
END;

-- After delete trigger that guarantees that a dish is deleted when it's last ingredient is deleted
CREATE TRIGGER delete_dish_after_deleting_last_ingredient
AFTER DELETE ON ingredientInDish
WHEN (SELECT COUNT(*) FROM ingredientInDish WHERE dish = OLD.dish) = 0
BEGIN
    DELETE FROM dish WHERE id = OLD.dish;
END;


-- -- Example
-- INSERT INTO ingredient VALUES ('rice', 'grams', 25);
-- INSERT INTO ingredient VALUES ('duck', 'grams', 500);
-- -- We need to wrap everything in a transaction in order for the 'DEFERRABLE INITIALLY DEFERRED' to be executed
-- -- We start by inserting the elements in the ingredientInDish table and after that we create the dish
-- -- The transaction and 'DEFERRABLE INITIALLY DEFERRED' property allow us to avoid the foreign key rules.
-- BEGIN;
-- INSERT INTO ingredientInDish VALUES (1, 'rice', 5);
-- INSERT INTO ingredientInDish VALUES (1, 'duck', 100);
-- INSERT INTO dish VALUES (1, 'Duck rice');
-- COMMIT;
